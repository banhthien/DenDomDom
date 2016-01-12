//
//  TopViewParam.h
//  DenDomDom
//
//  Created by Thien Banh on 1/7/16.
//  Copyright © 2016 DiemMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopViewParam : NSObject

@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger allowEmptyString;
@property (nonatomic, assign) NSInteger maxResult;
@property (nonatomic, strong) Country* mScholarshipCountry;

- (NSDictionary*)getTopViewParamDict;
@end
