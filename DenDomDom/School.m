//
//  School.m
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "School.h"
#define kAPIDict_ID             @"id"
#define kAPIDict_Name           @"name"
#define kAPIDict_Address        @"address"
#define kAPIDict_Phone          @"phone"
#define kAPIDict_Website        @"website"
#define kAPIDict_Fax            @"fax"
#define kAPIDict_Description    @"description"
#define kAPIDict_VewCount       @"viewCount"
#define kAPIDict_LogoPath       @"logoPath"
#define kAPIDict_BannePath      @"bannerPath"


@implementation School

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
    self.mAddress = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Address]];
    self.mPhone = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Phone]];
    self.mFax = [TFUtil checkStringFromDictValue:sDict[kAPIDict_Fax]];
    self.mViewCount = [sDict[kAPIDict_VewCount] integerValue];
    self.mLogoPath = [TFUtil checkStringFromDictValue:sDict[kAPIDict_LogoPath]];
    self.mBannerPath = [TFUtil checkStringFromDictValue:sDict[kAPIDict_BannePath]];
    
    
    return self;
}

@end
