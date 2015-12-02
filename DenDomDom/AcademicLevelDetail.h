//
//  AcademicLevelDetail.h
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AcademicLevel;

@interface AcademicLevelDetail : NSObject

@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, copy) NSString *mName;
@property (nonatomic, strong) AcademicLevel *mAcademic;

- (id)init;
- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
