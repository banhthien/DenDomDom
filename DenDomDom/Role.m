//
//  Role.m
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "Role.h"
#define kAPIDict_ID             @"id"
#define kAPIDict_Name           @"name"
#define kAPIDict_Description    @"description"
#define kAPIDict_Code           @"code"

@implementation Role

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
    self.mCode = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Code]];
    
    return self;
}
@end
