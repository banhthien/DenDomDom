//
//  FilterObject.m
//  DenDomDom
//
//  Created by Thien Banh on 11/21/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

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
#import "FamilyPolicy.h"
#import "Talent.h"
#import "Major.h"
#define nilObj          @[]

@implementation FilterObject

- (id)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.pageNumber = 1;
    self.size = 10;
    self.mStuGender = [[Gender alloc] init];
    self.mStuCitizenship = [[Country alloc]init];
    self.mStuResidenceCity = [[Country alloc] init];
    self.mStuResidenceProvince = [[Province alloc] init];
    self.mStuReligion = [[Religion alloc] init];
    self.mStuAca = [[AcademicLevel alloc] init];
    self.mStuAcaDetail = [[AcademicLevelDetail alloc] init];
    self.mScholarAca = [[AcademicLevel alloc] init];
    self.mScholarAcaDetail = [[AcademicLevelDetail alloc] init];
    self.mScholarType = [[ScholarshipType alloc] init];
    
    self.mScholarshipCountry = [[Country alloc] init];
    
    self.mStuDisabilities = [[NSMutableArray alloc] init];
    self.mStuTerminalIllnesses = [[NSMutableArray alloc] init];
    self.mFamilyPolicy = [[NSMutableArray alloc] init];
    self.mScholarMajors = [[NSMutableArray alloc] init];
    self.mTalents = [[NSMutableArray alloc] init];
    
    self.mKeyword = @"";
    return self;
}

- (NSDictionary*)getFilterDict
{
    NSDictionary *tDict = @{@"pageNumber": [NSNumber numberWithInteger:self.pageNumber],
                            @"size": [NSNumber numberWithInteger:self.size],
                            @"scholarCountry":[NSNumber numberWithInteger:self.mScholarshipCountry.mID]};
    
    NSDictionary *tParams = @{@"stuGender":[NSNumber numberWithInteger:self.mStuGender.mID],@"stuCitizenship":[NSNumber numberWithInteger:self.mStuCitizenship.mID],@"stuResidenceCity":[NSNumber numberWithInteger:self.mStuResidenceCity.mID],@"stuResidenceProvince":[NSNumber numberWithInteger:self.mStuResidenceProvince.mID],@"stuReligion":[NSNumber numberWithInteger:self.mStuReligion.mID],@"stuAca":[NSNumber numberWithInteger:self.mStuAca.mID],@"stuAcaDetail":[NSNumber numberWithInteger:self.mStuAcaDetail.mID],@"scholarAca":[NSNumber numberWithInteger:self.mScholarAca.mID],@"scholarAcaDetails":[NSNumber numberWithInteger:self.mScholarAcaDetail.mID],@"scholarType":[NSNumber numberWithInteger:self.mScholarType.mID],@"keyword":self.mKeyword};
    
    NSMutableDictionary *tMutableDict = [NSMutableDictionary dictionaryWithDictionary:tParams];
    NSMutableArray *tArray = [[NSMutableArray alloc] init];
    
    if (self.mStuDisabilities.count > 0) {
        for (Disability *ta in self.mStuDisabilities) {
            [tArray addObject:[NSNumber numberWithInteger:ta.mID]];
        }
        [tMutableDict setObject:tArray forKey:@"stuDisabilities"];
    }
    else
    {
        [tMutableDict setObject:nilObj forKey:@"stuDisabilities"];
    }
    
    if (self.mStuTerminalIllnesses.count > 0) {
        for (TermialIll *ta in self.mStuTerminalIllnesses) {
            [tArray addObject:[NSNumber numberWithInteger:ta.mID]];
        }
        [tMutableDict setObject:tArray forKey:@"stuTerminalIllnesses"];
    }
    else
    {
        [tMutableDict setObject:nilObj forKey:@"stuTerminalIllnesses"];
    }
    
    if (self.mFamilyPolicy.count > 0) {
        for (FamilyPolicy *ta in self.mFamilyPolicy) {
            [tArray addObject:[NSNumber numberWithInteger:ta.mID]];
        }
        [tMutableDict setObject:tArray forKey:@"familyPolicy"];
    }
    else
    {
        [tMutableDict setObject:nilObj forKey:@"familyPolicy"];
    }
    
    if (self.mScholarMajors.count > 0) {
        for (Major *ta in self.mScholarMajors) {
            [tArray addObject:[NSNumber numberWithInteger:ta.mID]];
        }
        [tMutableDict setObject:tArray forKey:@"scholarMajors"];
    }
    else
    {
        [tMutableDict setObject:nilObj forKey:@"scholarMajors"];
    }
    
    if (self.mTalents.count > 0) {
        
        for (Talent *ta in self.mTalents) {
            [tArray addObject:[NSNumber numberWithInteger:ta.mID]];
        }
        [tMutableDict setObject:tArray forKey:@"talents"];
    }
    else
    {
        [tMutableDict setObject:nilObj forKey:@"talents"];
    }
    
    NSMutableDictionary *tFinalDict = [NSMutableDictionary dictionaryWithDictionary:tDict];
    [tFinalDict setObject:tMutableDict forKey:@"filterModel"];
    
    return tFinalDict;
}

//NSDictionary *tParam = @{@"pageNumber":@1,@"size":@12,@"filterModel":@{@"stuGender":@0,@"stuCitizenship":@0,@"stuResidenceCity":@0,@"stuResidenceProvince":@0,@"stuReligion":@0,@"stuDisabilities":@[],@"stuTerminalIllnesses":@[],@"familyPolicy":@[],@"stuAca":@0,@"stuAcaDetail":@0,@"scholarAca":@0,@"scholarAcaDetails":@0,@"scholarMajors":@[],@"scholarType":@0,@"talents":@[],@"keyword":@""}};

@end
