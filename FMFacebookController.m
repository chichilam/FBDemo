//
//  FMFacebookController.m
//  Famima
//
//  Created by 奥村明 on 2016/02/23.
//  Copyright © 2016年 林浩智. All rights reserved.
//

#import "FMFacebookController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation FMFacebookController

- (void)loginFacebookWithViewController:(UIViewController *)viewController resultBlock:(void (^)(BOOL isLoggedIn, NSError *error))resultBlock {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile",@"email"]
                 fromViewController:viewController
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                    if (resultBlock)resultBlock(NO, error);
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                    if (resultBlock)resultBlock(NO, nil);
                                } else {
                                    NSLog(@"Logged in");
                                    if (resultBlock)resultBlock(YES, nil);
                                }
                            }];
}

- (void)logout {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
}

+ (void)fetchUserData:(void (^)(NSDictionary *dic))resultBlock {
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email, first_name, last_name, gender"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 if(resultBlock) resultBlock(result);
             }
         }];
    }
}

+ (void)facebookAccoutnInfoBlock:(void (^)(NSString *accessToken))infoBlock {
    BLOCK_EXEC(infoBlock, [FBSDKAccessToken currentAccessToken].tokenString);
}

@end
