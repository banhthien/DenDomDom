//
//  Scholarship.h
//  DenDomDom
//
//  Created by Thien Banh on 11/14/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FormOfParticipation;
@class User;
@class ScholarshipType;
@class School;
@class Country;
@class Ethnic;
@class Religion;
@class FamilyPolicy;
@class Disability;
@class TermialIll;
@class Sponsor;
@class Major;
@class Talent;
@class Province;

@interface Scholarship : NSObject
@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, copy) NSString *mName;
@property (nonatomic, copy) NSString *mImagePath;
@property (nonatomic, assign) double mCreateTime;
@property (nonatomic, assign) double mDateEndRegister;
@property (nonatomic, assign) double mModifiedTime;
@property (nonatomic, assign) double mMaxValue;
@property (nonatomic, assign) double mMinValue;
@property (nonatomic, assign)  bool  mIsActive;
@property (nonatomic, assign)  NSInteger  mViewCount;
@property (nonatomic, strong) User *mLastModifiedUser;


//specifications
@property (nonatomic, copy) NSString *mAppDes;
@property (nonatomic, copy) NSString *mDescription;
@property (nonatomic, copy) NSString *mMajorDes;
@property (nonatomic, copy) NSString *mOriginLink;
@property (nonatomic, copy) NSString *mSupportDescription;
@property (nonatomic, copy) NSString *mCount;

@property (nonatomic, assign) float mCellHeight;
@property (nonatomic, strong) FormOfParticipation *mForm;
@property (nonatomic, strong) ScholarshipType *mScholarshipType;
@property (nonatomic, strong) School *mSchool;
@property (nonatomic, strong) Country *mCountry;

@property (nonatomic, strong) NSMutableArray *mStuAcademicLvDetails;
@property (nonatomic, strong) NSMutableArray *mStuGenders;
@property (nonatomic, strong) NSMutableArray *mStuCitizenships;
@property (nonatomic, strong) NSMutableArray *mStuEthnics;
@property (nonatomic, strong) NSMutableArray *mStuReligions;
@property (nonatomic, strong) NSMutableArray *mStuFamilyPolicies;
@property (nonatomic, strong) NSMutableArray *mStuDisabilities;
@property (nonatomic, strong) NSMutableArray *mStuTerminalIllness;

@property (nonatomic, strong) NSMutableArray *mStuTalents;
@property (nonatomic, strong) NSMutableArray *mStuResidences;


@property (nonatomic, strong) NSMutableArray *mSponsors;
@property (nonatomic, strong) NSMutableArray *mScholarMajors;
@property (nonatomic, strong) NSMutableArray *mScholarAcademicLvDetails;




- (instancetype)initWithDictionary:(NSDictionary *)sDict;
@end
