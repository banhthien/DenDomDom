//
//  AppDelegate.h
//  DenDomDom
//
//  Created by Thien Banh on 10/27/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "LeftSlideController.h"

@class FilterObject;
@class Country;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL mCanRefesh;
@property (strong, nonatomic) SlideNavigationController *mSlideNavigationController;
@property (strong, nonatomic) LeftSlideController *mLeftSlide;
@property (strong, nonatomic) NSMutableArray *mListFilter;
@property (assign, nonatomic) NSInteger mCurrentState;
@property (strong, nonatomic) FilterObject *mFilterObject;
@property (strong, nonatomic) Country *mCountry;
- (void)setNavigationTitle:(NSString *)sTitle CanBack:(BOOL)sIsCanBack ForController:(UIViewController *)sController;

- (void)showInfoWithController:(UIViewController*)sRoot;
- (void)hideInfoWithController:(UIViewController*)sRoot;
- (void)showMessage:(NSString *)sMessage withTitle:(NSString*)sTitle;
- (void)showConnectionInView:(UIView *)sView;
- (void)hideConnectionInView:(UIView *)sView;

- (void)setOffSetLeftSlideWithDuration:(float)sDuration WithWidth:(float)sWidth;
@end

