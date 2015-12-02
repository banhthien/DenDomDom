//
//  AcademicLevel.h
//  DenDomDom
//
//  Created by Thien Banh on 11/15/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AcademicLevel : NSObject

@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, copy) NSString *mName;

- (id)init;
- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
