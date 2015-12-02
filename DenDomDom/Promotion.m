//
//  Promotion.m
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "Promotion.h"
#define kAPIDict_Name       @"name"
#define kAPIDict_Code       @"code"
#define kAPIDict_Link       @"link"
#define kAPIDict_CoverImgPath   @"coverImgPath"

@implementation Promotion

- (instancetype)initWithDictionary:(NSDictionary *)sDict
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
   
    self.mName = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Name]];
    self.mCode = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Code]];
    self.mLink = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Link]];
    self.mCoverImgPath = [TFUtil checkStringFromDictValue:sDict[kAPIDict_CoverImgPath]];
    
    return self;
}

@end
