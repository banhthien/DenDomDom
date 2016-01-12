//
//  FilterObject.h
//  DenDomDom
//
//  Created by Thien Banh on 11/21/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Gender;
@class Country;
@class Province;
@class Religion;
@class AcademicLevel;
@class AcademicLevelDetail;
@class Disability;
@class TermialIll;
@class FamilyPolicy;
@class Major;
@class Talent;
@class ScholarshipType;

@interface FilterObject : NSObject

@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) Gender *mStuGender;

@property (nonatomic, strong) Country* mStuCitizenship;
@property (nonatomic, strong) Country* mStuResidenceCity;
@property (nonatomic, strong) Province* mStuResidenceProvince;

@property (nonatomic, strong) Religion* mStuReligion;
@property (nonatomic, strong) AcademicLevel* mScholarAca;
@property (nonatomic, strong) AcademicLevelDetail* mScholarAcaDetail;
@property (nonatomic, strong) AcademicLevel* mStuAca;
@property (nonatomic, strong) AcademicLevelDetail* mStuAcaDetail;
@property (nonatomic, strong) ScholarshipType* mScholarType;

@property (nonatomic, strong) NSMutableArray *mStuDisabilities;
@property (nonatomic, strong) NSMutableArray *mStuTerminalIllnesses;
@property (nonatomic, strong) NSMutableArray *mFamilyPolicy;

@property (nonatomic, strong) NSMutableArray *mScholarMajors;
@property (nonatomic, strong) NSMutableArray *mTalents;
@property (nonatomic, copy) NSString *mKeyword;
@property (nonatomic, strong) Country* mScholarshipCountry;


- (NSDictionary*)getFilterDict;
@end
