//
//  TFWebServiceManager.h
//  Mexu
//
//  Created by Long Dang on 6/15/15.
//  Copyright (c) 2015 TFLAT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFWebServiceDefine.h"

@interface TFWebServiceManager : NSObject

+ (BOOL)checkConnection;

+ (void) getScholarshipArrayWithURL:(NSString *)nameMethod withID:(NSInteger)sURLParams withParams:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void) postScholarshipArrayWithParams:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void (^)(id bProductObj))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListGender:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListCountry:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListReligion:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListDisability:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListTerminalIll:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListFamilyPolicy:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListAcademicLevel:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListScholarshipType:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListTalent:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

+ (void)getListMajor:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail;

@end
