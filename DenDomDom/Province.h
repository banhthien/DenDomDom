//
//  Province.h
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"
@class Country;

@interface Province : BaseObject
@property (nonatomic, strong) Country *mCountry;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
