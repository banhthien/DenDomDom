//
//  ScholarshipDetailController.m
//  DenDomDom
//
//  Created by Thien Banh on 10/27/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "ScholarshipDetailController.h"
#import "UIImageView+AFNetworking.h"
#import "CommentController.h"

#import "TFDefine.h"
#import "AppDelegate.h"

#import "Scholarship.h"
#import "FormOfParticipation.h"
#import "User.h"
#import "ScholarshipType.h"
#import "School.h"
#import "Country.h"
#import "AcademicLevel.h"
#import "AcademicLevelDetail.h"
#import "Gender.h"
#import "Ethnic.h"
#import "Religion.h"
#import "FamilyPolicy.h"
#import "Disability.h"
#import "TermialIll.h"
#import "Sponsor.h"
#import "Major.h"
#import "Talent.h"
#import "Province.h"

#import "InfoDetailCell.h"
#import "CommentCell.h"

#define kName               @"kName"
#define kHeight               @"kHeight"
#define kInfo               @"kInfo"

#define kChuyenNganh        @"Chuyên ngành"
#define kTrinhDo            @"Trình độ học vấn"
#define kTaiNang            @"Tài năng"
#define kCutru              @"Nơi cư trú"
#define kSucKhoe            @"Tình trạng sức khoẻ đặc biệt"
#define kKhuyetTat          @"Khuyết tật"
#define kHinhThuc           @"Hình thức tham gia"
#define kCongDan            @"Công dân"
#define kGiaDinh            @"Gia đình thuộc chính sách"
#define kGioiTinh           @"Giới tính"
#define kTonGiao            @"Tôn giáo"
#define kDanToc             @"Dân tộc"
#define kHoSo               @"Hồ sơ"
#define kHoTro              @"Hỗ trợ"

@interface ScholarshipDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *mBaseInfo;
    NSMutableArray *mStuInfo;
    NSMutableArray *mFormInfo;
    
    __weak IBOutlet UIButton *oCommentButton;
    __weak IBOutlet UILabel *oNameLabel;
    __weak IBOutlet UILabel *oSchoolLabel;
    __weak IBOutlet UIImageView *oImageView;
    __weak IBOutlet UILabel *oCountryButton;
}
@property (nonatomic, strong) FBSDKLoginManager *mFacebookLoginManager;
@end

@implementation ScholarshipDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [TFAppDelegate setNavigationTitle:@"CHI TIẾT" CanBack:YES ForController:self];
    [TFAppDelegate.mSlideNavigationController setLeftMenuEnable:YES];
    [self setUpView];
    [self setUpArray];
    [self setUpRightButton];
}

- (void)setUpRightButton
{
    UIButton *tRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tRightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tRightButton setImage:[UIImage imageNamed:@"Share"] forState:UIControlStateNormal];
    tRightButton.frame = CGRectMake(0, 0, 30, 30);
    [tRightButton addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tRightButton];
}

- (IBAction)shareButtonPressed:(id)sender
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    Scholarship *tScho = self.mScholarObj;
    content.contentURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://dendomdom-hadiem.rhcloud.com/all?id=%i",(int)tScho.mID]];
    
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];
}

- (float)caculatorHeight:(NSString*)text
{
    UIFont *font;
   
    font = FONT_REGULAR(14);
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect tRectLabel = [text boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width - SCREEN_SIZE.width/4 - 15, 999)
                                                        options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return tRectLabel.size.height + 25;
   
}

- (void)setUpView
{
    oNameLabel.text = self.mScholarObj.mName;
    oSchoolLabel.text = self.mScholarObj.mSchool.mName;
    NSString *tImageName = self.mScholarObj.mImagePath;
    [oImageView setImageWithURL:[NSURL URLWithString:tImageName]];
    oCommentButton.clipsToBounds= YES;
    oCommentButton.layer.cornerRadius = 5;
    if (self.mScholarObj.mCountry.mID == 0) {
        oCountryButton.text = @"";
    }
    else
    {
        oCountryButton.text = [NSString stringWithFormat:@"Quốc gia: %@",self.mScholarObj.mCountry.mName];
    }
    
}

- (void)setUpArray
{
    mBaseInfo = [[NSMutableArray alloc] init];
    mStuInfo = [[NSMutableArray alloc] init];
    mFormInfo = [[NSMutableArray alloc] init];
    
    // BASE INFO
    if (self.mScholarObj.mScholarMajors.count > 0) {
        NSString *tInfo = @"";
        for (Major *tMajor in self.mScholarObj.mScholarMajors) {
            if (tInfo.length > 0) {
               tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tMajor.mName];
            }
            else
            {
                tInfo = tMajor.mName;
            }
        }
        
         NSDictionary *tDict = @{kName : kChuyenNganh,
                                kInfo : tInfo,
                                 kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mBaseInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mScholarAcademicLvDetails.count > 0) {
        NSString *tInfo = @"";
        for (AcademicLevelDetail *tAce in self.mScholarObj.mScholarAcademicLvDetails) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tAce.mName];
            }
            else
            {
                tInfo = tAce.mName;
            }
        }
        NSDictionary *tDict = @{kName : kTrinhDo,
                                kInfo : tInfo,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mBaseInfo addObject:tDict];
    }
    
    // STUINFO
    if (self.mScholarObj.mStuGenders.count > 0) {
        NSString *tInfo = @"";
        for (Gender *tGender in self.mScholarObj.mStuGenders) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tGender.mName];
            }
            else
            {
                tInfo = tGender.mName;
            }
            
        }
         NSDictionary *tDict = @{kName : kGioiTinh,
                                 kInfo : tInfo,
                                 kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mStuInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mScholarAcademicLvDetails.count > 0) {
        NSString *tInfo = @"";
        for (AcademicLevelDetail *tAcaDe in self.mScholarObj.mScholarAcademicLvDetails) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tAcaDe.mName];
            }
            else
            {
                tInfo = tAcaDe.mName;
            }
            
        }
        NSDictionary *tDict = @{kName : kTrinhDo,
                                kInfo : tInfo,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mStuInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mStuCitizenships.count > 0) {
        NSString *tInfo = @"";
        for (Country *tCountry in self.mScholarObj.mStuCitizenships) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tCountry.mName];
            }
            else
            {
                tInfo = tCountry.mName;
            }
            
        }
        NSDictionary *tDict = @{kName : kCongDan,
                                kInfo : tInfo,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mStuInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mStuReligions.count > 0) {
        NSString *tInfo = @"";
        for (Religion *tRe in self.mScholarObj.mStuReligions) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tRe.mName];
            }
            else
            {
                tInfo = tRe.mName;
            }
            
        }
        NSDictionary *tDict = @{kName : kTonGiao,
                                kInfo : tInfo,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mStuInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mStuFamilyPolicies.count > 0) {
        NSString *tInfo = @"";
        for (FamilyPolicy *tFa in self.mScholarObj.mStuFamilyPolicies) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tFa.mName];
            }
            else
            {
                tInfo = tFa.mName;
            }
            
        }
        NSDictionary *tDict = @{kName : kGiaDinh,
                                kInfo : tInfo,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mStuInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mStuResidences.count > 0) {
        NSString *tInfo = @"";
        for (Province *tPro in self.mScholarObj.mStuResidences) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tPro.mName];
            }
            else
            {
                tInfo = tPro.mName;
            }
            
        }
        NSDictionary *tDict = @{kName : kCutru,
                                kInfo : tInfo,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mStuInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mStuDisabilities.count > 0) {
        NSString *tInfo = @"";
        for (Disability *tDis in self.mScholarObj.mStuDisabilities) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tDis.mName];
            }
            else
            {
                tInfo = tDis.mName;
            }
            
        }
        NSDictionary *tDict = @{kName : kKhuyetTat,
                                kInfo : tInfo,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mStuInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mStuEthnics.count > 0) {
        NSString *tInfo = @"";
        for (Ethnic *tEth in self.mScholarObj.mStuEthnics) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tEth.mName];
            }
            else
            {
                tInfo = tEth.mName;
            }
            
        }
        NSDictionary *tDict = @{kName : kDanToc,
                                kInfo : tInfo,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mStuInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mStuTerminalIllness.count > 0) {
        NSString *tInfo = @"";
        for (TermialIll *tTer in self.mScholarObj.mStuTerminalIllness) {
            if (tInfo.length > 0) {
                tInfo =[NSString stringWithFormat:@"%@, %@",tInfo, tTer.mName];
            }
            else
            {
                tInfo = tTer.mName;
            }
            
        }
        NSDictionary *tDict = @{kName : kSucKhoe,
                                kInfo : tInfo,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:tInfo]]};
        [mStuInfo addObject:tDict];
    }
    
    // FORM INFO
    if (self.mScholarObj.mForm.mName.length > 0) {

        NSDictionary *tDict = @{kName : kHinhThuc,
                                kInfo : self.mScholarObj.mForm.mName};
        [mFormInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mAppDes.length > 0) {
        
        NSDictionary *tDict = @{kName : kHoSo,
                                kInfo : self.mScholarObj.mAppDes};
        [mFormInfo addObject:tDict];
    }
    
    if (self.mScholarObj.mSupportDescription.length > 0) {
        
        NSDictionary *tDict = @{kName : kHoTro,
                                kInfo : self.mScholarObj.mSupportDescription,
                                kHeight : [NSNumber numberWithFloat:[self caculatorHeight:self.mScholarObj.mSupportDescription]]};
        [mFormInfo addObject:tDict];
    }
   
}

- (IBAction)actionBackButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource and Delegate
//-------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *rView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 35)];
    rView.backgroundColor = RGB(181, 235, 233);
//    rView.backgroundColor = [UIColor whiteColor];
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, SCREEN_SIZE.width - 20, 35)];
    [tLabel setTextColor:RGB(46, 46, 46)];
    tLabel.font = FONT_REGULAR(14);
    UIImageView *tBottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 34, SCREEN_SIZE.width, 1)];
    tBottomLine.image = [UIImage imageNamed:@"LineShadow_Bottom"];

    if (section == 0)
    {
        tLabel.text = @"THÔNG TIN HỌC BỔNG";
    }
    else if (section == 1)
    {
        tLabel.text = @"DÀNH CHO ĐỐI TƯỢNG";
    }
    else
    {
        tLabel.text = @"CÁCH THỨC TUYỂN";
    }
    [rView addSubview:tBottomLine];
    [rView addSubview:tLabel];
    
    return rView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tName = @"name";
    NSString *tInfo = @"info";
    if (indexPath.section == 0)
    {
        InfoDetailCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellId_InfoDetail];
        NSDictionary *tDict =mBaseInfo[indexPath.row];
        tName = [TFUtil checkStringFromDictValue:tDict[kName]];
        tInfo = [TFUtil checkStringFromDictValue:tDict[kInfo]];
        [rCell setUpCellWithName:tName withInfo:tInfo];
        return rCell;
    }
    else if (indexPath.section == 1)
    {
        InfoDetailCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellId_InfoDetail];
        NSDictionary *tDict =mStuInfo[indexPath.row];
        tName = [TFUtil checkStringFromDictValue:tDict[kName]];
        tInfo = [TFUtil checkStringFromDictValue:tDict[kInfo]];
        [rCell setUpCellWithName:tName withInfo:tInfo];
        return rCell;
    }
    else
    {
        InfoDetailCell *rCell = [tableView dequeueReusableCellWithIdentifier:kCellId_InfoDetail];
        NSDictionary *tDict =mFormInfo[indexPath.row];
        tName = [TFUtil checkStringFromDictValue:tDict[kName]];
        tInfo = [TFUtil checkStringFromDictValue:tDict[kInfo]];
        [rCell setUpCellWithName:tName withInfo:tInfo];
        return rCell;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tDict;
    if (indexPath.section == 0)
    {
        tDict = mBaseInfo[indexPath.row];
        
    }
    else if (indexPath.section == 1)
    {
        tDict =mStuInfo[indexPath.row];
    }
    else
    {
        tDict =mFormInfo[indexPath.row];

    }
    return [tDict[kHeight] floatValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return mBaseInfo.count;
    }
    else if (section == 1)
    {
        return mStuInfo.count;
    }
    else
    {
        return mFormInfo.count;
    }
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

- (IBAction)actionCommentPress:(id)sender
{
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"public_profile"]) {
        UIStoryboard *tStoryboard = kStoryboard_Main;
        CommentController *tView = [tStoryboard instantiateViewControllerWithIdentifier:kStoryboardID_CommentController];
        tView.mID = self.mScholarObj.mID;
        [self.navigationController pushViewController:tView animated:YES];
        // TODO: publish content.
    }
    else
    {
        UIStoryboard *tStoryboard = kStoryboard_Main;
        CommentController *tView = [tStoryboard instantiateViewControllerWithIdentifier:kStoryboardID_CommentController];
        tView.mID = self.mScholarObj.mID;
        [self.navigationController pushViewController:tView animated:YES];
    }
}

@end
