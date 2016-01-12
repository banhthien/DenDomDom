//
//  CountryParam.h
//  DenDomDom
//
//  Created by Thien Banh on 1/7/16.
//  Copyright © 2016 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Country;

@interface CountryParam : NSObject

@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) Country* mScholarshipCountry;

- (NSDictionary*)getCountryParamDict;
@end
