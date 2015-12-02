//
//  Sponsor.m
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "Sponsor.h"
#define kAPIDict_ID             @"id"
#define kAPIDict_Name           @"name"
#define kAPIDict_Address        @"address"
#define kAPIDict_Phone          @"phone"
#define kAPIDict_Website        @"website"
#define kAPIDict_Fax            @"fax"

@implementation Sponsor

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
    self.mAddress = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Address]];
    self.mPhone = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Phone]];
    self.mFax = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Fax]];
    
    
    return self;
}

@end
