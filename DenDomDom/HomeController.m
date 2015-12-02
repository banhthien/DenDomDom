//
//  HomeController.m
//  DenDomDom
//
//  Created by Thien Banh on 10/27/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "HomeController.h"
#import "HomeCell.h"
#import "TFDefine.h"

#import "Scholarship.h"
#import "FilterObject.h"

#import "SlideNavigationController.h"
#import "ScholarshipDetailController.h"

#define nilObj          @[]
@interface HomeController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,SlideNavigationControllerDelegate, HomeCellDelegate>
{
    //PROPERTY
    NSMutableArray *mScholarshipArray;
    UISearchBar *mSearchBarTop;
    //OUTLET
    __weak IBOutlet UITableView *oTableView;
}
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Slide Navigation
    SlideNavigationController *tNavigationController = (SlideNavigationController *)self.navigationController;
    [tNavigationController setEnableSwipeGesture:YES];
    [TFAppDelegate.mSlideNavigationController setLeftMenuEnable:YES];
    [TFAppDelegate setNavigationTitle:@"Home" CanBack:NO ForController:self];
    // Do any additional setup after loading the view.
    
    mSearchBarTop = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    mSearchBarTop.showsCancelButton = NO;
    self.navigationItem.titleView = mSearchBarTop;
    [mSearchBarTop setPlaceholder:@"Bạn tìm gì vại"];
    mSearchBarTop.delegate = self;
    [self setUpRightButton];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadHome:TFAppDelegate.mCurrentState];
}

- (void)loadHome:(NSInteger)menuLoad
{    
    if (!mScholarshipArray) {
        mScholarshipArray = [[NSMutableArray alloc] init];
    }
    TFAppDelegate.mCurrentState = menuLoad;
    
    if (TFAppDelegate.mCurrentState == kFilterFilter) {
        NSDictionary *tParam = [TFAppDelegate.mFilterObject getFilterDict];
        
        [TFWebServiceManager postScholarshipArrayWithParams:kAPI_ListBy withParam:tParam success:^(id bProductArray) {
            mScholarshipArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            
        }];
        
    }
    else if(TFAppDelegate.mCurrentState == kFilterNew){
        
        NSDictionary *tParam = @{};
        NSInteger urlParam = 10;
        
        [TFWebServiceManager getScholarshipArrayWithURL:kAPI_ListNewScholarship withID:urlParam withParams:tParam success:^(id bProductArray) {
            mScholarshipArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            
        }];
    }
    else if(TFAppDelegate.mCurrentState == kFilterNoiBat){
        NSDictionary *tParam = @{@"pageNumber":@1, @"pageSize":@5, @"allowEmptyString":@1, @"maxResult":@10};
        [TFWebServiceManager postScholarshipArrayWithParams:kAPI_ListTopView withParam:tParam success:^(id bProductArray) {
            mScholarshipArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            
        }];
        
    }
    else if(TFAppDelegate.mCurrentState == kFilterDuHoc){
        
    }
}

- (void)setUpRightButton
{
    UIButton *tRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tRightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tRightButton setImage:[UIImage imageNamed:@"Filter-100"] forState:UIControlStateNormal];
    tRightButton.frame = CGRectMake(0, 0, 30, 30);
    [tRightButton addTarget:self action:@selector(actionFilterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tRightButton];
}

- (IBAction)actionFilterButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:kSegue_Push_Home_Filter sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SlideNavigationControllerDelegate
//--------------------------------------------------
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

#pragma mark - HomeCellDelegate
//------------
-(void)homeCell_SharePressWithIndex:(NSInteger)sIndex
{
    NSLog(@"Share at index: %ld", (long)sIndex);
}

#pragma mark - UITableView Datasource and Delegate
//-------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellId_Home];
    [rCell setUpCellWithScholarship:mScholarshipArray[indexPath.row]];
    rCell.mDelegate = self;
    return rCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Scholarship *tScholar = mScholarshipArray[indexPath.row];
    return tScholar.mCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mScholarshipArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [self performSegueWithIdentifier:kSegue_Push_Home_Detail sender:mScholarshipArray[indexPath.row]];
}
#pragma mark - Navigation
//----------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegue_Push_Home_Detail])
    {
        ScholarshipDetailController *tController = (ScholarshipDetailController *)segue.destinationViewController;
        tController.mScholarObj = sender;
    }
    
}

@end
