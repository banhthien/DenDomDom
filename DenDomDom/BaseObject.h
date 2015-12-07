//
//  BaseObject.h
//  DenDomDom
//
//  Created by TFLAT iOS Developer on 12/7/15.
//  Copyright © 2015 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject
@property (nonatomic, assign) NSInteger mID;
@property (nonatomic, copy) NSString *mName;

- (instancetype)initWithDictionary:(NSDictionary *)sDict;
@end
