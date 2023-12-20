//
//  DJLoginConfig.m
//  OAuthLogin
//
//  Created by 邓杰 on 2023/8/26.
//

#import "DJLoginConfig.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation DJLoginConfig

/// 注册 FaceBook 登录服务
+ (void)registerFacebookLoginConfigWithApplication:(UIApplication *)application
                              launchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}


/// 注册 Google 登录服务
+ (void)registerGoogleLoginConfigWithClientID:(NSString *)clienID {
    
    GIDConfiguration *config = [[GIDConfiguration alloc] initWithClientID:clienID];
    [[GIDSignIn sharedInstance] setConfiguration:config];
}


@end
