//
//  CountryController.m
//  DenDomDom
//
//  Created by Thien Banh on 1/3/16.
//  Copyright © 2016 DiemMac. All rights reserved.
//

#import "CountryController.h"
#import "CountryCell.h"
#import "TFNoDataTableViewCell.h"

#import "Country.h"

#define kCellID_CountryCell         @"kCellID_CountryCell"

@interface CountryController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    UIViewController *mRootView;
    BOOL mIsRefesh;
    NSMutableArray *mCountryList;
    NSMutableArray *mBackupList;
    UISearchBar *mSearchBarTop;
    __weak IBOutlet UITableView *oTableView;
}

@end

@implementation CountryController

- (void)viewDidLoad {
    [super viewDidLoad];

    [TFAppDelegate setNavigationTitle:@"QUỐC GIA" CanBack:YES ForController:self];
    [oTableView registerNib:[UINib nibWithNibName:@"TFNoDataTableViewCell" bundle:[NSBundle mainBundle]]
     forCellReuseIdentifier:kCellID_NoDataTable];
    mCountryList = [[NSMutableArray alloc] init];
    mBackupList = [[NSMutableArray alloc] init];
    [self setUpSearch];
    [self loadList];
    // Do any additional setup after loading the view.
}

- (void)setUpSearch
{
    mSearchBarTop = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
    mSearchBarTop.showsCancelButton = NO;
    [mSearchBarTop setBarTintColor:RGB(0, 175, 240)];
    self.navigationItem.titleView = mSearchBarTop;
    [mSearchBarTop setPlaceholder:@"Bạn chọn du học ở đâu"];
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
}

- (void)loadList
{
    mIsRefesh = YES;
    [TFAppDelegate showConnectionInView:self.view];
    [TFWebServiceManager getListCountry:kAPI_GetList withParam:nil success:^(id bProductArray) {
        mCountryList = bProductArray;
        mBackupList = bProductArray;
        [TFAppDelegate hideConnectionInView:self.view];
        mIsRefesh = YES;
        [oTableView reloadData];
    } failure:^(NSError *bError, NSString *bMessage) {
        [TFAppDelegate hideConnectionInView:self.view];
        mIsRefesh = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBackButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView Datasource and Delegate
//-------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mCountryList.count == 0) {
        TFNoDataTableViewCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellID_NoDataTable];
        if (mIsRefesh) {
            [rCell setUpCellWithText:@"Không có có dữ liệu"];
        }
        else
        {
            [rCell setUpCellWithText:@"Đang lấy dữ liệu"];
        }
        return rCell;
    }
    
    CountryCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellID_CountryCell];
    Country *country = mCountryList[indexPath.row];
    [rCell setUpCellWithName:country.mName];

    return rCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mCountryList.count == 0) {
        return 1;
    }
    return mCountryList.count;
    //    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Country *country = mCountryList[indexPath.row];
    TFAppDelegate.Country = country;
    TFAppDelegate.mCurrentState = kFilterFilterCountry;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UISearchBarDelegate
//-----------------------------
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
        NSString *firstLetter = @"";
        
        NSMutableArray *mSearchArray = [[NSMutableArray alloc] init];
        
        if ([searchText length] > 0)
        {
            
            for (Country *tObj in mBackupList)
            {
                if (tObj.mName.length >= searchText.length)
                {
                    firstLetter = [tObj.mName substringWithRange:NSMakeRange(0, [searchText length])];
                    
                    if ([firstLetter caseInsensitiveCompare:searchText] == NSOrderedSame )
                    {
                        // strings are equal except for possibly case
                        [mSearchArray addObject:tObj];
                    }
                }
            }
            mCountryList = mSearchArray;
        }
        else
        {
            mCountryList = mBackupList;
        }
        
        [oTableView reloadData];
}
@end
