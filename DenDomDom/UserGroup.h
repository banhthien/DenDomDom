//
//  UserGroup.h
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"
@interface UserGroup : BaseObject

@property (nonatomic, copy) NSString *mDescription;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
