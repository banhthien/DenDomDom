
//
//  LeftSlideController.m
//  DenDomDom
//
//  Created by Thien Banh on 10/28/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "LeftSlideController.h"
#import "LeftSlideCell.h"
#import "TFUtil.h"
#import "HomeController.h"

@interface LeftSlideController ()<UITableViewDataSource,UITableViewDelegate,SlideNavigationControllerDelegate>
{
    // OUTLET

    
    __weak IBOutlet UIImageView *oLogoApp;
    //PROPERTY
    NSMutableArray *mMenuArray;
}
@end

@implementation LeftSlideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
        view.backgroundColor=RGB(0, 175, 240);
        [self.view addSubview:view];
    }
    

    [self loadMenuArray];
}

- (void)loadMenuArray
{
    mMenuArray = [[NSMutableArray alloc] init];
    
    NSDictionary *tDict = @{@"image": @"University Filled",
                            @"name": @"Học bổng mới nhất"};
    [mMenuArray addObject:tDict];
    
    tDict = @{@"image": @"Courses Filled",
              @"name": @"Học bổng nổi bật"};
    
    [mMenuArray addObject:tDict];
    tDict = @{@"image": @"Diploma 2 Filled",
              @"name": @"Học bổng du học"};
    
    [mMenuArray addObject:tDict];
    tDict = @{@"image": @"Student Filled",
              @"name": @"Logout"};
    [mMenuArray addObject:tDict];
    
    tDict = @{@"image": @"About Filled",
              @"name": @"Giới thiệu"};
    [mMenuArray addObject:tDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource and Delegate
//-------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftSlideCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellId_LeftSlide];
    
    NSString *tURL = [TFUtil checkStringFromDictValue:((NSDictionary*)mMenuArray[indexPath.row])[@"image"]];
    NSString *tName = [TFUtil checkStringFromDictValue:((NSDictionary*)mMenuArray[indexPath.row])[@"name"]];
    [rCell setUpCellWith:tURL name:tName];
    return rCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mMenuArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 4) {
        UIViewController *tTabBarController = [TFAppDelegate mSlideNavigationController].topViewController;
        if ([tTabBarController.class isSubclassOfClass:[HomeController class]])
        {
            [TFAppDelegate.mSlideNavigationController closeMenuWithCompletion:^{
                
                
            }];
        }
        [TFAppDelegate showInfoWithController:self];
    }
    
    UIViewController *tTabBarController = [TFAppDelegate mSlideNavigationController].topViewController;
    if ([tTabBarController.class isSubclassOfClass:[HomeController class]])
    {
        [TFAppDelegate.mSlideNavigationController closeMenuWithCompletion:^{
            
             [((HomeController*)tTabBarController) loadHome:indexPath.row];
            
        }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SlideNavigationControllerDelegate
//--------------------------------------------------
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}
@end
