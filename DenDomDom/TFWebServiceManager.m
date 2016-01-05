//
//  TFWebServiceManager.m
//  Mexu
//
//  Created by Long Dang on 6/15/15.
//  Copyright (c) 2015 TFLAT. All rights reserved.
//

#import "TFWebServiceManager.h"
#import "AFNetworking.h"
#import "Reachability.h"

#import "BaseObject.h"
#import "Scholarship.h"
#import "Gender.h"
#import "Religion.h"
#import "Country.h"
#import "Disability.h"
#import "TermialIll.h"
#import "FamilyPolicy.h"
#import "Major.h"
#import "AcademicLevel.h"
#import "ScholarshipType.h"
#import "Talent.h"

#import "User.h"

@implementation TFWebServiceManager

+ (NSArray*)sortArray:(NSArray*)sSort
{
    NSArray *sortedArray = [sSort sortedArrayUsingComparator:^NSComparisonResult(BaseObject *p1, BaseObject *p2){
        
        return [[NSNumber numberWithInteger:p1.mID] compare:[NSNumber numberWithInteger:p2.mID]];
        
    }];
    return sortedArray;
}

+ (BOOL)checkConnection
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - SIGN IN
+ (void)signInOnSocialWithParams:(NSDictionary *)sParams success:(void(^)(id bUserObj))bSuccess failure:(void(^)(NSError *bError, NSString *bMessage))bFail
{
    
//    NSString *tURLString = [NSString stringWithFormat:@"%@%@", kAPI_Domain, kAPI_SignInFacebook];
    NSString *tURLString = @"";
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];

    
    [tRequestManager POST:tURLString parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCESS
        NSLog(@"SUCESS API Facebook: %@", responseObject);
        
        @try {
//            NSDictionary *tDataDict = responseObject[kAPIDict_Data];
//            NSDictionary *tProfileDict = tDataDict[kAPIDict_Profile];
            User *tUserObj = [[User alloc] initWithDictionary:responseObject];
            
            if (tUserObj)
            {
                bSuccess(tUserObj);
            }
            else
            { 
                bFail(nil, @"Error API Facebook: Can not init user object from dictionary");
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Exception: %@", exception);
            bFail(nil, @"Error API Facebook: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Facebook: %@", error.description);
        bFail(error, error.description);
        
    }];
}


#pragma mark - GET METHOD

+ (void) getScholarshipArrayWithURL:(NSString *)nameMethod withID:(NSInteger)sURLParams withParams:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@%ld",kAPI_Domain,kAPI_Scholarship, nameMethod, (long)sURLParams];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    Scholarship *tObj = [[Scholarship alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];

}

//gender
+ (void)getListGender:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_Gender, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    Gender *tObj = [[Gender alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}

//country
+ (void)getListCountry:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_Country, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    Country *tObj = [[Country alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}


//Religion
+ (void)getListReligion:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_Religion, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    Religion *tObj = [[Religion alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}

//Disability
+ (void)getListDisability:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_Disability, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    Disability *tObj = [[Disability alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}

//Terminal_Ill
+ (void)getListTerminalIll:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_TerminalIll, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    TermialIll *tObj = [[TermialIll alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}

//Family_Policy
+ (void)getListFamilyPolicy:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_FamilyPolicy, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    FamilyPolicy *tObj = [[FamilyPolicy alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}

//AcademicLevel
+ (void)getListAcademicLevel:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_AcademicLevel, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    AcademicLevel *tObj = [[AcademicLevel alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}

//Major
+ (void)getListMajor:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_Major, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    Major *tObj = [[Major alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}

//ScholarshipType
+ (void)getListScholarshipType:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_ScholarshipType, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    ScholarshipType *tObj = [[ScholarshipType alloc] initWithDictionary:tDict];

                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}

//TALENT
+ (void)getListTalent:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void  (^)(id bProductArray))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_Talent, nameMethod];
    
    [tRequestManager GET:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Product Other Array With Product: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    Talent *tObj = [[Talent alloc] initWithDictionary:tDict];
                    [tArray addObject:tObj];
                }
                
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Other Product Array With Product: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Product Other Array With Product: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Product Other Array With Product: %@", error.description);
        bFail(error, error.description);
        
    }];
    
}



#pragma mark - POST METHOD
//-----------------------------

+ (void)postScholarshipArrayWithParams:(NSString *)nameMethod withParam:(NSDictionary *)sParams success:(void (^)(id bProductObj))bSuccess failure:(void (^)(NSError *bError, NSString *bMessage))bFail
{
    AFHTTPRequestOperationManager *tRequestManager = [AFHTTPRequestOperationManager manager];
    
    tRequestManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [tRequestManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@",kAPI_Domain,kAPI_Scholarship, nameMethod];
    
    
    
    [tRequestManager POST:url parameters:sParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // SUCCESS
        NSLog(@"SUCESS API Get Scholarship Array: %@", responseObject);
        bSuccess(nil);
        @try {
            if (responseObject)
            {
                NSMutableArray *tArray = [[NSMutableArray alloc] init];
                for (NSDictionary *tDict in responseObject)
                {
                    Scholarship *tObj = [[Scholarship alloc] initWithDictionary:tDict];
                    
                       [tArray addObject:tObj];
                }
                bSuccess([self sortArray:tArray]);
            }
            
            else
            {
                bFail(nil, @"Error API Get Scholarship Array: Can not init account from dictionary");
            }
        }
        @catch (NSException *exception) {
            bFail(nil, @"Error API Get Get Scholarship Arrayt: Get value from key in dictionary.");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // FAIL
        NSLog(@"Error API Get Scholarship Array: %@", error.description);
        bFail(error, error.description);
        
    }];
}
@end
