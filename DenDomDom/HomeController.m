//
//  HomeController.m
//  DenDomDom
//
//  Created by Thien Banh on 10/27/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "HomeController.h"
#import "HomeCell.h"
#import "TFNoDataTableViewCell.h"

#import "Scholarship.h"
#import "FilterObject.h"
#import "Country.h"

#import "SlideNavigationController.h"
#import "ScholarshipDetailController.h"
#import "CountryController.h"

#define nilObj          @[]
@interface HomeController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,SlideNavigationControllerDelegate, HomeCellDelegate>
{
    //PROPERTY
    
    NSMutableArray *mScholarshipArray;
    UISearchBar *mSearchBarTop;
    BOOL  mIsStopLoad;
    NSInteger mPageIndex;
    NSInteger mPageSize;
    BOOL isRefesh;
    //OUTLET
    __weak IBOutlet UIButton *oCountryButton;
    __weak IBOutlet UITableView *oTableView;

}
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];


    [TFAppDelegate setNavigationTitle:@"TRANG CHỦ" CanBack:NO ForController:self];
    // Do any additional setup after loading the view.
    [oTableView registerNib:[UINib nibWithNibName:@"TFNoDataTableViewCell" bundle:[NSBundle mainBundle]]
     forCellReuseIdentifier:kCellID_NoDataTable];
    
    mSearchBarTop = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    mSearchBarTop.showsCancelButton = NO;
    [mSearchBarTop setBarTintColor:RGB(116, 175, 173)];
    self.navigationItem.titleView = mSearchBarTop;
    [mSearchBarTop setPlaceholder:@"Bạn tìm gì vậy"];
    mSearchBarTop.delegate = self;
    
    for (UIView *tView in [mSearchBarTop subviews])
    {
        for (UIView *tSubView in [tView subviews])
        {
            if ([tSubView.class isSubclassOfClass:[UITextField class]])
            {
                UIFont *tFont = FONT_LIGHT(17);
                [(UITextField *)tSubView setFont:tFont];
                [(UITextField *)tSubView setClipsToBounds:YES];
                ((UITextField *)tSubView).layer.cornerRadius = mSearchBarTop.layer.frame.size.height/2 - 8;
            }
        }
    }
    oCountryButton.layer.cornerRadius = 5;
    oCountryButton.layer.borderColor = [RGB(217, 133, 59) CGColor];
    oCountryButton.layer.borderWidth = 1;
   
    [self setUpRightButton];

}

- (void)viewWillAppear:(BOOL)animated
{
    if (!mScholarshipArray) {
        mScholarshipArray = [[NSMutableArray alloc] init];
    }
    mIsStopLoad = NO;
    mPageIndex = 1;
    mPageSize = 10;
    if (mIsStopLoad == NO) {
        [mScholarshipArray removeAllObjects];
        [oTableView reloadData];
        [self loadHome:TFAppDelegate.mCurrentState];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mSearchBarTop resignFirstResponder];
}

- (void)loadHome:(NSInteger)menuLoad
{
    NSString *tCountryName = @"Tất cả";
    if (TFAppDelegate.Country) {
        tCountryName = TFAppDelegate.Country.mName;
    }
    [oCountryButton setTitle:tCountryName forState:UIControlStateNormal];
    
    isRefesh = NO;
    TFAppDelegate.mCurrentState = menuLoad;
    [TFAppDelegate showConnectionInView:self.view];
    if (TFAppDelegate.mCurrentState == kFilterFilterHave)
    {
        TFAppDelegate.mFilterObject.pageNumber = mPageIndex;
        TFAppDelegate.mFilterObject.size = mPageSize;
        NSDictionary *tParam = [TFAppDelegate.mFilterObject getFilterDict];
        
        [TFWebServiceManager postScholarshipArrayWithParams:kAPI_ListBy withParam:tParam success:^(id bProductArray) {
            if (bProductArray == nil) {
                return ;
            }
            [mScholarshipArray addObjectsFromArray:bProductArray];
            if ([(NSArray *)bProductArray count] < mPageSize)
            {
                mIsStopLoad = YES;
            }
            mPageIndex++;

            [oTableView reloadData];
            [TFAppDelegate hideConnectionInView:self.view];
            isRefesh = YES;
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
            isRefesh = YES;
        }];
        
    }
    else if (TFAppDelegate.mCurrentState == kFilterFilterCountry)
    {
        FilterObject *tFIlter =[[FilterObject alloc] init];

        tFIlter.pageNumber = mPageIndex;
        tFIlter.size = mPageSize;
        tFIlter.mStuCitizenship = TFAppDelegate.Country;
        NSDictionary *tParam = [tFIlter getFilterDict];
        
        [TFWebServiceManager postScholarshipArrayWithParams:kAPI_ListBy withParam:tParam success:^(id bProductArray) {
            if (bProductArray == nil) {
                return ;
            }
            if ([(NSArray *)bProductArray count] < mPageSize)
            {
                mIsStopLoad = YES;
            }
            [mScholarshipArray addObjectsFromArray:bProductArray];
            mPageIndex++;
            isRefesh = YES;
            [oTableView reloadData];
            
            [TFAppDelegate hideConnectionInView:self.view];
        } failure:^(NSError *bError, NSString *bMessage) {
            isRefesh = YES;
            [TFAppDelegate hideConnectionInView:self.view];
            
        }];

    }
    else if (TFAppDelegate.mCurrentState == kFilterFilterNo)
    {
        FilterObject *tFIlter =[[FilterObject alloc] init];
        
        tFIlter.pageNumber = mPageIndex;
        tFIlter.size = mPageSize;

        NSDictionary *tParam = [tFIlter getFilterDict];
        
        [TFWebServiceManager postScholarshipArrayWithParams:kAPI_ListBy withParam:tParam success:^(id bProductArray) {
            if (bProductArray == nil) {
                return ;
            }
            if ([(NSArray *)bProductArray count] < mPageSize)
            {
                mIsStopLoad = YES;
            }
            [mScholarshipArray addObjectsFromArray:bProductArray];
            mPageIndex++;
            isRefesh = YES;
            [oTableView reloadData];
            
            [TFAppDelegate hideConnectionInView:self.view];
        } failure:^(NSError *bError, NSString *bMessage) {
            isRefesh = YES;
            [TFAppDelegate hideConnectionInView:self.view];
            
        }];
    }
    else if(TFAppDelegate.mCurrentState == kFilterNew)
    {
        
        NSDictionary *tParam = @{};
        NSInteger urlParam = 10;
        
        [TFWebServiceManager getScholarshipArrayWithURL:kAPI_ListNewScholarship withID:urlParam withParams:tParam success:^(id bProductArray) {
            if (bProductArray == nil) {
                
                return ;
            }
            [mScholarshipArray addObjectsFromArray:bProductArray];
            if ([(NSArray *)bProductArray count] < mPageSize)
            {
                mIsStopLoad = YES;
            }
            mPageIndex++;
            isRefesh = YES;
            [oTableView reloadData];
            [TFAppDelegate hideConnectionInView:self.view];
        } failure:^(NSError *bError, NSString *bMessage) {
            isRefesh = YES;
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if(TFAppDelegate.mCurrentState == kFilterNoiBat)
    {
        NSDictionary *tParam = @{@"pageNumber":@1, @"pageSize":@5, @"allowEmptyString":@1, @"maxResult":@10};
        [TFWebServiceManager postScholarshipArrayWithParams:kAPI_ListTopView withParam:tParam success:^(id bProductArray) {
            mScholarshipArray = bProductArray;
            isRefesh = YES;
            [oTableView reloadData];
            [TFAppDelegate hideConnectionInView:self.view];
        } failure:^(NSError *bError, NSString *bMessage) {
            isRefesh = YES;
            [TFAppDelegate hideConnectionInView:self.view];
        }];
        
    }
    else if(TFAppDelegate.mCurrentState == kFilterDuHoc)
    {
        [TFAppDelegate hideConnectionInView:self.view];
    }
    else if(TFAppDelegate.mCurrentState == kFilterSearch)
    {
        
        [TFAppDelegate hideConnectionInView:self.view];
    }
}

- (void)setUpRightButton
{
    UIButton *tRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tRightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tRightButton setImage:[UIImage imageNamed:@"Filter Filled"] forState:UIControlStateNormal];
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
#pragma mark - UISearchBarDelegate
//-----------------------------
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    mIsStopLoad = NO;
    mPageIndex = 1;
    mPageSize = 10;
    if (mIsStopLoad == NO) {
        [mScholarshipArray removeAllObjects];
        [oTableView reloadData];
//        [self loadHome:TFAppDelegate.mCurrentState];
    }
    
    FilterObject *tFIlter =[[FilterObject alloc] init];
    
    tFIlter.pageNumber = mPageIndex;
    tFIlter.size = mPageSize;
    tFIlter.mKeyword = searchBar.text;
    NSDictionary *tParam = [tFIlter getFilterDict];
    
    [TFWebServiceManager postScholarshipArrayWithParams:kAPI_ListBy withParam:tParam success:^(id bProductArray) {
        if (bProductArray == nil) {
            return ;
        }
        if ([(NSArray *)bProductArray count] < mPageSize)
        {
            mIsStopLoad = YES;
        }
        [mScholarshipArray addObjectsFromArray:bProductArray];
        mPageIndex++;
        isRefesh = YES;
        [oTableView reloadData];
        
        [TFAppDelegate hideConnectionInView:self.view];
    } failure:^(NSError *bError, NSString *bMessage) {
        isRefesh = YES;
        [TFAppDelegate hideConnectionInView:self.view];
        
    }];
    [searchBar resignFirstResponder];
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
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    Scholarship *tScho = mScholarshipArray[sIndex];
    content.contentURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://dendomdom-hadiem.rhcloud.com/all?id=%i",(int)tScho.mID]];
    
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];
    
    NSLog(@"Share at index: %ld", (long)sIndex);
}

#pragma mark - UITableView Datasource and Delegate
//-------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mScholarshipArray.count == 0) {
        TFNoDataTableViewCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellID_NoDataTable];
        if (isRefesh) {
            [rCell setUpCellWithText:@"Không có có dữ liệu"];
        }
        else
        {
            [rCell setUpCellWithText:@"Đang lấy dữ liệu"];
        }
        return rCell;
    }
    
    HomeCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellId_Home];
    [rCell setUpCellWithScholarship:mScholarshipArray[indexPath.row]];
    rCell.mDelegate = self;
    return rCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mScholarshipArray.count == 0) {
        return 50;
    }
    Scholarship *tScholar = mScholarshipArray[indexPath.row];
    return tScholar.mCellHeight;
//    return 320;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mScholarshipArray.count == 0) {
        return 1;
    }
    return mScholarshipArray.count;
//    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//   [self performSegueWithIdentifier:kSegue_Push_Home_Detail sender:nil];
    if (mScholarshipArray.count == 0) {
        return;
    }
    [self performSegueWithIdentifier:kSegue_Push_Home_Detail sender:mScholarshipArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == mScholarshipArray.count-1)
    {
        if (mIsStopLoad == NO) {
            [self loadHome:TFAppDelegate.mCurrentState];
        }
        NSLog(@"count dsad %ld",(long)mScholarshipArray.count);
    }
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

- (IBAction)actionAllPress:(id)sender
{
    UIStoryboard *tStoryboard = kStoryboard_Main;
    CountryController *tView = [tStoryboard instantiateViewControllerWithIdentifier:kStoryboardID_CountryController];
    if (tView) {
        [self.navigationController pushViewController:tView animated:YES];
    }
}

@end
