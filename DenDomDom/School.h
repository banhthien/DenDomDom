//
//  School.h
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface School : NSObject

@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, copy) NSString *mName;
@property (nonatomic, copy) NSString *mAddress;
@property (nonatomic, copy) NSString *mPhone;
@property (nonatomic, copy) NSString *mWebsite;
@property (nonatomic, copy) NSString *mFax;
@property (nonatomic, copy) NSString *mDescription;
@property (nonatomic, copy) NSString *mLogoPath;
@property (nonatomic, copy) NSString *mBannerPath;
@property (nonatomic, assign) NSInteger mViewCount;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
