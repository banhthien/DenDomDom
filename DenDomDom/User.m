//
//  User.m
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "User.h"

@implementation User
#define kAPIDict_ID         @"id"
#define kAPIDict_Name       @"name"
#define kAPIDict_Mail       @"mail"
- (id)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    self.mID = 0;
    self.mName = @"";
    self.mMail = @"";
    
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
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    self.mID            = [decoder decodeIntegerForKey:kAPIDict_ID];
    self.mName          = [decoder decodeObjectForKey:kAPIDict_Name];
    self.mMail         = [decoder decodeObjectForKey:kAPIDict_Mail];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.mID forKey:kAPIDict_ID];
    [encoder encodeObject:self.mName forKey:kAPIDict_Name];
    [encoder encodeObject:self.mMail forKey:kAPIDict_Mail];
}

@end
