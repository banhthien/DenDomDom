//
//  FilterDetailController.m
//  DenDomDom
//
//  Created by Thien Banh on 11/1/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "FilterDetailController.h"
#import "FilterDetailCell.h"
#import "Country.h"
#import "Religion.h"
#import "Disability.h"
#import "Gender.h"
#import "TermialIll.h"
#import "FamilyPolicy.h"
#import "Major.h"
#import "AcademicLevel.h"
#import "ScholarshipType.h"
#import "Talent.h"
#import "FilterObject.h"

@interface FilterDetailController ()<UITableViewDataSource,UITableViewDelegate,FilterDetailCellDelegate,UISearchBarDelegate>
{
    NSInteger mType;
    NSMutableArray *mFilterArray;
    NSMutableArray *mBackUpArray;
    UISearchBar *mSearchBarTop;
    
    
    __weak IBOutlet UITableView *oTableView;
}
@end

@implementation FilterDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [TFAppDelegate setNavigationTitle:_mChild CanBack:YES ForController:self];
    // Do any additional setup after loading the view.
    mFilterArray = [[NSMutableArray alloc] init];
    mBackUpArray = [[NSMutableArray alloc] init];
    [self loadFilter];
}

- (void)loadFilter
{
    if ([self.mChild isEqual:kFilterType_Gender]) {
        [TFWebServiceManager getListGender:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            
        }];
    }
    else if([self.mChild isEqual:kFilterType_NoiO])
    {
        mSearchBarTop = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
        mSearchBarTop.showsCancelButton = NO;
        self.navigationItem.titleView = mSearchBarTop;
        [mSearchBarTop setPlaceholder:@"Bạn ở đâu"];
        mSearchBarTop.delegate = self;
        
        for (UIView *tView in [mSearchBarTop subviews])
        {
            for (UIView *tSubView in [tView subviews])
            {
                if ([tSubView.class isSubclassOfClass:[UITextField class]])
                {
                    UIFont *tFont = FONT_LIGHT(17);
                    [(UITextField *)tSubView setFont:tFont];
                }
            }
        }
        [TFWebServiceManager getListCountry:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            mBackUpArray = mFilterArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    else if([self.mChild isEqual:kFilterType_Religion]){
        [TFWebServiceManager getListReligion:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    else if([self.mChild isEqual:kFilterType_Disability]){
        [TFWebServiceManager getListDisability:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    else if([self.mChild isEqual:kFilterType_TerminalIll]){
        [TFWebServiceManager getListTerminalIll:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    else if([self.mChild isEqual:kFilterType_Family_Policy]){
        [TFWebServiceManager getListFamilyPolicy:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    else if([self.mChild isEqual:kFilterType_AcademicLevelNow]){
        [TFWebServiceManager getListAcademicLevel:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    else if([self.mChild isEqual:kFilterType_AcademicLevel]){
        [TFWebServiceManager getListAcademicLevel:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    else if([self.mChild isEqual:kFilterType_Major]){
        mSearchBarTop = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
        mSearchBarTop.showsCancelButton = NO;
        self.navigationItem.titleView = mSearchBarTop;
        [mSearchBarTop setPlaceholder:@"Bạn ở đâu"];
        mSearchBarTop.delegate = self;
        
        for (UIView *tView in [mSearchBarTop subviews])
        {
            for (UIView *tSubView in [tView subviews])
            {
                if ([tSubView.class isSubclassOfClass:[UITextField class]])
                {
                    UIFont *tFont = FONT_LIGHT(17);
                    [(UITextField *)tSubView setFont:tFont];
                }
            }
        }
        [TFWebServiceManager getListMajor:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            mBackUpArray = mFilterArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    else if([self.mChild isEqual:kFilterType_ScholarshipType]){
        [TFWebServiceManager getListScholarshipType:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    else if([self.mChild isEqual:kFilterType_Talent]){
        [TFWebServiceManager getListTalent:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBackButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UISearchBarDelegate
//-----------------------------
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
    if([self.mChild isEqual:kFilterType_NoiO])
    {
        NSString *firstLetter = @"";
        
        NSMutableArray *mSearchArray = [[NSMutableArray alloc] init];
        
        if ([searchText length] > 0)
        {
            
            for (Country *tObj in mBackUpArray)
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
            mFilterArray = mSearchArray;
        }
        else
        {
            mFilterArray = mBackUpArray;
        }
        
        [oTableView reloadData];
    }
    else if([self.mChild isEqual:kFilterType_Major]){
        NSString *firstLetter = @"";
        
        NSMutableArray *mSearchArray = [[NSMutableArray alloc] init];
        
        if ([searchText length] > 0)
        {
            
            for (Major *tObj in mBackUpArray)
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
            mFilterArray = mSearchArray;
        }
        else
        {
            mFilterArray = mBackUpArray;
        }
        
        [oTableView reloadData];
    }
}
#pragma mark - FilterDetailDelegate
//------------
-(void)filterDetailCell_SwitchPressAtIndex:(NSInteger)sIndex withValue:(BOOL)sSwitch{
    
    if ([self.mChild isEqual:kFilterType_Gender]) {
        
        if (sSwitch) {
            TFAppDelegate.mFilterObject.mStuGender = nil;
        }
        else
        {
            Gender *genDer = mFilterArray[sIndex];
            TFAppDelegate.mFilterObject.mStuGender = genDer;
        }

    }
    
    else if([self.mChild isEqual:kFilterType_NoiO])
    {
        Country *country = mFilterArray[sIndex];
        TFAppDelegate.mFilterObject.mStuCitizenship = country;
        [oTableView reloadData];
    }
    
    else if([self.mChild isEqual:kFilterType_Religion]){
        Religion *religion = mFilterArray[sIndex];
        TFAppDelegate.mFilterObject.mStuReligion = religion;
        [oTableView reloadData];
    }
   
    else if([self.mChild isEqual:kFilterType_AcademicLevelNow]){
        AcademicLevel *academiclevel = mFilterArray[sIndex];
        TFAppDelegate.mFilterObject.mStuAca = academiclevel;
    }
    
    else if([self.mChild isEqual:kFilterType_AcademicLevel]){
        AcademicLevel *academicLv = mFilterArray[sIndex];
        TFAppDelegate.mFilterObject.mScholarAca = academicLv;
    }
    
    else if([self.mChild isEqual:kFilterType_ScholarshipType]){
        ScholarshipType *scholarshipType = mFilterArray[sIndex];
        TFAppDelegate.mFilterObject.mScholarType = scholarshipType;
    }
    // LIST
    else if([self.mChild isEqual:kFilterType_Talent]){
        Talent *talent = mFilterArray[sIndex];
        if (sSwitch) {
            [TFAppDelegate.mFilterObject.mTalents addObject:talent];
        }
        else
        {
            for (Talent *ta in TFAppDelegate.mFilterObject.mTalents) {
                if (talent.mID == ta.mID) {
                    [TFAppDelegate.mFilterObject.mTalents removeObject:ta];
                    break;
                }
            }
        }
    }
    else if([self.mChild isEqual:kFilterType_Major]){
        Major *major = mFilterArray[sIndex];
        if (sSwitch) {
            [TFAppDelegate.mFilterObject.mScholarMajors addObject:major];
        }
        else
        {
            [TFAppDelegate.mFilterObject.mScholarMajors removeObject:major];
        }
    }
    else if([self.mChild isEqual:kFilterType_Disability]){
        Disability *disability = mFilterArray[sIndex];
        //        = disability;
        if (sSwitch) {
            [TFAppDelegate.mFilterObject.mStuDisabilities addObject:disability];
        }
        else
        {
            [TFAppDelegate.mFilterObject.mStuDisabilities removeObject:disability];
        }
    }
    else if([self.mChild isEqual:kFilterType_TerminalIll]){
        TermialIll *terminalIll = mFilterArray[sIndex];

        if (sSwitch) {
            [TFAppDelegate.mFilterObject.mStuTerminalIllnesses addObject:terminalIll];
        }
        else
        {
            [TFAppDelegate.mFilterObject.mStuTerminalIllnesses removeObject:terminalIll];
        }
    }
    else if([self.mChild isEqual:kFilterType_Family_Policy]){
        FamilyPolicy *family = mFilterArray[sIndex];
        //         = family;
        if (sSwitch) {
            [TFAppDelegate.mFilterObject.mFamilyPolicy addObject:family];
        }
        else
        {
            [TFAppDelegate.mFilterObject.mFamilyPolicy removeObject:family];
        }
    }

}

#pragma mark - UITableView Datasource and Delegate
//-------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterDetailCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellId_FilterDetail];
    BOOL tIsOn = NO;
    if ([self.mChild isEqual:kFilterType_Gender]) {
        Gender *genDer = mFilterArray[indexPath.row];
        if (genDer.mID == TFAppDelegate.mFilterObject.mStuGender.mID) {
            tIsOn = YES;
        }
        [rCell setUpWithSwitchPress:indexPath.row withName:genDer.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_NoiO])
    {
        Country *country = mFilterArray[indexPath.row];
        if (country.mID == TFAppDelegate.mFilterObject.mStuCitizenship.mID) {
            tIsOn = YES;
        }
        [rCell setUpWithSwitchPress:indexPath.row withName:country.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_Religion]){
        Religion *religion = mFilterArray[indexPath.row];
        if (religion.mID == TFAppDelegate.mFilterObject.mStuReligion.mID) {
            tIsOn = YES;
        }
        [rCell setUpWithSwitchPress:indexPath.row withName:religion.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_Disability]){
        Disability *disability = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:disability.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_TerminalIll]){
        TermialIll *terminalIll = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:terminalIll.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_Family_Policy]){
        FamilyPolicy *family = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:family.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_AcademicLevelNow]){
        AcademicLevel *academiclevel = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:academiclevel.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_AcademicLevel]){
        AcademicLevel *academicLv = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:academicLv.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_Major]){
        Major *major = mFilterArray[indexPath.row];
        for (Major *ta in TFAppDelegate.mFilterObject.mTalents) {
            if (ta.mID == major.mID) {
                tIsOn = YES;
                break;
            }
        }
        [rCell setUpWithSwitchPress:indexPath.row withName:major.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_ScholarshipType]){
        ScholarshipType *scholarshipType = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:scholarshipType.mName isSwithOn:tIsOn];
    }
    else if([self.mChild isEqual:kFilterType_Talent]){
        Talent *talent = mFilterArray[indexPath.row];
        for (Talent *ta in TFAppDelegate.mFilterObject.mTalents) {
            if (ta.mID == talent.mID) {
                tIsOn = YES;
                break;
            }
        }
        [rCell setUpWithSwitchPress:indexPath.row withName:talent.mName isSwithOn:tIsOn];
    }

    rCell.mDelegate = self;
    return rCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mFilterArray.count ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
