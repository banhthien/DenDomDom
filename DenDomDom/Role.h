//
//  Role.h
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"
@interface Role : BaseObject

@property (nonatomic, copy) NSString *mDescription;
@property (nonatomic, copy) NSString *mCode;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
