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
#import "Scholarship.h"

@interface FilterDetailController ()<UITableViewDataSource,UITableViewDelegate,FilterDetailCellDelegate,UISearchBarDelegate>
{
    NSInteger mType;
    NSMutableArray *mFilterArray;
    NSMutableArray *mBackUpArray;
    UISearchBar *mSearchBarTop;
    BOOL mIsRadioButton;
    NSInteger mCurrentSelected;
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
   

    mIsRadioButton = NO;
    mCurrentSelected = -1;
}


- (void)loadFilter
{
    [TFAppDelegate showConnectionInView:self.view];
    if ([self.mChild isEqual:kFilterType_Gender]) {
        [TFWebServiceManager getListGender:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_NoiO])
    {
        mSearchBarTop = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
        mSearchBarTop.showsCancelButton = NO;
         [mSearchBarTop setBarTintColor:RGB(0, 175, 240)];
        self.navigationItem.titleView = mSearchBarTop;
        [mSearchBarTop setPlaceholder:@"Bạn ở đâu"];
        mSearchBarTop.delegate = self;
        mIsRadioButton = YES;
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
        [TFWebServiceManager getListCountry:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            mBackUpArray = mFilterArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_Religion]){
        mIsRadioButton = YES;
        [TFWebServiceManager getListReligion:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_Disability]){
        [TFWebServiceManager getListDisability:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_TerminalIll]){
        [TFWebServiceManager getListTerminalIll:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_Family_Policy]){
        [TFWebServiceManager getListFamilyPolicy:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_AcademicLevelNow]){
        [TFWebServiceManager getListAcademicLevel:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_AcademicLevel]){
        [TFWebServiceManager getListAcademicLevel:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_Major]){
        mSearchBarTop = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
        mSearchBarTop.showsCancelButton = NO;
        [mSearchBarTop setBarTintColor:RGB(0, 175, 240)];
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
                    [(UITextField *)tSubView setClipsToBounds:YES];
                    ((UITextField *)tSubView).layer.cornerRadius = mSearchBarTop.layer.frame.size.height/2 - 8;
                }
            }
        }
        [TFWebServiceManager getListMajor:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            mBackUpArray = mFilterArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_ScholarshipType]){
        [TFWebServiceManager getListScholarshipType:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
        }];
    }
    else if([self.mChild isEqual:kFilterType_Talent]){
        [TFWebServiceManager getListTalent:kAPI_GetList withParam:nil success:^(id bProductArray) {
            mFilterArray = bProductArray;
            [TFAppDelegate hideConnectionInView:self.view];
            [oTableView reloadData];
        } failure:^(NSError *bError, NSString *bMessage) {
            [TFAppDelegate hideConnectionInView:self.view];
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
        
        Gender *genDer = mFilterArray[sIndex];
        if ( TFAppDelegate.mFilterObject.mStuGender.mID == genDer.mID) {
            mCurrentSelected = -1;
            TFAppDelegate.mFilterObject.mStuGender = nil;
            return;
        }
        
        if (mCurrentSelected != -1) {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:mCurrentSelected inSection:0] ;
            UITableViewCell *cell = [oTableView cellForRowAtIndexPath:myIP];
            [((FilterDetailCell*)cell) setSwitch:NO];
        }
        
        mCurrentSelected = sIndex;
        TFAppDelegate.mFilterObject.mStuGender = genDer;
        [oTableView reloadData];
    }
    
    else if([self.mChild isEqual:kFilterType_NoiO])
    {
        Country *country = mFilterArray[sIndex];
        if ( TFAppDelegate.mFilterObject.mStuCitizenship.mID == country.mID) {
            mCurrentSelected = -1;
            TFAppDelegate.mFilterObject.mStuCitizenship = nil;
            return;
        }
        
        if (mCurrentSelected != -1) {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:mCurrentSelected inSection:0] ;
            UITableViewCell *cell = [oTableView cellForRowAtIndexPath:myIP];
            [((FilterDetailCell*)cell) setSwitch:NO];
        }
        
        mCurrentSelected = sIndex;
        TFAppDelegate.mFilterObject.mStuCitizenship = country;
        [oTableView reloadData];
    }
    
    else if([self.mChild isEqual:kFilterType_Religion]){
        Religion *religion = mFilterArray[sIndex];
        if ( TFAppDelegate.mFilterObject.mStuReligion.mID == religion.mID) {
            mCurrentSelected = -1;
            TFAppDelegate.mFilterObject.mStuReligion = nil;
            return;
        }
        
        if (mCurrentSelected != -1) {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:mCurrentSelected inSection:0] ;
            UITableViewCell *cell = [oTableView cellForRowAtIndexPath:myIP];
            [((FilterDetailCell*)cell) setSwitch:NO];
        }
        mCurrentSelected = sIndex;
        TFAppDelegate.mFilterObject.mStuReligion = religion;
        [oTableView reloadData];
    }
   
    else if([self.mChild isEqual:kFilterType_AcademicLevelNow]){
        AcademicLevel *academiclevel = mFilterArray[sIndex];
        if ( TFAppDelegate.mFilterObject.mStuAca.mID == academiclevel.mID) {
            mCurrentSelected = -1;
            TFAppDelegate.mFilterObject.mStuAca = nil;
            return;
        }
        
        if (mCurrentSelected != -1) {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:mCurrentSelected inSection:0] ;
            UITableViewCell *cell = [oTableView cellForRowAtIndexPath:myIP];
            [((FilterDetailCell*)cell) setSwitch:NO];
        }
        mCurrentSelected = sIndex;
        TFAppDelegate.mFilterObject.mStuAca = academiclevel;
        [oTableView reloadData];
    }
    
    else if([self.mChild isEqual:kFilterType_AcademicLevel]){
        AcademicLevel *academicLv = mFilterArray[sIndex];
        if ( TFAppDelegate.mFilterObject.mScholarAca.mID == academicLv.mID) {
            mCurrentSelected = -1;
            TFAppDelegate.mFilterObject.mScholarAca = nil;
            return;
        }
        
        if (mCurrentSelected != -1) {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:mCurrentSelected inSection:0] ;
            UITableViewCell *cell = [oTableView cellForRowAtIndexPath:myIP];
            [((FilterDetailCell*)cell) setSwitch:NO];
        }
         mCurrentSelected = sIndex;
        TFAppDelegate.mFilterObject.mScholarAca = academicLv;
        [oTableView reloadData];
    }
    
    else if([self.mChild isEqual:kFilterType_ScholarshipType]){
        ScholarshipType *scholarshipType = mFilterArray[sIndex];
        if ( TFAppDelegate.mFilterObject.mScholarType.mID == scholarshipType.mID) {
            mCurrentSelected = -1;
            TFAppDelegate.mFilterObject.mScholarType = nil;
            return;
        }
        
        else  {
            NSIndexPath *myIP = [NSIndexPath indexPathForRow:mCurrentSelected inSection:0] ;
            UITableViewCell *cell = [oTableView cellForRowAtIndexPath:myIP];
            [((FilterDetailCell*)cell) setSwitch:NO];
        }
        mCurrentSelected = sIndex;
        TFAppDelegate.mFilterObject.mScholarType = scholarshipType;
        mCurrentSelected = sIndex;
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
            for (Major *ma in TFAppDelegate.mFilterObject.mScholarMajors) {
                if (major.mID == ma.mID) {
                    [TFAppDelegate.mFilterObject.mScholarMajors removeObject:ma];
                    break;
                }
            }
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
            for (Disability *di in TFAppDelegate.mFilterObject.mStuDisabilities) {
                if (disability.mID == di.mID) {
                    [TFAppDelegate.mFilterObject.mStuDisabilities removeObject:di];
                    break;
                }
            }
        }
    }
    else if([self.mChild isEqual:kFilterType_TerminalIll]){
        TermialIll *terminalIll = mFilterArray[sIndex];

        if (sSwitch) {
            [TFAppDelegate.mFilterObject.mStuTerminalIllnesses addObject:terminalIll];
        }
        else
        {
            for (TermialIll *te in TFAppDelegate.mFilterObject.mStuTerminalIllnesses) {
                if (terminalIll.mID == te.mID) {
                    [TFAppDelegate.mFilterObject.mStuTerminalIllnesses removeObject:te];
                    break;
                }
            }
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
            for (FamilyPolicy *fa in TFAppDelegate.mFilterObject.mFamilyPolicy) {
                if (family.mID == fa.mID) {
                    [TFAppDelegate.mFilterObject.mFamilyPolicy removeObject:fa];
                    break;
                }
            }
        }
    }

}

#pragma mark - UITableView Datasource and Delegate
//-------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterDetailCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellId_FilterDetail];

    if ([self.mChild isEqual:kFilterType_Gender]) {
        Gender *genDer = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:genDer.mName];
        if (genDer.mID == TFAppDelegate.mFilterObject.mStuGender.mID) {
            mCurrentSelected = indexPath.row;
            [rCell setSwitch:YES];
        }
        else
        {
            [rCell setSwitch:NO];
        }
        
    }
    else if([self.mChild isEqual:kFilterType_NoiO])
    {
        Country *country = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:country.mName];
        if (country.mID == TFAppDelegate.mFilterObject.mStuCitizenship.mID) {
            mCurrentSelected = indexPath.row;
            [rCell setSwitch:YES];
        }
        else
        {
            [rCell setSwitch:NO];
        }
        
    }
    else if([self.mChild isEqual:kFilterType_Religion]){
        Religion *religion = mFilterArray[indexPath.row];
        
        [rCell setUpWithSwitchPress:indexPath.row withName:religion.mName];
        if (religion.mID == TFAppDelegate.mFilterObject.mStuReligion.mID) {
            mCurrentSelected = indexPath.row;
            [rCell setSwitch:YES];
        }
        else
        {
            [rCell setSwitch:NO];
        }
    }
    else if([self.mChild isEqual:kFilterType_Disability]){
        Disability *disability = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:disability.mName];
        
        for (Disability *tDis in TFAppDelegate.mFilterObject.mStuDisabilities) {
            if (tDis.mID == disability.mID) {

                [rCell setSwitch:YES];
                rCell.mDelegate = self;
                return rCell;
            }
            else
            {
                [rCell setSwitch:NO];
            }
        }
    }
    else if([self.mChild isEqual:kFilterType_TerminalIll]){
        TermialIll *terminalIll = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:terminalIll.mName];
        for (TermialIll *te in TFAppDelegate.mFilterObject.mStuTerminalIllnesses) {
            if (te.mID == terminalIll.mID) {
                
                [rCell setSwitch:YES];
                rCell.mDelegate = self;
                return rCell;
            }
            else
            {
                [rCell setSwitch:NO];
            }
        }
    }
    else if([self.mChild isEqual:kFilterType_Family_Policy]){
        FamilyPolicy *family = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:family.mName];
        for (FamilyPolicy *fa in TFAppDelegate.mFilterObject.mFamilyPolicy) {
            if (fa.mID == family.mID) {
                
                [rCell setSwitch:YES];
                rCell.mDelegate = self;
                return rCell;
            }
            else
            {
                [rCell setSwitch:NO];
            }
        }
        
    }
    else if([self.mChild isEqual:kFilterType_AcademicLevelNow]){
        AcademicLevel *academiclevel = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:academiclevel.mName];
        if (academiclevel.mID == TFAppDelegate.mFilterObject.mStuAca.mID) {
            mCurrentSelected = indexPath.row;
            [rCell setSwitch:YES];
        }
        else
        {
            [rCell setSwitch:NO];
        }
    }
    else if([self.mChild isEqual:kFilterType_AcademicLevel]){
        AcademicLevel *academicLv = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:academicLv.mName];
        if (academicLv.mID == TFAppDelegate.mFilterObject.mScholarAca.mID) {
            mCurrentSelected = indexPath.row;
            [rCell setSwitch:YES];
        }
        else
        {
            [rCell setSwitch:NO];
        }
    }
    else if([self.mChild isEqual:kFilterType_Major]){
        Major *major = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:major.mName];
        for (Major *ma in TFAppDelegate.mFilterObject.mScholarMajors) {
            if (ma.mID == major.mID) {
                
                [rCell setSwitch:YES];
                rCell.mDelegate = self;
                return rCell;
            }
            else
            {
                [rCell setSwitch:NO];
            }
        }

    }
    else if([self.mChild isEqual:kFilterType_ScholarshipType]){
        ScholarshipType *scholarshipType = mFilterArray[indexPath.row];
        [rCell setUpWithSwitchPress:indexPath.row withName:scholarshipType.mName];
        if (scholarshipType.mID == TFAppDelegate.mFilterObject.mScholarType.mID) {
            mCurrentSelected = indexPath.row;
            [rCell setSwitch:YES];
        }
        else
        {
            [rCell setSwitch:NO];
        }
    }
    else if([self.mChild isEqual:kFilterType_Talent]){
        Talent *talent = mFilterArray[indexPath.row];
//        if (talent.mID == TFAppDelegate.mFilterObject.mTalents.mID) {
//            [rCell setSwitch:YES];
//        }
        [rCell setUpWithSwitchPress:indexPath.row withName:talent.mName];
        for (Talent *tta in TFAppDelegate.mFilterObject.mTalents) {
            if (tta.mID == talent.mID) {
                
                [rCell setSwitch:YES];
                rCell.mDelegate = self;
                return rCell;
            }
            else
            {
                [rCell setSwitch:NO];
            }
        }


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
