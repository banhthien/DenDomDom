//
//  TFFacebookManager.h
//  ShopOnline
//
//  Created by a on 8/7/15.
//  Copyright (c) 2015 tflat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFFacebookManager : NSObject

+ (TFFacebookManager *)shareManager;

// Method - Login Facebook - Get User Info
- (void)loginFacebook:(void (^)(NSInteger bStatusCode, NSDictionary *bResult))bComplete;

- (void)inviteFriend:(void (^)(NSInteger bStatusCode, NSDictionary *bResult))bComplete;
@end
