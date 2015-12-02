
//
//  AcademicLevelDetail.m
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "AcademicLevelDetail.h"
#import "AcademicLevel.h"

#define kAPIDict_ID     @"id"
#define kAPIDict_Name   @"name"
#define kAPIDict_AcademicLevel  @"academicLevel"

@implementation AcademicLevelDetail
- (id)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.mID = 0;
    self.mName = @"";
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)sDict
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    
    @try {
        self.mID = [sDict[kAPIDict_ID] integerValue];
        self.mName = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Name]];
        id objAcademicLevel = sDict[kAPIDict_AcademicLevel];
        if(objAcademicLevel != [NSNull null])
        {
            NSDictionary *tAcadeDict = sDict[kAPIDict_AcademicLevel];
            self.mAcademic = [[AcademicLevel alloc] initWithDictionary: tAcadeDict];
        }
        else
        {
            self.mAcademic = nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
        NSLog(@"%@",exception);
    }
    
    return self;
}
@end
