//
//  Scholarship.m
//  DenDomDom
//
//  Created by Thien Banh on 11/14/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

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


#define kAPIDict_ID                 @"id"
#define kAPIDict_Name               @"name"
#define kAPIDict_DateEndRegister    @"dateEndRegister"
#define kAPIDict_valueMax           @"valueMax"
#define kAPIDict_valueMin           @"valueMin"
#define kAPIDict_CreateTime         @"createdTime"
#define kAPIDict_ModifiedTime       @"modifiedTime"
#define kAPIDict_Image              @"imgPath"
#define kAPIDict_IsActive           @"isActive"
#define kAPIDict_ViewCount          @"viewCount"

#define kAPIDict_LastModifiedUser   @"lastModifiedUser"


#define kAPIDict_Specification                  @"scholarshipSpecification"
#define kAPIDict_AppDes                         @"applicationDescription"
#define kAPIDict_OriginalLink                   @"originalLink"
#define kAPIDict_Description                    @"description"
#define kAPIDict_majorDescription               @"majorDescription"
#define kAPIDict_Count                          @"count"
#define kAPIDict_supportDescription             @"supportDescription"


#define kAPIDict_formOfParticipation                @"formOfParticipation"
#define kAPIDict_scholarshipCountry                 @"scholarshipCountry"
#define kAPIDict_scholarshipAcademicLevelDetails    @"scholarshipAcademicLevelDetails"
#define kAPIDict_scholarshipMajors                  @"scholarshipMajors"
#define kAPIDict_scholarshipType                    @"scholarshipType"
#define kAPIDict_school                             @"school"
#define kAPIDict_sponsors                           @"sponsors"
#define kAPIDict_studentAcademicLevelDetails        @"studentAcademicLevelDetails"

#define kAPIDict_studentCitizenships                @"studentCitizenships"
#define kAPIDict_studentDisabilities                @"studentDisabilities"
#define kAPIDict_studentEthnics                     @"studentEthnics"
#define kAPIDict_studentFamilyPolicies              @"studentFamilyPolicies"
#define kAPIDict_studentGenders                     @"studentGenders"
#define kAPIDict_studentReligions                   @"studentReligions"
#define kAPIDict_studentResidences                  @"studentResidences"
#define kAPIDict_studentTalents                     @"studentTalents"
#define kAPIDict_studentTerminalIllnesses           @"studentTerminalIllnesses"





@implementation Scholarship

- (instancetype)initWithDictionary:(NSDictionary *)sDict
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    [self initList];
    @try {
        self.mID = [sDict[kAPIDict_ID] integerValue];
        self.mName = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Name]];
        self.mMaxValue = [sDict[kAPIDict_valueMax] doubleValue];
        self.mMinValue = [sDict[kAPIDict_valueMin] doubleValue];
        
        self.mViewCount = [sDict[kAPIDict_ViewCount] integerValue];
        self.mDateEndRegister = [sDict[kAPIDict_DateEndRegister] doubleValue];
        self.mIsActive = [sDict[kAPIDict_IsActive] boolValue];
        self.mImagePath = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Image]];
        self.mModifiedTime = [sDict[kAPIDict_ModifiedTime] doubleValue];
        self.mCreateTime = [sDict[kAPIDict_CreateTime] doubleValue];
        
        id objectUser = sDict[kAPIDict_LastModifiedUser];
        if(objectUser != [NSNull null])
        {
            NSDictionary *tModifiedUser = sDict[kAPIDict_LastModifiedUser];
            self.mLastModifiedUser = [[User alloc] initWithDictionary:tModifiedUser];
        }
        else
        {
            self.mLastModifiedUser = nil;
        }
        
        //Specifications
        NSDictionary *tSpecifiDict = sDict[kAPIDict_Specification];
        
        self.mAppDes = [TFUtil checkStringFromDictValue:tSpecifiDict[kAPIDict_AppDes]];
        self.mDescription = [TFUtil checkStringFromDictValue:tSpecifiDict[kAPIDict_Description]];
        self.mOriginLink = [TFUtil checkStringFromDictValue:tSpecifiDict[kAPIDict_OriginalLink]];
        self.mCount = [TFUtil checkStringFromDictValue:tSpecifiDict[kAPIDict_Count]];
        self.mSupportDescription = [TFUtil checkStringFromDictValue:tSpecifiDict[kAPIDict_supportDescription]];
        self.mMajorDes = [TFUtil checkStringFromDictValue:tSpecifiDict[kAPIDict_majorDescription]];
        
        //formOfParticipation
        id objComment = [tSpecifiDict objectForKey:kAPIDict_formOfParticipation];
        if (objComment != [NSNull null])
        {
            NSDictionary *tFormDict = tSpecifiDict[kAPIDict_formOfParticipation];
            self.mForm = [[FormOfParticipation alloc] initWithDictionary:tFormDict];
        }
        else
        {
            self.mForm = nil;
        }
        
        //ScholarshipType
        id objScholarType = [tSpecifiDict objectForKey:kAPIDict_scholarshipType];
        if (objScholarType != [NSNull null])
        {
            NSDictionary *tScholarType = tSpecifiDict[kAPIDict_scholarshipType];
            self.mScholarshipType = [[ScholarshipType alloc] initWithDictionary:tScholarType];
        }
        else
        {
            self.mScholarshipType = nil;
        }
        
        //School
        id objSchool = [tSpecifiDict objectForKey:kAPIDict_school];
        if (objSchool != [NSNull null])
        {
            NSDictionary *tSchool = tSpecifiDict[kAPIDict_school];
            self.mSchool = [[School alloc] initWithDictionary:tSchool];
        }
        else
        {
            self.mSchool = nil;
        }
        
        //Country
        id objCountry= [tSpecifiDict objectForKey:kAPIDict_scholarshipCountry];
        if (objCountry != [NSNull null])
        {
            NSDictionary *tCountry = tSpecifiDict[kAPIDict_scholarshipCountry];
            self.mCountry = [[Country alloc] initWithDictionary:tCountry];
        }
        else
        {
            self.mCountry = nil;
        }
        
        //Set AcademicLevel Details of student
        
        id objAcademicLvDetails= [tSpecifiDict objectForKey:kAPIDict_studentAcademicLevelDetails];
        if (objAcademicLvDetails != [NSNull null])
        {
            for (NSDictionary *tDict in objAcademicLvDetails)
            {
                AcademicLevelDetail *tObj = [[AcademicLevelDetail alloc] initWithDictionary:tDict];
                [self.mStuAcademicLvDetails addObject:tObj];
            }
        }
        else
        {
            self.mStuAcademicLvDetails = nil;
        }
        
        //Set Student's Countries
        id objStuCountry = [tSpecifiDict objectForKey:kAPIDict_studentCitizenships];
        if (objStuCountry != [NSNull null])
        {
            for (NSDictionary *tDict in objStuCountry)
            {
                Country *tObj = [[Country alloc] initWithDictionary:tDict];
                [self.mStuCitizenships addObject:tObj];
            }
        }
        else
        {
            self.mStuCitizenships = nil;
        }

        //Set AcademicLevelDetails of Scholarship
        id objAcademicLvDtScho= [tSpecifiDict objectForKey:kAPIDict_scholarshipAcademicLevelDetails];
        if (objAcademicLvDtScho != [NSNull null])
        {
            for (NSDictionary *tDict in objAcademicLvDtScho)
            {
                AcademicLevelDetail *tObj = [[AcademicLevelDetail alloc] initWithDictionary:tDict];
                [self.mScholarAcademicLvDetails addObject:tObj];
            }
        }
        else
        {
            self.mScholarAcademicLvDetails = nil;
        }
        
        //Set Student's Genders
        id objStuGender= [tSpecifiDict objectForKey:kAPIDict_studentGenders];
        if (objStuGender != [NSNull null])
        {
            for (NSDictionary *tDict in objStuGender)
            {
                Gender *tObj = [[Gender alloc] initWithDictionary:tDict];
                [self.mStuGenders addObject:tObj];
            }
        }
        else
        {
            self.mStuGenders = nil;
        }
        
        //Set Student's Ethnics
        id objStuEthnic= [tSpecifiDict objectForKey:kAPIDict_studentEthnics];
        if (objStuEthnic != [NSNull null])
        {
            for (NSDictionary *tDict in objStuEthnic)
            {
                Ethnic *tObj = [[Ethnic alloc] initWithDictionary:tDict];
                [self.mStuEthnics addObject:tObj];
            }
        }
        else
        {
            self.mStuEthnics = nil;
        }
        
        //SET RELIGION
        id objStuReligions= [tSpecifiDict objectForKey:kAPIDict_studentReligions];
        if (objStuReligions != [NSNull null])
        {
            for (NSDictionary *tDict in objStuReligions)
            {
                Religion *tObj = [[Religion alloc] initWithDictionary:tDict];
                [self.mStuReligions addObject:tObj];
            }
        }
        else
        {
            self.mStuReligions = nil;
        }
        
        //Set FamilyPolicies Student
        id objStuFamilyPolicies= [tSpecifiDict objectForKey:kAPIDict_studentFamilyPolicies];
        if (objStuFamilyPolicies != [NSNull null])
        {
            for (NSDictionary *tDict in objStuFamilyPolicies)
            {
                FamilyPolicy *tObj = [[FamilyPolicy alloc] initWithDictionary:tDict];
                [self.mStuFamilyPolicies addObject:tObj];
            }
        }
        else
        {
            self.mStuFamilyPolicies = nil;
        }
        
        //Set Student's Disabilities
        id objStuDisabilities= [tSpecifiDict objectForKey:kAPIDict_studentDisabilities];
        if (objStuDisabilities != [NSNull null])
        {
            for (NSDictionary *tDict in objStuDisabilities)
            {
                Disability *tObj = [[Disability alloc] initWithDictionary:tDict];
                [self.mStuDisabilities addObject:tObj];
            }
        }
        else
        {
            self.mStuDisabilities = nil;
        }
        
        //Set Student's TerminalIllnesses
        id objStuTerminalIll= [tSpecifiDict objectForKey:kAPIDict_studentTerminalIllnesses];
        if (objStuTerminalIll != [NSNull null])
        {
            for (NSDictionary *tDict in objStuTerminalIll)
            {
                TermialIll *tObj = [[TermialIll alloc] initWithDictionary:tDict];
                [self.mStuTerminalIllness addObject:tObj];
            }
        }
        else
        {
            self.mStuTerminalIllness = nil;
        }
        
        //Set Sponsors
        id objSponsors= [tSpecifiDict objectForKey:kAPIDict_sponsors];
        if (objSponsors != [NSNull null])
        {
            for (NSDictionary *tDict in objSponsors)
            {
                Sponsor *tObj = [[Sponsor alloc] initWithDictionary:tDict];
                [self.mSponsors addObject:tObj];
            }
        }
        else
        {
            self.mSponsors = nil;
        }
        
        //Set Scholarship Major
        id objScholarMajors = [tSpecifiDict objectForKey:kAPIDict_scholarshipMajors];
        if (objScholarMajors != [NSNull null])
        {
            for (NSDictionary *tDict in objScholarMajors)
            {
                Major *tObj = [[Major alloc] initWithDictionary:tDict];
                [self.mScholarMajors addObject:tObj];
            }
        }
        else
        {
            self.mScholarMajors = nil;
        }
        
        //Set StudentTalents
        id objStuTalents = [tSpecifiDict objectForKey:kAPIDict_studentTalents];
        if (objStuTalents != [NSNull null])
        {
            for (NSDictionary *tDict in objStuTalents)
            {
                Talent *tObj = [[Talent alloc] initWithDictionary:tDict];
                [self.mStuTalents addObject:tObj];
            }
        }
        else
        {
            self.mStuTalents = nil;
        }
        
        //Set Residences
        id objStuResidences = [tSpecifiDict objectForKey:kAPIDict_studentResidences];
        if (objStuResidences != [NSNull null])
        {
            for (NSDictionary *tDict in objStuResidences)
            {
                Province *tObj = [[Province alloc] initWithDictionary:tDict];
                [self.mStuResidences addObject:tObj];
            }
        }
        else
        {
            self.mStuResidences = nil;
        }
        
        //height of cell
        UIFont *font;
        if (IS_IPAD)
        {
            font = FONT_REGULAR(18);
        }
        else
        {
            font = FONT_REGULAR(14);
        }
        NSDictionary *attributes = @{NSFontAttributeName: font};
        CGRect tRectLabel = [self.mDescription boundingRectWithSize:CGSizeMake(SCREEN_SIZE.width - 90, 999)
                                                        options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        self.mCellHeight = tRectLabel.size.height + 280;


    }
    @catch (NSException *exception) {
        return nil;
        NSLog(@"%@",exception);
    }
    
    
    return self;
}

- (void)initList
{
    self.mStuAcademicLvDetails = [[NSMutableArray alloc] init];
    self.mStuCitizenships = [[NSMutableArray alloc] init];
    self.mStuDisabilities = [[NSMutableArray alloc] init];
    self.mStuEthnics = [[NSMutableArray alloc] init];
    self.mStuFamilyPolicies = [[NSMutableArray alloc] init];
    self.mStuGenders = [[NSMutableArray alloc] init];
    self.mStuReligions = [[NSMutableArray alloc] init];
    self.mStuResidences = [[NSMutableArray alloc] init];
    self.mStuTalents = [[NSMutableArray alloc] init];
    self.mStuTerminalIllness = [[NSMutableArray alloc] init];
    self.mScholarMajors = [[NSMutableArray alloc] init];
}
@end
