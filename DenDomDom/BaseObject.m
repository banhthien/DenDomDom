//
//  BaseObject.m
//  DenDomDom
//
//  Created by TFLAT iOS Developer on 12/7/15.
//  Copyright © 2015 DiemMac. All rights reserved.
//

#import "BaseObject.h"
#define kAPIDict_ID         @"id"
#define kAPIDict_Name       @"name"
@implementation BaseObject

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
