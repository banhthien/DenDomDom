//
//  AppDelegate.m
//  DenDomDom
//
//  Created by Thien Banh on 10/27/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "AppDelegate.h"
#import "TFDefine.h"
#import "FilterObject.h"
#import "AboutController.h"
#import "HomeController.h"
#import "MBProgressHUD.h"

#import "Country.h"
@interface AppDelegate ()<AboutControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initStructure];
    [self initFilterList];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    self.mFilterObject = [[FilterObject alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Override point for customization after application launch.
    self.mCurrentState = kFilterNew;
    self.mCountry = [[Country alloc] init];
    self.mCanRefesh = NO;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initFilterList
{
    self.mListFilter = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrObject = [[NSMutableArray alloc] init];
    NSMutableArray *arrAcademicLevel = [[NSMutableArray alloc] init];
    NSMutableArray *arrTypeScholar = [[NSMutableArray alloc] init];
    
    //arrObject
    NSDictionary *tDict = @{@"property": kFilterType_Gender};
    [arrObject addObject:tDict];
    
    tDict = @{@"property": kFilterType_NoiO};
    [arrObject addObject:tDict];
    
    tDict = @{@"property": kFilterType_Religion};
    [arrObject addObject:tDict];
    
    tDict = @{@"property": kFilterType_Disability};
    [arrObject addObject:tDict];
    
    tDict = @{@"property": kFilterType_TerminalIll};
    [arrObject addObject:tDict];
    
    tDict = @{@"property": kFilterType_Family_Policy};
    [arrObject addObject:tDict];
    
    //arrAcademicLevel
    tDict = @{@"property": kFilterType_AcademicLevelNow};
    [arrAcademicLevel addObject:tDict];
    
    tDict = @{@"property": kFilterType_AcademicLevel};
    [arrAcademicLevel addObject:tDict];
    
    tDict = @{@"property": kFilterType_Major};
    [arrAcademicLevel addObject:tDict];
    
    //arrTypeScholar
    tDict = @{@"property": kFilterType_ScholarshipType};
    [arrTypeScholar addObject:tDict];
    
    tDict = @{@"property": kFilterType_Talent};
    [arrTypeScholar addObject:tDict];
    
    [self.mListFilter addObject:arrObject];
    
    [self.mListFilter addObject:arrAcademicLevel];
    
    [self.mListFilter addObject:arrTypeScholar];

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}

- (void)initStructure
{
    self.mSlideNavigationController = (SlideNavigationController *)self.window.rootViewController;
    [self.mSlideNavigationController setEnableSwipeGesture:YES];
    
    
    LeftSlideController *mLeftSlide = [self.mSlideNavigationController.storyboard instantiateViewControllerWithIdentifier:kStoryboardID_LeftSlideController];
    self.mLeftSlide = mLeftSlide;
    [SlideNavigationController sharedInstance].leftMenu = mLeftSlide;
}

#pragma mark - PUBLIC METHOD
//------------------------------------------
- (void)setNavigationTitle:(NSString *)sTitle CanBack:(BOOL)sIsCanBack ForController:(UIViewController *)sController
{
    sController.navigationItem.title = sTitle;
    [sController.navigationController.navigationBar setBarTintColor:RGB(116, 175, 173)];
    [sController.navigationController.navigationBar setTranslucent:NO];
    [sController.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [sController.navigationItem.titleView setBackgroundColor:[UIColor whiteColor]];
    if (sIsCanBack)
    {
        UIButton *tLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
        tLeftButton.frame = CGRectMake(0, 0, 25, 25);
        [tLeftButton addTarget:sController action:@selector(actionBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        sController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tLeftButton];
        [sController.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    }
    sController.navigationController.navigationBarHidden = NO;
}

- (void)showInfoWithController:(UIViewController*)sRoot
{
    UIStoryboard *tStoryboard = kStoryboard_Main;
    AboutController *tView = [tStoryboard instantiateViewControllerWithIdentifier:kStoryboardID_AboutController];
    tView.mDelegate = self;
    [tView setProductViewController:sRoot];
    [self.mSlideNavigationController.leftMenu.view addSubview:tView.view];
    [self.mSlideNavigationController.leftMenu addChildViewController:tView];
    [tView didMoveToParentViewController:self.mSlideNavigationController.leftMenu];
    [tView showInfo];
}

- (void)hideInfoWithController:(UIViewController*)sRoot
{
    AboutController *tView;
    for (UIViewController *tController in self.mSlideNavigationController.leftMenu.childViewControllers)
    {
        if ([tController.class isSubclassOfClass:[AboutController class]])
        {
            tView = (AboutController *)tController;
            break;
        }
    }
    if (tView)
    {
        [tView hideInfo:sRoot];
    }
}

- (void)tfAboutController_DidHiden:(UIViewController *)sProductController
{
    AboutController *tView;
    
    for (UIViewController *tController in self.mSlideNavigationController.leftMenu.childViewControllers)
    {
        if ([tController.class isSubclassOfClass:[AboutController class]])
        {
            tView = (AboutController *)tController;
            break;
        }
    }
    
    if (tView)
    {
        [tView willMoveToParentViewController:nil];
        [tView.view removeFromSuperview];
        [tView removeFromParentViewController];
    }
    [TFAppDelegate.mSlideNavigationController openLeftMenu];
    
}

- (void)showMessage:(NSString *)sMessage withTitle:(NSString*)sTitle
{
    UIAlertView *tAlertView = [[UIAlertView alloc] initWithTitle:sTitle message:sMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [tAlertView show];
}

- (void)showConnectionInView:(UIView *)sView
{
    [MBProgressHUD showHUDAddedTo:sView animated:YES];
}

- (void)hideConnectionInView:(UIView *)sView
{
    [MBProgressHUD hideHUDForView:sView animated:YES];
}

- (void)setOffSetLeftSlideWithDuration:(float)sDuration WithWidth:(float)sWidth;
{
    [self.mSlideNavigationController extendLeftMenuWithDuration:sDuration WithWidth:sWidth];
}

- (IBAction)actionBackButtonPressed:(id)sender
{
    
}
@end
