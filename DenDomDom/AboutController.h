//
//  AboutController.h
//  DenDomDom
//
//  Created by TFLAT iOS Developer on 12/3/15.
//  Copyright © 2015 DiemMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AboutControllerDelegate <NSObject>

- (void)tfAboutController_DidHiden:(UIViewController*)sProductController;

@end
@interface AboutController : UIViewController
@property (nonatomic, weak) id<AboutControllerDelegate>mDelegate;
-(void)setProductViewController:(UIViewController *)sRootView;

- (void)showInfo;
- (void)hideInfo;

@end
