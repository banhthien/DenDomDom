//
//  UserGroup.m
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "UserGroup.h"

@implementation UserGroup
#define kAPIDict_ID         @"id"
#define kAPIDict_Name       @"name"
#define kAPIDict_Description    @"description"

- (instancetype)initWithDictionary:(NSDictionary *)sDict
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.mID = [sDict[kAPIDict_ID] integerValue];
    self.mName = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Name]];
    self.mDescription = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Description]];
    
    return self;
}

@end
