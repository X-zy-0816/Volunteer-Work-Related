//
//  DJLogin.m
//  OAuthLogin
//
//  Created by 邓杰 on 2023/8/26.
//

#import "DJLogin.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@implementation DJLogin

+ (void)googleLoginWithViewController:(UIViewController *)viewController handler:(GoogleLoginGetTokenBlock _Nullable)handler {
    
    [[GIDSignIn sharedInstance] signInWithPresentingViewController:viewController completion:^(GIDSignInResult * _Nullable signInResult, NSError * _Nullable error) {
        
        GIDToken *accessToken = signInResult.user.accessToken;
        NSString *tokenStr = accessToken.tokenString;
        dispatch_async(dispatch_get_main_queue(),^{
            if(handler){
                handler(tokenStr, error);
            }
        });
        NSLog(@"Token = %@\n", tokenStr);
    }];
    
}





+ (void)facebookLoginWithViewController:(UIViewController *)viewController handler:(FacebookLoginGetTokenBlock _Nullable)handler {
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithPermissions:@[@"public_profile", @"email"] fromViewController:viewController handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {

        // 登录成功，可以获取用户的 Access Token
        NSString *tokenStr = [FBSDKAccessToken currentAccessToken].tokenString;
        dispatch_async(dispatch_get_main_queue(),^{
            if(handler){
                handler(tokenStr, error);
            }
        });
        NSLog(@"Token = %@\n", tokenStr);
    }];
}

@end
