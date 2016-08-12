//
//  FMFacebookController.h
//  Famima
//
//  Created by 奥村明 on 2016/02/23.
//  Copyright © 2016年 林浩智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMFacebookController : NSObject

- (void)loginFacebookWithViewController:(UIViewController *)viewController resultBlock:(void (^)(BOOL isLoggedIn, NSError *error))resultBlock;
- (void)logout;
+ (void)fetchUserData:(void (^)(NSDictionary *dic))resultBlock;
+ (void)facebookAccoutnInfoBlock:(void (^)(NSString *accessToken))infoBlock;

@end
