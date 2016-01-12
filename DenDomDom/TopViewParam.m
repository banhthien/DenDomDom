//
//  TopViewParam.m
//  DenDomDom
//
//  Created by Thien Banh on 1/7/16.
//  Copyright © 2016 DiemMac. All rights reserved.
//

#import "TopViewParam.h"
#import "Country.h"

@implementation TopViewParam

- (id)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.pageNumber = 1;
    self.pageSize = 10;
    self.mScholarshipCountry = [[Country alloc] init];
    return self;
}

- (NSDictionary*)getTopViewParamDict
{
    NSDictionary *tParam = @{@"pageNumber":[NSNumber numberWithInteger:self.pageNumber],@"pageSize":[NSNumber numberWithInteger:self.pageSize],@"allowEmptyString":[NSNumber numberWithInteger:self.allowEmptyString],@"maxResult":[NSNumber numberWithInteger:self.maxResult],@"scholarCountry":[NSNumber numberWithInteger:self.mScholarshipCountry.mID]};
    return tParam;
}

@end
