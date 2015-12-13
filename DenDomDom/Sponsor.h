//
//  Sponsor.h
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"
@interface Sponsor : BaseObject

@property (nonatomic, copy) NSString *mAddress;
@property (nonatomic, copy) NSString *mPhone;
@property (nonatomic, copy) NSString *mWebsite;
@property (nonatomic, copy) NSString *mFax;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
