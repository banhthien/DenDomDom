//
//  Promotion.h
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Promotion : NSObject

@property (nonatomic, copy) NSString *mCode;
@property (nonatomic, copy) NSString *mName;
@property (nonatomic, copy) NSString *mLink;
@property (nonatomic, copy) NSString *mCoverImgPath;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
