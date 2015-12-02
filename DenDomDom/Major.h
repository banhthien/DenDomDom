//
//  Major.h
//  DenDomDom
//
//  Created by Thien Banh on 11/20/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Major : NSObject

@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, copy) NSString *mName;
@property (nonatomic, copy) NSString *mCode;
@property (nonatomic, copy) NSString *mDescription;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
