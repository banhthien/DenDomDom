//
//  CountryParam.m
//  DenDomDom
//
//  Created by Thien Banh on 1/7/16.
//  Copyright © 2016 DiemMac. All rights reserved.
//

#import "CountryParam.h"
#import "Country.h"

@implementation CountryParam

- (id)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.pageNumber = 1;
    self.size = 10;
    self.mScholarshipCountry = [[Country alloc] init];
    return  self;
}

- (NSDictionary*)getCountryParamDict
{
    NSDictionary *tDict = @{@"pageNumber": [NSNumber numberWithInteger:self.pageNumber],
                            @"size": [NSNumber numberWithInteger:self.size],@"scholarCountry":[NSNumber numberWithInteger:self.mScholarshipCountry.mID]};
    return tDict;
    
}

@end
