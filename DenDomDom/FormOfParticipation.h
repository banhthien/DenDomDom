//
//  FormOfParticipation.h
//  DenDomDom
//
//  Created by Thien Banh on 11/14/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormOfParticipation : NSObject
@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, copy) NSString *mName;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;

@end
