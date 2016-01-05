//
//  CountryController.h
//  DenDomDom
//
//  Created by Thien Banh on 1/3/16.
//  Copyright © 2016 DiemMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CountryControllerDelegate <NSObject>

- (void)tfCountryController_DidHiden:(UIViewController*)sProductController;

@end
@interface CountryController : UIViewController

@property (weak, nonatomic) id<CountryControllerDelegate>mDelegate;
@end
