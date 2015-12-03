//
//  SlideNavigationController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
// https://github.com/aryaxt/iOS-Slide-Menu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SlideNavigationController.h"
#import "SlideNavigationContorllerAnimator.h"

typedef enum {
	PopTypeAll,
	PopTypeRoot
} PopType;

@interface SlideNavigationController() <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint draggingPoint;
@property (nonatomic, assign) Menu lastRevealedMenu;
@property (nonatomic, assign) BOOL menuNeedsLayout;
@property (nonatomic, assign) NSInteger mSlideOffset;
@property (nonatomic, assign) NSInteger mSlideOffsetLeft;
@property (nonatomic, assign) BOOL mLeftMenuEnable;
//@property (nonatomic, strong) UIImageView *mShadowView;

@end

@implementation SlideNavigationController

NSString * const SlideNavigationControllerDidOpen = @"SlideNavigationControllerDidOpen";
NSString * const SlideNavigationControllerDidClose = @"SlideNavigationControllerDidClose";
NSString  *const SlideNavigationControllerDidReveal = @"SlideNavigationControllerDidReveal";

#define MENU_SLIDE_ANIMATION_DURATION .3
#define MENU_QUICK_SLIDE_ANIMATION_DURATION .18
#define MENU_IMAGE @"Menu Filled"
#define MENU_SHADOW_RADIUS 0.5
#define MENU_SHADOW_OPACITY 1
#define MENU_DEFAULT_SLIDE_OFFSET_NORMAL 0
#define MENU_DEFAULT_SLIDE_OFFSET_LEFT 50
#define MENU_FAST_VELOCITY_FOR_SWIPE_FOLLOW_DIRECTION 1200
#define STATUS_BAR_HEIGHT 20
#define NOTIFICATION_USER_INFO_MENU_LEFT @"left"
#define NOTIFICATION_USER_INFO_MENU_RIGHT @"right"
#define NOTIFICATION_USER_INFO_MENU @"menu"

static SlideNavigationController *singletonInstance;

#pragma mark - Initialization -

+ (SlideNavigationController *)sharedInstance
{
	if (!singletonInstance)
		NSLog(@"SlideNavigationController has not been initialized. Either place one in your storyboard or initialize one in code");
	
	return singletonInstance;
}

- (id)init
{
	if (self = [super init])
	{
		[self setup];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		[self setup];
	}
	
	return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
	if (self = [super initWithRootViewController:rootViewController])
	{
		[self setup];
	}
	
	return self;
}

- (void)setup
{
	if (singletonInstance)
		NSLog(@"Singleton instance already exists. You can only instantiate one instance of SlideNavigationController. This could cause major issues");
	
	singletonInstance = self;
    
    if (IS_IPAD)
    {
        self.mSlideOffset = 200;
    }
    else
    {
        self.mSlideOffset = MENU_DEFAULT_SLIDE_OFFSET_NORMAL;
    }
	
	self.landscapeSlideOffset = self.mSlideOffset;
	self.portraitSlideOffset = self.mSlideOffset;
	self.panGestureSideOffset = 0;
	self.avoidSwitchingToSameClassViewController = YES;
	self.enableShadow = YES;
	self.enableSwipeGesture = YES;
	self.delegate = self;
    
    self.mSlideOffsetLeft = MENU_DEFAULT_SLIDE_OFFSET_LEFT;
//    self.mShadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, SCREEN_SIZE.height)];
//    self.mShadowView.image = [UIImage imageNamed:@"Shadow"];
//    self.mShadowView.contentMode = UIViewContentModeScaleToFill;
//    self.mShadowView.backgroundColor = [UIColor clearColor];    
//    self.mShadowView.alpha = 0.0f;
//    self.mShadowView.hidden = YES;
//    [self.view addSubview:self.mShadowView];
//    [self.view bringSubviewToFront:self.mShadowView];
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	// Update shadow size of enabled
	if (self.enableShadow)
		self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    
    // When menu open we disable user interaction
    // When rotates we want to make sure that userInteraction is enabled again
    [self enableTapGestureToCloseMenu:NO];
    
    if (self.menuNeedsLayout)
    {
        [self updateMenuFrameAndTransformAccordingToOrientation];
        
        // Handle different horizontal/vertical slideOffset during rotation
        // On iOS below 8 we just close the menu, iOS8 handles rotation better so we support keepiong the menu open
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && [self isMenuOpen])
        {
            Menu menu = (self.horizontalLocation > 0) ? MenuLeft : MenuRight;
            [self openMenu:menu withDuration:0 andCompletion:nil];
        }
        
        self.menuNeedsLayout = NO;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    self.menuNeedsLayout = YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    self.menuNeedsLayout = YES;
}

#pragma mark - Public Methods -

- (void)bounceMenu:(Menu)menu withCompletion:(void (^)())completion
{
	[self prepareMenuForReveal:menu];
	NSInteger movementDirection = (menu == MenuLeft) ? 1 : -1;
	
	[UIView animateWithDuration:.16 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		[self moveHorizontallyToLocation:30*movementDirection];
	} completion:^(BOOL finished){
		[UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
			[self moveHorizontallyToLocation:0];
		} completion:^(BOOL finished){
			[UIView animateWithDuration:.12 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
				[self moveHorizontallyToLocation:16*movementDirection];
			} completion:^(BOOL finished){
				[UIView animateWithDuration:.08 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
					[self moveHorizontallyToLocation:0];
				} completion:^(BOOL finished){
					[UIView animateWithDuration:.08 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
						[self moveHorizontallyToLocation:6*movementDirection];
					} completion:^(BOOL finished){
						[UIView animateWithDuration:.06 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
							[self moveHorizontallyToLocation:0];
						} completion:^(BOOL finished){
							if (completion)
								completion();
						}];
					}];
				}];
			}];
		}];
	}];
}

- (void)switchToViewController:(UIViewController *)viewController
		 withSlideOutAnimation:(BOOL)slideOutAnimation
					   popType:(PopType)poptype
				 andCompletion:(void (^)())completion
{
	if (self.avoidSwitchingToSameClassViewController && [self.topViewController isKindOfClass:viewController.class])
	{
		[self closeMenuWithCompletion:completion];
		return;
	}
	
	void (^switchAndCallCompletion)(BOOL) = ^(BOOL closeMenuBeforeCallingCompletion) {
		if (poptype == PopTypeAll) {
			[self setViewControllers:@[viewController]];
		}
		else {
			[super popToRootViewControllerAnimated:NO];
			[super pushViewController:viewController animated:NO];
		}
		
		if (closeMenuBeforeCallingCompletion)
		{
			[self closeMenuWithCompletion:^{
				if (completion)
					completion();
			}];
		}
		else
		{
			if (completion)
				completion();
		}
	};
	
	if ([self isMenuOpen])
	{
		if (slideOutAnimation)
		{
			[UIView animateWithDuration:(slideOutAnimation) ? MENU_SLIDE_ANIMATION_DURATION : 0
								  delay:0
								options:UIViewAnimationOptionCurveEaseOut
							 animations:^{
								 CGFloat width = self.horizontalSize;
								 CGFloat moveLocation = (self.horizontalLocation> 0) ? width : -1*width;
								 [self moveHorizontallyToLocation:moveLocation];
							 } completion:^(BOOL finished) {
								 switchAndCallCompletion(YES);
							 }];
		}
		else
		{
			switchAndCallCompletion(YES);
		}
	}
	else
	{
		switchAndCallCompletion(NO);
	}
}

- (void)switchToViewController:(UIViewController *)viewController withCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:YES popType:PopTypeRoot andCompletion:completion];
}

- (void)popToRootAndSwitchToViewController:(UIViewController *)viewController
				  withSlideOutAnimation:(BOOL)slideOutAnimation
						  andCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:slideOutAnimation popType:PopTypeRoot andCompletion:completion];
}

- (void)popToRootAndSwitchToViewController:(UIViewController *)viewController
						 withCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:YES popType:PopTypeRoot andCompletion:completion];
}

- (void)popAllAndSwitchToViewController:(UIViewController *)viewController
		 withSlideOutAnimation:(BOOL)slideOutAnimation
				 andCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:slideOutAnimation popType:PopTypeAll andCompletion:completion];
}

- (void)popAllAndSwitchToViewController:(UIViewController *)viewController
						 withCompletion:(void (^)())completion
{
	[self switchToViewController:viewController withSlideOutAnimation:YES popType:PopTypeAll andCompletion:completion];
}

- (void)closeMenuWithCompletion:(void (^)())completion
{
	[self closeMenuWithDuration:MENU_SLIDE_ANIMATION_DURATION andCompletion:completion];
}

- (void)openMenu:(Menu)menu withCompletion:(void (^)())completion
{
	[self openMenu:menu withDuration:MENU_SLIDE_ANIMATION_DURATION andCompletion:completion];
}

/// TO-DO:
- (void)openLeftMenu
{
    [self openMenu:MenuLeft withDuration:MENU_SLIDE_ANIMATION_DURATION andCompletion:nil];
}

/// TO-DO:
- (void)openRightMenu
{
    [self openMenu:MenuRight withDuration:MENU_SLIDE_ANIMATION_DURATION andCompletion:nil];
}

/// TO-DO:
- (void)setLeftMenuEnable:(BOOL)sEnable
{
    self.mLeftMenuEnable = sEnable;
}

- (void)toggleLeftMenu
{
	[self toggleMenu:MenuLeft withCompletion:nil];
}

- (void)toggleRightMenu
{
	[self toggleMenu:MenuRight withCompletion:nil];
}

- (BOOL)isMenuOpen
{
	return (self.horizontalLocation == 0) ? NO : YES;
}

- (void)setEnableShadow:(BOOL)enable
{
	_enableShadow = enable;
	
	if (enable)
	{
		self.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
		self.view.layer.shadowRadius = MENU_SHADOW_RADIUS;
		self.view.layer.shadowOpacity = MENU_SHADOW_OPACITY;
		self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
		self.view.layer.shouldRasterize = YES;
		self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
	}
	else
	{
		self.view.layer.shadowOpacity = 0;
		self.view.layer.shadowRadius = 0;
	}
}

#pragma mark - Override Methods -

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
	if ([self isMenuOpen])
	{
		[self closeMenuWithCompletion:^{
			[super popToRootViewControllerAnimated:animated];
		}];
	}
	else
	{
		return [super popToRootViewControllerAnimated:animated];
	}
	
	return nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([self isMenuOpen])
	{
		[self closeMenuWithCompletion:^{
			[super pushViewController:viewController animated:animated];
		}];
	}
	else
	{
		[super pushViewController:viewController animated:animated];
	}
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([self isMenuOpen])
	{
		[self closeMenuWithCompletion:^{
			[super popToViewController:viewController animated:animated];
		}];
	}
	else
	{
		return [super popToViewController:viewController animated:animated];
	}
	
	return nil;
}

#pragma mark - Private Methods -

- (void)updateMenuFrameAndTransformAccordingToOrientation
{
	// Animate rotatation when menu is open and device rotates
	CGAffineTransform transform = self.view.transform;
	self.leftMenu.view.transform = transform;
	self.rightMenu.view.transform = transform;
	
	self.leftMenu.view.frame = [self initialRectForMenu];
	self.rightMenu.view.frame = [self initialRectForMenu];
}

- (void)enableTapGestureToCloseMenu:(BOOL)enable
{
	if (enable)
	{
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
			self.interactivePopGestureRecognizer.enabled = NO;
		
		self.topViewController.view.userInteractionEnabled = NO;
		[self.view addGestureRecognizer:self.tapRecognizer];
	}
	else
	{
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
			self.interactivePopGestureRecognizer.enabled = YES;
		
		self.topViewController.view.userInteractionEnabled = YES;
		[self.view removeGestureRecognizer:self.tapRecognizer];
	}
}

- (void)toggleMenu:(Menu)menu withCompletion:(void (^)())completion
{
	if ([self isMenuOpen])
		[self closeMenuWithCompletion:completion];
	else
		[self openMenu:menu withCompletion:completion];
}

- (UIBarButtonItem *)barButtonItemForMenu:(Menu)menu
{
	SEL selector = (menu == MenuLeft) ? @selector(leftMenuSelected:) : @selector(righttMenuSelected:);
	UIBarButtonItem *customButton = (menu == MenuLeft) ? self.leftBarButtonItem : self.rightBarButtonItem;
	
	if (customButton)
	{
		customButton.action = selector;
		customButton.target = self;
		return customButton;
	}
	else
	{
		UIImage *image = [UIImage imageNamed:MENU_IMAGE];
        UIBarButtonItem *tBar =[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
        [tBar setTintColor:[UIColor whiteColor]];
        return tBar;
	}
}

- (BOOL)shouldDisplayMenu:(Menu)menu forViewController:(UIViewController *)vc
{
	if (menu == MenuRight)
	{
		if ([vc respondsToSelector:@selector(slideNavigationControllerShouldDisplayRightMenu)] &&
			[(UIViewController<SlideNavigationControllerDelegate> *)vc slideNavigationControllerShouldDisplayRightMenu])
		{
			return YES;
		}
	}
	if (menu == MenuLeft)
	{
        
        
        
		if ([vc respondsToSelector:@selector(slideNavigationControllerShouldDisplayLeftMenu)] &&
			[(UIViewController<SlideNavigationControllerDelegate> *)vc slideNavigationControllerShouldDisplayLeftMenu])
		{
			return YES;
		}
	}
	
	return NO;
}

- (void)openMenu:(Menu)menu withDuration:(float)duration andCompletion:(void (^)())completion
{
	[self enableTapGestureToCloseMenu:YES];

	[self prepareMenuForReveal:menu];
	
//    self.mShadowView.hidden = NO;
	[UIView animateWithDuration:duration
						  delay:0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
//                         self.mShadowView.alpha = 1.0;
						 CGRect rect = self.view.frame;
						 CGFloat width = self.horizontalSize;
						 rect.origin.x = (menu == MenuLeft) ? (width - self.mSlideOffsetLeft) : ((width - self.slideOffset )* -1);
						 [self moveHorizontallyToLocation:rect.origin.x];
					 }
					 completion:^(BOOL finished) {
						 if (completion)
							 completion();
                         
                         [self postNotificationWithName:SlideNavigationControllerDidOpen forMenu:menu];
					 }];
}

- (void)extendLeftMenuWithDuration:(float)duration WithWidth:(float)sWidth
{
    [UIView animateWithDuration:duration
                        animations:^{
                         //                         self.mShadowView.alpha = 1.0;
                         CGRect rect = self.view.frame;
                         CGFloat width = self.horizontalSize;
                         rect.origin.x = (width - sWidth);
                         [self moveHorizontallyToLocation:rect.origin.x];
                     }];
}

- (void)closeMenuWithDuration:(float)duration andCompletion:(void (^)())completion
{
	[self enableTapGestureToCloseMenu:NO];
    
     Menu menu = (self.horizontalLocation > 0) ? MenuLeft : MenuRight;
	
	[UIView animateWithDuration:duration
						  delay:0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
//                         self.mShadowView.alpha = 0.0f;
						 CGRect rect = self.view.frame;
						 rect.origin.x = 0;
						 [self moveHorizontallyToLocation:rect.origin.x];
					 }
					 completion:^(BOOL finished) {
//                         self.mShadowView.hidden = YES;
						 if (completion)
							 completion();
                         
                         [self postNotificationWithName:SlideNavigationControllerDidClose forMenu:menu];
					 }];
}

- (void)moveHorizontallyToLocation:(CGFloat)location
{
	CGRect rect = self.view.frame;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];//self.interfaceOrientation;
	Menu menu = (self.horizontalLocation >= 0 && location >= 0) ? MenuLeft : MenuRight;
    
    if ((location > 0 && self.horizontalLocation <= 0) || (location < 0 && self.horizontalLocation >= 0)) {
        [self postNotificationWithName:SlideNavigationControllerDidReveal forMenu:(location > 0) ? MenuLeft : MenuRight];
    }
	
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        rect.origin.x = location;
        rect.origin.y = 0;
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            rect.origin.x = 0;
            rect.origin.y = (orientation == UIInterfaceOrientationLandscapeRight) ? location : location*-1;
        }
        else
        {
            rect.origin.x = (orientation == UIInterfaceOrientationPortrait) ? location : location*-1;
            rect.origin.y = 0;
        }
    }
	
	self.view.frame = rect;
    
    /**
     *  TODO:  Menu modify
     */
    // modify for drag menu
    if (rect.origin.x + self.mSlideOffset <= rect.size.width)
    {
        CGRect mFrame = self.leftMenu.view.frame;
        mFrame.origin.x = 0;//-self.view.frame.size.width + rect.origin.x + self.mSlideOffset;
        self.leftMenu.view.frame = mFrame;
    }

	[self updateMenuAnimation:menu];
}

- (void)updateMenuAnimation:(Menu)menu
{
	CGFloat progress = (menu == MenuLeft)
		? (self.horizontalLocation / (self.horizontalSize - self.slideOffset))
		: (self.horizontalLocation / ((self.horizontalSize - self.slideOffset) * -1));
	
	[self.menuRevealAnimator animateMenu:menu withProgress:progress];
}

- (CGRect)initialRectForMenu
{
	CGRect rect = self.view.frame;
	rect.origin.x = 0;
	rect.origin.y = 0;
	
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        return rect;
    }
	
	if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))//self.interfaceOrientation))
	{
        // For some reasons in landscape below the status bar is considered y=0, but in portrait it's considered y=20
//        rect.origin.x = (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) ? 0 : STATUS_BAR_HEIGHT;
        rect.origin.x = ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) ? 0 : STATUS_BAR_HEIGHT;
        rect.size.width = self.view.frame.size.width-STATUS_BAR_HEIGHT;
	}
	else
	{
        // For some reasons in landscape below the status bar is considered y=0, but in portrait it's considered y=20
//        rect.origin.y = (self.interfaceOrientation == UIInterfaceOrientationPortrait) ? STATUS_BAR_HEIGHT : 0;
        rect.origin.y = ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait) ? STATUS_BAR_HEIGHT : 0;
        rect.size.height = self.view.frame.size.height-STATUS_BAR_HEIGHT;
	}
	
	return rect;
}

- (void)prepareMenuForReveal:(Menu)menu
{
	// Only prepare menu if it has changed (ex: from MenuLeft to MenuRight or vice versa)
    if (self.lastRevealedMenu && menu == self.lastRevealedMenu)
        return;
    
    UIViewController *menuViewController = (menu == MenuLeft) ? self.leftMenu : self.rightMenu;
	UIViewController *removingMenuViewController = (menu == MenuLeft) ? self.rightMenu : self.leftMenu;

    self.lastRevealedMenu = menu;
	
	[removingMenuViewController.view removeFromSuperview];
	[self.view.window insertSubview:menuViewController.view atIndex:0];
   
	[self updateMenuFrameAndTransformAccordingToOrientation];
	
	[self.menuRevealAnimator prepareMenuForAnimation:menu];
}

- (CGFloat)horizontalLocation
{
	CGRect rect = self.view.frame;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];//self.interfaceOrientation;
	
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        return rect.origin.x;
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return (orientation == UIInterfaceOrientationLandscapeRight)
            ? rect.origin.y
            : rect.origin.y*-1;
        }
        else
        {
            return (orientation == UIInterfaceOrientationPortrait)
            ? rect.origin.x
            : rect.origin.x*-1;
        }
    }
}

- (CGFloat)horizontalSize
{
	CGRect rect = self.view.frame;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];//self.interfaceOrientation;
	
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        return rect.size.width;
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            return rect.size.height;
        }
        else
        {
            return rect.size.width;
        }
    }
}

- (void)postNotificationWithName:(NSString *)name forMenu:(Menu)menu
{
    NSString *menuString = (menu == MenuLeft) ? NOTIFICATION_USER_INFO_MENU_LEFT : NOTIFICATION_USER_INFO_MENU_RIGHT;
    NSDictionary *userInfo = @{ NOTIFICATION_USER_INFO_MENU : menuString };
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}

#pragma mark - UINavigationControllerDelegate Methods -

- (void)navigationController:(UINavigationController *)navigationController
	  willShowViewController:(UIViewController *)viewController
					animated:(BOOL)animated
{
	if ([self shouldDisplayMenu:MenuLeft forViewController:viewController])

		viewController.navigationItem.leftBarButtonItem = [self barButtonItemForMenu:MenuLeft];
	
	if ([self shouldDisplayMenu:MenuRight forViewController:viewController])
		viewController.navigationItem.rightBarButtonItem = [self barButtonItemForMenu:MenuRight];
}

- (CGFloat)slideOffset
{
	return (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))//self.interfaceOrientation))
		? self.landscapeSlideOffset
		: self.portraitSlideOffset;
}

#pragma mark - IBActions -

- (void)leftMenuSelected:(id)sender
{
	if ([self isMenuOpen])
		[self closeMenuWithCompletion:nil];
	else
		[self openMenu:MenuLeft withCompletion:nil];
}

- (void)righttMenuSelected:(id)sender
{
	if ([self isMenuOpen])
		[self closeMenuWithCompletion:nil];
	else
		[self openMenu:MenuRight withCompletion:nil];
}

#pragma mark - Gesture Recognizing -

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
	[self closeMenuWithCompletion:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	if (self.panGestureSideOffset == 0)
		return YES;
	
	CGPoint pointInView = [touch locationInView:self.view];
	CGFloat horizontalSize = [self horizontalSize];
	
	return (pointInView.x <= self.panGestureSideOffset || pointInView.x >= horizontalSize - self.panGestureSideOffset)
		? YES
		: NO;
}

- (void)panDetected:(UIPanGestureRecognizer *)aPanRecognizer
{
	CGPoint translation = [aPanRecognizer translationInView:aPanRecognizer.view];
    CGPoint velocity = [aPanRecognizer velocityInView:aPanRecognizer.view];
	NSInteger movement = translation.x - self.draggingPoint.x;
    
//    NSLog(@"SWIPE: translation %@ | dragging %@ | movement %ld", NSStringFromCGPoint(translation), NSStringFromCGPoint(self.draggingPoint), movement);
	
    Menu currentMenu;
    
    if (self.horizontalLocation > 0)
        currentMenu = MenuLeft;
    else if (self.horizontalLocation < 0)
        currentMenu = MenuRight;
    else
        currentMenu = (translation.x > 0) ? MenuLeft : MenuRight;
    
    if (![self shouldDisplayMenu:currentMenu forViewController:self.topViewController])
        return;
    
    [self prepareMenuForReveal:currentMenu];
    
    if (aPanRecognizer.state == UIGestureRecognizerStateBegan)
	{
		self.draggingPoint = translation;
    }
	else if (aPanRecognizer.state == UIGestureRecognizerStateChanged)
	{
        if (self.mLeftMenuEnable == NO && currentMenu == MenuLeft)
        {
            translation.x = 0;
            self.draggingPoint = translation;
            [self moveHorizontallyToLocation:0];
            return;
        }
        
		static CGFloat lastHorizontalLocation = 0;
		CGFloat newHorizontalLocation = [self horizontalLocation];
		lastHorizontalLocation = newHorizontalLocation;
		newHorizontalLocation += movement;
		
		if (newHorizontalLocation >= self.minXForDragging && newHorizontalLocation <= self.maxXForDragging)
			[self moveHorizontallyToLocation:newHorizontalLocation];
		
		self.draggingPoint = translation;
	}
	else if (aPanRecognizer.state == UIGestureRecognizerStateEnded)
    {
        NSInteger currentX = [self horizontalLocation];
		NSInteger currentXOffset = (currentX > 0) ? currentX : currentX * -1;
		NSInteger positiveVelocity = (velocity.x > 0) ? velocity.x : velocity.x * -1;
		
		// If the speed is high enough follow direction
		if (positiveVelocity >= MENU_FAST_VELOCITY_FOR_SWIPE_FOLLOW_DIRECTION)
		{
			Menu menu = (velocity.x > 0) ? MenuLeft : MenuRight;
            
//            // TO-DO:
//            if (self.mLeftMenuEnable == NO && menu == MenuLeft)
//            {
//                return;
//            }
			
			// Moving Right
			if (velocity.x > 0)
			{
				if (currentX > 0 && self.mLeftMenuEnable == YES && menu == MenuLeft)
				{
					if ([self shouldDisplayMenu:menu forViewController:self.visibleViewController])
						[self openMenu:(velocity.x > 0) ? MenuLeft : MenuRight withDuration:MENU_QUICK_SLIDE_ANIMATION_DURATION andCompletion:nil];
				}
				else
				{
					[self closeMenuWithDuration:MENU_QUICK_SLIDE_ANIMATION_DURATION andCompletion:nil];
				}
			}
			// Moving Left
			else
			{
				if (currentX > 0)
				{
					[self closeMenuWithDuration:MENU_QUICK_SLIDE_ANIMATION_DURATION andCompletion:nil];
				}
				else
				{
					if ([self shouldDisplayMenu:menu forViewController:self.visibleViewController])
						[self openMenu:(velocity.x > 0) ? MenuLeft : MenuRight withDuration:MENU_QUICK_SLIDE_ANIMATION_DURATION andCompletion:nil];
				}
			}
		}
		else
		{
			if (currentXOffset < (self.horizontalSize - self.slideOffset)/2)
				[self closeMenuWithCompletion:nil];
			else
				[self openMenu:(currentX > 0) ? MenuLeft : MenuRight withCompletion:nil];
		}
    }
}

- (NSInteger)minXForDragging
{
	if ([self shouldDisplayMenu:MenuRight forViewController:self.topViewController])
	{
		return (self.horizontalSize - self.slideOffset)  * -1;
	}
	
	return 0;
}

- (NSInteger)maxXForDragging
{
	if ([self shouldDisplayMenu:MenuLeft forViewController:self.topViewController])
	{
		return self.horizontalSize - self.slideOffset;
	}
	
	return 0;
}

#pragma mark - Setter & Getter -

- (UITapGestureRecognizer *)tapRecognizer
{
	if (!_tapRecognizer)
	{
		_tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
	}
	
	return _tapRecognizer;
}

- (UIPanGestureRecognizer *)panRecognizer
{
	if (!_panRecognizer)
	{
		_panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
		_panRecognizer.delegate = self;
	}
	
	return _panRecognizer;
}

- (void)setEnableSwipeGesture:(BOOL)markEnableSwipeGesture
{
	_enableSwipeGesture = markEnableSwipeGesture;
	
	if (_enableSwipeGesture)
	{
		[self.view addGestureRecognizer:self.panRecognizer];
	}
	else
	{
		[self.view removeGestureRecognizer:self.panRecognizer];
	}
}

- (void)setMenuRevealAnimator:(id<SlideNavigationContorllerAnimator>)menuRevealAnimator
{
	[self.menuRevealAnimator clear];
	
	_menuRevealAnimator = menuRevealAnimator;
}

- (void)setLeftMenu:(UIViewController *)leftMenu
{
    [_leftMenu.view removeFromSuperview];
    
    _leftMenu = leftMenu;
}

- (void)setRightMenu:(UIViewController *)rightMenu
{
    [_rightMenu.view removeFromSuperview];
    
    _rightMenu = rightMenu;
}

@end
