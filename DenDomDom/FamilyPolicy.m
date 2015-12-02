//
//  FamilyPolicy.m
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "FamilyPolicy.h"
#define kAPIDict_ID         @"id"
#define kAPIDict_Name       @"name"

@implementation FamilyPolicy

- (id)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.mID = 0;
    self.mName = @"";
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)sDict
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.mID = [sDict[kAPIDict_ID] integerValue];
    self.mName = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Name]];
    
    return self;
}
@end
