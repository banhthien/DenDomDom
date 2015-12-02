//
//  FilterController.m
//  DenDomDom
//
//  Created by Thien Banh on 10/29/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "FilterController.h"
#import "FilterCell.h"
#import "FilterDetailController.h"

#import "FilterObject.h"
#import "Gender.h"
#import "Country.h"
#import "Province.h"
#import "Religion.h"
#import "AcademicLevel.h"
#import "AcademicLevelDetail.h"
#import "ScholarshipType.h"

#import "Disability.h"
#import "TermialIll.h"
#import "Major.h"
#import "FamilyPolicy.h"
#import "Talent.h"

@interface FilterController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrObject;
    NSMutableArray *arrAcademicLevel;
    NSMutableArray *arrTypeScholar;
    NSString *mSectionName;
    NSString *mChildName;
    // OUTLET
    __weak IBOutlet UITableView *oTableView;
}
- (IBAction)actionFilterPress:(id)sender;
@end

@implementation FilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [TFAppDelegate setNavigationTitle:@"Lọc" CanBack:YES ForController:self];
    [self loadMenuArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [oTableView reloadData];
}

- (void)loadMenuArray
{
    arrObject = [[NSMutableArray alloc] init];
    arrAcademicLevel = [[NSMutableArray alloc] init];
    arrTypeScholar = [[NSMutableArray alloc] init];
    
    arrObject = TFAppDelegate.mListFilter[0];
    arrAcademicLevel = TFAppDelegate.mListFilter[1];
    arrTypeScholar = TFAppDelegate.mListFilter[2];
    
}
- (IBAction)actionBackButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Datasource and Delegate
//-------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *rView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 30)];
    rView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_SIZE.width - 20, 30)];
    tLabel.font = FONT_LIGHT(14);
    if (section == 0)
    {
        tLabel.text = @"Đối tượng tham gia";
    }
    else if (section == 1)
    {
        tLabel.text = @"Trình độ học vấn";
    }
    else
    {
        tLabel.text = @"Loại học bổng";
    }
    [rView addSubview:tLabel];
    
    return rView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterCell *rCell = [tableView dequeueReusableCellWithIdentifier: kCellId_Filter];
    NSString *tName;
    NSString *tStatus;
    if (indexPath.section == 0) {
         tName = [TFUtil checkStringFromDictValue:((NSDictionary*)arrObject[indexPath.row])[@"property"]];
        
        if ([tName isEqual:kFilterType_Gender]) {
            tStatus = TFAppDelegate.mFilterObject.mStuGender.mName;
        }
        else if([tName isEqual:kFilterType_NoiO])
        {
            tStatus = TFAppDelegate.mFilterObject.mStuCitizenship.mName;
        }
        else if([tName isEqual:kFilterType_Religion]){
           tStatus = TFAppDelegate.mFilterObject.mStuReligion.mName;
        }
        else if([tName isEqual:kFilterType_Disability]){
            if (TFAppDelegate.mFilterObject.mStuDisabilities.count > 0) {
                if (TFAppDelegate.mFilterObject.mStuDisabilities.count == 1) {
                    tStatus = ((Disability*)TFAppDelegate.mFilterObject.mStuDisabilities[0]).mName;
                }
                else
                {
                    tStatus = [NSString stringWithFormat:@"%@...",((Disability*)TFAppDelegate.mFilterObject.mStuDisabilities[0]).mName];
                }
            }
            else
            {
               tStatus = @"";
            }
        }
        else if([tName isEqual:kFilterType_TerminalIll]){
            if (TFAppDelegate.mFilterObject.mStuTerminalIllnesses.count > 0) {
                if (TFAppDelegate.mFilterObject.mStuTerminalIllnesses.count == 1) {
                    tStatus = ((TermialIll*)TFAppDelegate.mFilterObject.mStuTerminalIllnesses[0]).mName;
                    
                }
                else
                {
                    tStatus = [NSString stringWithFormat:@"%@...",((TermialIll*)TFAppDelegate.mFilterObject.mStuTerminalIllnesses[0]).mName];
                }
            }
            else
            {
                tStatus = @"";
            }
        }
        else if([tName isEqual:kFilterType_Family_Policy]){
            if (TFAppDelegate.mFilterObject.mFamilyPolicy.count > 0) {
                if (TFAppDelegate.mFilterObject.mFamilyPolicy.count == 1) {
                    tStatus = ((FamilyPolicy*)TFAppDelegate.mFilterObject.mFamilyPolicy[0]).mName;
                    
                }
                else
                {
                    tStatus = [NSString stringWithFormat:@"%@...",((FamilyPolicy*)TFAppDelegate.mFilterObject.mFamilyPolicy[0]).mName];
                }
            }
            else
            {
                tStatus = @"";
            }
        }



    }
    else if (indexPath.section == 1) {
        tName = [TFUtil checkStringFromDictValue:((NSDictionary*)arrAcademicLevel[indexPath.row])[@"property"]];
        
        if([tName isEqual:kFilterType_AcademicLevelNow]){
            tStatus = TFAppDelegate.mFilterObject.mStuAca.mName;
        }
        else if([tName isEqual:kFilterType_AcademicLevel]){
            tStatus = TFAppDelegate.mFilterObject.mScholarAca.mName;
        }
        else if([tName isEqual:kFilterType_Major]){
            if (TFAppDelegate.mFilterObject.mScholarMajors.count > 0) {
                if (TFAppDelegate.mFilterObject.mScholarMajors.count == 1) {
                     tStatus = ((Major*)TFAppDelegate.mFilterObject.mScholarMajors[0]).mName;
                    
                }
                else
                {
                   tStatus = [NSString stringWithFormat:@"%@...",((Major*)TFAppDelegate.mFilterObject.mScholarMajors[0]).mName];
                }
            }
            else
            {
                tStatus = @"";
            }

        }

    }
    else
    {
        tName = [TFUtil checkStringFromDictValue:((NSDictionary*)arrTypeScholar[indexPath.row])[@"property"]];
        if([tName isEqual:kFilterType_ScholarshipType]){
            tStatus = TFAppDelegate.mFilterObject.mScholarType.mName;
        }
        else if([tName isEqual:kFilterType_Talent]){
            if (TFAppDelegate.mFilterObject.mTalents.count > 0) {
                if (TFAppDelegate.mFilterObject.mTalents.count == 1) {
                    tStatus = ((Talent*)TFAppDelegate.mFilterObject.mTalents[0]).mName;
                    
                }
                else
                {
                    tStatus = [NSString stringWithFormat:@"%@...",((Talent*)TFAppDelegate.mFilterObject.mTalents[0]).mName];
                }
            }
            else
            {
                tStatus = @"";
            }

        }
        ;
    }

    [rCell setUpCellWith:tName withStatus:tStatus];
    return rCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return arrObject.count;
    }
    else if (section == 1)
    {
        return arrAcademicLevel.count;
    }
    else
    {
        return arrTypeScholar.count;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *tName = [TFUtil checkStringFromDictValue:((NSDictionary*)arrObject[indexPath.row])[@"property"]];
       mChildName = tName;
       
    }
    else if (indexPath.section == 1)
    {
        NSString *tName = [TFUtil checkStringFromDictValue:((NSDictionary*)arrAcademicLevel[indexPath.row])[@"property"]];
        mChildName = tName;
    }
    else
    {
        NSString *tName = [TFUtil checkStringFromDictValue:((NSDictionary*)arrTypeScholar[indexPath.row])[@"property"]];
        mChildName = tName;
    }
   
    [self performSegueWithIdentifier:kSegue_Push_Filter_FilterDetail sender:nil];
}

#pragma mark - Navigation
//----------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegue_Push_Filter_FilterDetail])
    {
        FilterDetailController *tController = (FilterDetailController *)segue.destinationViewController;
        tController.mChild = mChildName;
    }

}


- (IBAction)actionFilterPress:(id)sender
{
    TFAppDelegate.mCurrentState = kFilterFilter;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
