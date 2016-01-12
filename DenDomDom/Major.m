
//
//  Major.m
//  DenDomDom
//
//  Created by Thien Banh on 11/20/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "Major.h"
#define kAPIDict_ID             @"id"
#define kAPIDict_Name           @"name"
#define kAPIDict_Description    @"description"

@implementation Major

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
    self.mDescription = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Description]];
    
    return self;
}


@end
