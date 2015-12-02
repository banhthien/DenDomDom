//
//  FormOfParticipation.m
//  DenDomDom
//
//  Created by Thien Banh on 11/14/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "FormOfParticipation.h"
#define kAPIDict_ID         @"id"
#define kAPIDict_Name       @"name"

@implementation FormOfParticipation

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
