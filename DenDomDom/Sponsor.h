//
//  Sponsor.h
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sponsor : NSObject

@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, copy) NSString *mName;
@property (nonatomic, copy) NSString *mAddress;
@property (nonatomic, copy) NSString *mPhone;
@property (nonatomic, copy) NSString *mWebsite;
@property (nonatomic, copy) NSString *mFax;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
