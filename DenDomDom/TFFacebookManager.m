//
//  TFFacebookManager.m
//  ShopOnline
//
//  Created by a on 8/7/15.
//  Copyright (c) 2015 tflat. All rights reserved.
//

#import "TFFacebookManager.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#define kLink_Facebook_Image                @"https://graph.facebook.com/%@/picture?type=large"
@interface TFFacebookManager ()
{
    NSArray *mPermission;
}

@property (nonatomic, strong) FBSDKLoginManager *mFacebookLoginManager;

@end

@implementation TFFacebookManager

+ (TFFacebookManager *)shareManager
{
    static TFFacebookManager *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        //allochiamo la sharedInstance
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        [self initPermission];
    }
    
    return self;
}

#pragma mark -

- (void)initPermission
{
    mPermission = @[
                    @"public_profile",
                    @"email",
                    @"user_friends",
                    @"user_birthday"
                    ];
}

#pragma mark - Method

- (void)loginFacebook:(void (^)(NSInteger bStatusCode, NSDictionary *bResult))bComplete
{
    @try {
        
        if(self.mFacebookLoginManager)
        {
            [self.mFacebookLoginManager logOut];
            self.mFacebookLoginManager = nil;
        }
        
        self.mFacebookLoginManager = [[FBSDKLoginManager alloc] init];
        [self.mFacebookLoginManager logInWithReadPermissions:mPermission handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error)
            {
                // Process error
                bComplete(kHTTPStatusCodeError , nil);
            }
            else if (result.isCancelled)
            {
                // Handle cancellations
                bComplete(kHTTPStatusCodeError , nil);
            }
            else
            {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if ([result.grantedPermissions containsObject:@"email"])
                {
                    // Do work
                    if ([FBSDKAccessToken currentAccessToken])
                    {
                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture, email, id, birthday, gender, locale, name"}]
                         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id bResult, NSError *error) {
                             if (!error)
                             {
                                 NSDictionary *tResultDict = [self generaPraramWebserviceFromFacebook:bResult];
                                 
                                 bComplete(kHTTPStatusCodeOK , tResultDict);
                             }
                         }];
                    }
                }
                else
                {
                    bComplete(kHTTPStatusCodeError , nil);
                }
            }
        }];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Error >> Login Facebook: %@",exception.description);
    }
}


//--------------------------------------------
//          Invite Friend
//--------------------------------------------
- (void)inviteFriend:(void (^)(NSInteger bStatusCode, NSDictionary *bResult))bComplete
{
    @try {
        
        if(self.mFacebookLoginManager)
        {
            [self.mFacebookLoginManager logOut];
            self.mFacebookLoginManager = nil;
        }
        
        self.mFacebookLoginManager = [[FBSDKLoginManager alloc] init];
        [self.mFacebookLoginManager logInWithReadPermissions:mPermission handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error)
            {
                // Process error
                bComplete(kHTTPStatusCodeError , nil);
            }
            else if (result.isCancelled)
            {
                // Handle cancellations
                bComplete(kHTTPStatusCodeError , nil);
            }
            else
            {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if ([result.grantedPermissions containsObject:@"public_profile"])
                {
                    // Do work
                    if ([FBSDKAccessToken currentAccessToken])
                    {
                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me/friends" parameters:nil]
                         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id sResult, NSError *error) {
                             if (!error)
                             {
                                 bComplete(kHTTPStatusCodeOK , sResult);
                             }
                         }];
                    }
                }
                else
                {
                    bComplete(kHTTPStatusCodeError , nil);
                }
            }
        }];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Error >> Login Facebook: %@",exception.description);
        
    }
}

#pragma mark - Method LOCAL
- (NSDictionary *)generaPraramWebserviceFromFacebook:(NSDictionary *)sResult
{
    NSString *tFullName         = [TFUtil getStringFromString:[sResult valueForKey:@"name"]];
    NSString *tProfileId        = [TFUtil getStringFromString:[sResult valueForKey:@"id"]];
    NSString *tProvider         = @"facebook";
    NSString *tEmail            = [TFUtil getStringFromString:[sResult valueForKey:@"email"]];
//    NSString *tImage            = [NSString stringWithFormat:kLink_Facebook_Image, tProfileId];
    NSInteger tGender           = [[sResult valueForKey:@"gender"] isEqualToString:@"male"] ? 1 : 0;
//    NSString *tLocation         = [TFUtil getStringFromString:[sResult valueForKey:@"locale"]];
    NSString *tBirthday         = [TFUtil getStringFromString:[sResult valueForKey:@"birthday"]];
    NSInteger tBirthdayInt      = [TFUtil dateIntFromString:tBirthday withFormat:kFormat_ddMMyyyy];
    
    NSDictionary *tParams = @{
                              kParam_Provider_ID    : tProfileId,
                              kParam_Provider       : tProvider,
                              kParam_Name           : tFullName,
                              kParam_Gender         : [NSNumber numberWithInteger:tGender],
                              kParam_BirthDay       : [NSNumber numberWithInteger:tBirthdayInt],
                              kParam_Email          : tEmail
                              };
    
    return tParams;
}

@end
