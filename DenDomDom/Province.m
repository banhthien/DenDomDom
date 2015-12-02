//
//  Province.m
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "Province.h"
#import "Country.h"
#define kAPIDict_ID     @"id"
#define kAPIDict_Name   @"name"
#define kAPIDict_Country    @"country"

@implementation Province

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
        id objAcademicLevel = sDict[kAPIDict_Country];
        if(objAcademicLevel != [NSNull null])
        {
            NSDictionary *tCountryDict = sDict[kAPIDict_Country];
            self.mCountry = [[Country alloc] initWithDictionary: tCountryDict];
        }
        else
        {
            self.mCountry = nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
        NSLog(@"%@",exception);
    }
    
    return self;
}

@end
