//
//  AboutController.m
//  DenDomDom
//
//  Created by TFLAT iOS Developer on 12/3/15.
//  Copyright © 2015 DiemMac. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()
{
    UIViewController *mRootView;
    
    __weak IBOutlet UIView *oAboutView;
    __weak IBOutlet UIButton *oCloseButton;
}
@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setProductViewController:(UIViewController *)sRootView
{
    mRootView = sRootView;
}

- (void)showInfo
{

    [self.view layoutIfNeeded];
    
    CGRect tRect = CGRectMake(oAboutView.frame.origin.x, SCREEN_SIZE.height, SCREEN_SIZE.width, SCREEN_SIZE.height);
    oAboutView.frame = tRect;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect tRect = CGRectMake(0, SCREEN_SIZE.height - SCREEN_SIZE.height, SCREEN_SIZE.width, SCREEN_SIZE.height);
        oAboutView.frame = tRect;
        [self.view layoutIfNeeded];

        
    } completion:^(BOOL finished) {
        oCloseButton.enabled = YES;
    }];
}

- (void)hideInfo
{
    [UIView animateWithDuration:0.4 animations:^{
        
        [self.view layoutIfNeeded];

        CGRect tRect = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, SCREEN_SIZE.height);
        oAboutView.frame = tRect;
        
    } completion:^(BOOL finished) {
        
        [self.mDelegate tfAboutController_DidHiden:mRootView];
    }];
}
- (IBAction)actionHideAbout:(id)sender
{
    [self hideInfo];
}
@end
