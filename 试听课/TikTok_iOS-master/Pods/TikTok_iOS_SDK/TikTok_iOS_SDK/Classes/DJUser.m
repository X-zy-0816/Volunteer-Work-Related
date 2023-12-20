//
//  DJUser.m
//  TikTok_iOS_SDK
//
//  Created by 邓杰 on 2023/8/23.
//

#import "DJUser.h"
#import <SafariServices/SafariServices.h>
#import <OAuthLogin/OAuthLogin.h>
#import <DJNetworking/DJUserNetworking.h>
#import <TikTok_iOS_SDK.h>

@implementation DJUser

//static DJUser* _instance = nil;
//+ (instancetype)shareInstance {
//    static dispatch_once_t onceToken ;
//    dispatch_once(&onceToken, ^{
//        _instance = [[super allocWithZone:NULL] init] ;
//    });
//    return _instance ;
//    }
//
// //用alloc返回也是唯一实例
//+ (DJUser *) allocWithZone:(struct _NSZone *)zone {
//    return [DJUser shareInstance] ;
//}
////对对象使用copy也是返回唯一实例
//- (DJUser *)copyWithZone:(NSZone *)zone {
//    return [DJUser shareInstance] ;//return _instance;
//}
// //对对象使用mutablecopy也是返回唯一实例
//- (DJUser *)mutableCopyWithZone:(NSZone *)zone {
//    return [DJUser shareInstance] ;
//}


#pragma mark - User登录注册方法

+ (void)registerWithUsername:(NSString *)username
                    password:(NSString *)password
                    userInfo:(DJUserInfo * DJ_NULLABLE)userInfo
           completionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    
    
}




+ (void)loginWithAccount:(NSString * DJ_NULLABLE)account
                    code:(NSString * DJ_NULLABLE)code
         thirdPartyToken:(NSString * DJ_NULLABLE)token
      thirdPartyUserInfo:(DJThirdPartyUserInfo * DJ_NULLABLE)thirdPartyUserInfo
            loginPathway:(DJLoginPathway)loginPathway
       completionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    
    switch (loginPathway) {
        case DJGoogleStandbyLoginType: {
            // 获取客户端信息
            DJClientInfo *clientInfo = [DJClientInfo initClientInfo];
            // 获取服务器信息
            DJServerInfo *serverInfo = [DJServerInfo initServerInfoWithURLSchems:SERVER_SCHEMES serverIp:SERVER_IP erverPort:SERVER_PORT serverRoute:LOGIN_ROUTE_STANDBY_GOOGLE];
            // 获取请求体信息
            DJLoginParameters *parameters = [DJLoginParameters initLoginParametersWithPhone:nil email:nil verification_code:nil ttk_id:nil password:nil token:nil thirdPartyUserInfo:thirdPartyUserInfo clientInfo:clientInfo];
            // HTTP 请求信息
            DJRequestInfo *requestInfo = [DJRequestInfo initRequestInfoWithServerInfo:serverInfo parameters:parameters];
            //
            [DJUserManageNetworking standbyThirdPartyLoginWithRequestInfo:requestInfo completionHandler:^(id  _Nullable resultObject, NSError * _Nullable error) {
                handler(resultObject, error);
            }];

            
        } break;
            
        case DJFacebookStandbyLoginType: {
            
        }break;
            
            
        default:break;
    }
    
    
    
    
}








+ (void)loginThirdPartyWithLoginPathway:(DJLoginPathway)loginPathway
                         viewController:(UIViewController *)viewController
                      completionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    
    switch (loginPathway) {
        case DJGoogleStandbyLoginType: {
            [DJUser getGoogleStandbyTTKUserInfoWithViewController:viewController CompletionHandler:^(id resultObject, NSError *error) {
                
                DJTikTok *tiktok = [DJTikTok shareInstance];
                [tiktok setUserToken:[resultObject objectForKey:@"token"]];
                
                [DJUser getMyUserInfo];
                
                
                NSLog(@"");
                
                handler(nil, error);
            }];
        }   break;
            
        case DJFacebookStandbyLoginType: {
            [DJUser getFacebookStandbyTTKUserInfoWithViewController:viewController CompletionHandler:^(id resultObject, NSError *error) {
                DJTikTok *tiktok = [DJTikTok shareInstance];
                [tiktok setUserToken:[resultObject objectForKey:@"token"]];
                
                [DJUser getMyUserInfo];
                
                
                NSLog(@"");
                
                handler(nil, error);            }];
        }   break;
        default:break;
    }
}



+ (void)getThirdPartyTokenWithLoginPathway:(DJLoginPathway)loginPathway
                            viewController:(UIViewController *)viewController
                         completionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    switch (loginPathway) {
        case DJGoogleLoginType: {
            [DJLogin googleLoginWithViewController:viewController handler:^(NSString * _Nullable token, NSError * _Nullable error) {
                handler(token, error);
            }];
        } break;
        
        case DJFacebookLoginType : {
            [DJLogin facebookLoginWithViewController:viewController handler:^(NSString * _Nullable token, NSError * _Nullable error) {
                handler(token, error);
            }];
        }
        default: break;
    }
}



+ (void)getThirePartyUserInfoWithToken:(NSString *)token
                          loginPathway:(DJLoginPathway)loginPathway
                     completionHandler:(DJCompletionHandler DJ_NULLABLE)handler {

    switch (loginPathway) {
        case DJGoogleLoginType: {
            DJThirdPartyUserInfo *thirdUserInfo = [DJThirdPartyUserInfo initStandbyUserInfoWithToken:token loginPathWay:DJGoogleStandbyLoginType];
            handler(thirdUserInfo, nil);
        } break;
        
        case DJFacebookLoginType : {
            DJThirdPartyUserInfo *thirdUserInfo = [DJThirdPartyUserInfo initStandbyUserInfoWithToken:token loginPathWay:DJFacebookStandbyLoginType];
            handler(thirdUserInfo, nil);
        }
        default: break;
    }
    
    
}




+ (void)logout:(DJCompletionHandler DJ_NULLABLE)handler {
    
}




#pragma mark - Get方法（获取User信息）

+ (DJUser *)myInfo {
    DJUser *userInfo = [DJTikTok shareInstance].myUserInfo;
    return userInfo;
}


+ (void)getMyUserInfo {
    DJTikTok *tiktok = [DJTikTok shareInstance];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    if(!tiktok.userToken)
        return;

    // 创建会话配置
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 添加请求头
    [sessionConfig setHTTPAdditionalHeaders:@{@"Authorization": tiktok.userToken}];
    // 创建NSURLSession实例
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    DJServerInfo *serverInfo = [DJServerInfo initServerInfoWithURLSchems:SERVER_SCHEMES serverIp:SERVER_IP erverPort:SERVER_PORT serverRoute:GET_MYINFO_ROUTE];
    NSURL *url = [NSURL URLWithString:serverInfo.URI];
    
    // 创建GET请求
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *userData = [[[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError] objectForKey:@"data"] objectForKey:@"user_info"];
        
        [DJUser initUserInfo:userData];
        
        
        
        dispatch_semaphore_signal(semaphore);
    }];
    [task resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}




+ (DJUser *DJ_NULLABLE)userWithUid:(SInt64)ttk_id {
    return nil;
}




+ (void)userInfoArrayWithUsernameArray:(NSArray DJ_GENERIC(__kindof NSString *)*)usernameArray
                     completionHandler:(DJCompletionHandler)handler {
    
}





- (void)thumbAvatarData:(DJAsyncDataHandler)handler {
    
}





- (void)largeAvatarData:(DJAsyncDataHandler)handler {
    
}




#pragma mark - Set方法（设置User信息）


+ (void)addUsersToBlacklist:(NSArray DJ_GENERIC(__kindof NSString *)*)usernameArray
          completionHandler:(DJCompletionHandler)handler {
    
    
}




+ (void)delUsersFromBlacklist:(NSArray DJ_GENERIC(__kindof NSString *)*)usernameArray
            completionHandler:(DJCompletionHandler)handler {
    
    
}




- (void)setIsNoDisturb:(BOOL)isNoDisturb handler:(DJCompletionHandler)handler {
    
}



#pragma mark - update方法（更新User信息）

+ (void)updateMyInfoWithUserInfo:(DJUserInfo *)userInfo
               completionHandler:(DJCompletionHandler)handler {
    
}




+ (void)updateMyAvatarWithData:(NSData *)avatarData
                  avatarFormat:(NSString *)avatarFormat
             completionHandler:(DJCompletionHandler)handler {
    
}




+ (void)updateMyPasswordWithNewPassword:(NSString *)newPassword
                            oldPassword:(NSString *)oldPassword
                      completionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    
}





- (void)updateNoteName:(NSString *)noteName completionHandler:(DJCompletionHandler)handler {
    
}




- (void)updateNoteText:(NSString *)noteText completionHandler:(DJCompletionHandler)handler {
    
}






#pragma mark - 用户信息处理
// 初始化用户信息
+ (DJUser *)initUserInfo:(NSDictionary *)resultObject {
    
    [[DJTikTok shareInstance] setMyUserInfo:[[DJUser alloc] init]];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"id"] forKey:@"uid"];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"ttk_id"] forKey:@"username"];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"nick_name"] forKey:@"nickname"];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"gender"] forKey:@"gender"];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"birthdate"] forKey:@"birthday"];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"avatar_path"] forKey:@"avatar"];
//    [userInfo setValue:[resultObject objectForKey:@"bio"] forKey:@"uid"];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"country"] forKey:@"region"];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"city"] forKey:@"address"];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"email"] forKey:@"email"];
    [[DJTikTok shareInstance].myUserInfo setValue:[resultObject objectForKey:@"phone"] forKey:@"phoneNumber"];
    //[userInfo setValue:[resultObject objectForKey:@"account_status"] forKey:@"uid"];

    return [DJTikTok shareInstance].myUserInfo;
}






#pragma mark - google登录逻辑
// google登录获取 ttkUserInfo
+ (void)getGoogleTTKUserInfoWithViewController:(UIViewController *)viewController
                             CompletionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    // 得到HTTP请求信息
    [DJUser getGoogleLoginRequserInfoWithViewController:viewController CompletionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            DJRequestInfo *requestInfo = (DJRequestInfo *)resultObject;
            // 获得服务器返回的响应：TTK UserInfo
            [DJUserManageNetworking standbyThirdPartyLoginWithRequestInfo:requestInfo completionHandler:^(id  _Nullable resultObject, NSError * _Nullable error) {
                if (!error) {
                    
                    
                    // resultObject为服务器返回的ttkUserInfo
                    id userInfo = resultObject;
                    
                    
                    handler(userInfo, nil);
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(),^{
                        if(handler){
                            handler(nil, error);
                        }
                    });
                }
            }];
        } else {
            dispatch_async(dispatch_get_main_queue(),^{
                if(handler){
                    handler(nil, error);
                }
            });
        }
    }];
}

// 获取 Google 登录的HTTP请求信息
+ (void)getGoogleLoginRequserInfoWithViewController:(UIViewController *)viewController
                                  CompletionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    // 获取客户端信息
    DJClientInfo *clientInfo = [DJClientInfo initClientInfo];
    // 获取服务器信息
    DJServerInfo *serverInfo = [DJServerInfo initServerInfoWithURLSchems:SERVER_SCHEMES serverIp:SERVER_IP erverPort:SERVER_PORT serverRoute:LOGIN_ROUTE_GOOGLE];
    
    // 获取 google发放的token
    [DJLogin googleLoginWithViewController:viewController handler:^(NSString * _Nullable token, NSError * _Nullable error) {
        if (!error) {
            // 获取请求体信息
            DJLoginParameters *parameters = [DJLoginParameters initLoginParametersWithPhone:nil email:nil verification_code:nil ttk_id:nil password:nil token:token thirdPartyUserInfo:nil clientInfo:clientInfo];
            // 获取HTTP请求信息
            DJRequestInfo *requestInfo = [DJRequestInfo initRequestInfoWithServerInfo:serverInfo parameters:parameters];
            dispatch_async(dispatch_get_main_queue(),^{
                if(handler){
                    // 返回HTTP请求信息
                    handler(requestInfo, nil);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(),^{
                if(handler){
                    handler(nil, error);
                }
            });
        }
    }];
}





#pragma mark - google备用方法登录逻辑
// 备用方法google登录获取 ttkUserInfo
+ (void)getGoogleStandbyTTKUserInfoWithViewController:(UIViewController *)viewController
                                    CompletionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    // 得到HTTP请求信息(包括Google Token)
    [DJUser getGoogleStandbyLoginRequsetInfoWithViewController:viewController CompletionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            DJRequestInfo *requestInfo = (DJRequestInfo *)resultObject;
            // 获得服务器返回的响应：TTK UserInfo
            [DJUserManageNetworking standbyThirdPartyLoginWithRequestInfo:requestInfo completionHandler:handler];
        } else {
            dispatch_async(dispatch_get_main_queue(),^{
                if(handler){
                    handler(nil, error);
                }
            });
        }
    }];
}


// 获取备用方法 Google 登录的HTTP请求信息
+ (void)getGoogleStandbyLoginRequsetInfoWithViewController:(UIViewController *)viewController
                                         CompletionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    // 获取客户端信息
    DJClientInfo *clientInfo = [DJClientInfo initClientInfo];
    // 获取服务器信息
    DJServerInfo *serverInfo = [DJServerInfo initServerInfoWithURLSchems:SERVER_SCHEMES serverIp:SERVER_IP erverPort:SERVER_PORT serverRoute:LOGIN_ROUTE_STANDBY_GOOGLE];
    
    
    // 获取 google发放的token
    [DJLogin googleLoginWithViewController:viewController handler:^(NSString * _Nullable token, NSError * _Nullable error) {
        if (!error) {
            
            // 获取第三方平台UserInfo
            DJThirdPartyUserInfo *thirdPartyUserInfo = [DJThirdPartyUserInfo initStandbyUserInfoWithToken:token loginPathWay:DJGoogleStandbyLoginType];
            // 获取请求体信息
            DJLoginParameters *parameters = [DJLoginParameters initLoginParametersWithPhone:nil email:nil verification_code:nil ttk_id:nil password:nil token:nil thirdPartyUserInfo:thirdPartyUserInfo clientInfo:clientInfo];
            // 获取HTTP请求信息
            DJRequestInfo *requestInfo = [DJRequestInfo initRequestInfoWithServerInfo:serverInfo parameters:parameters];
            dispatch_async(dispatch_get_main_queue(),^{
                if(handler){
                    // 返回HTTP请求信息
                    handler(requestInfo, nil);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(),^{
                if(handler){
                    handler(nil, error);
                }
            });
        }
    }];
}


#pragma mark - Facebook备用方法登录逻辑
// 备用方法Facebook登录获取 ttkUserInfo
+ (void)getFacebookStandbyTTKUserInfoWithViewController:(UIViewController *)viewController
                                      CompletionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    // 得到HTTP请求信息
    [DJUser getFacebookStandbyLoginRequsetInfoWithViewController:viewController CompletionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            DJRequestInfo *requestInfo = (DJRequestInfo *)resultObject;
            // 获得服务器返回的响应：TTK UserInfo
            [DJUserManageNetworking standbyThirdPartyLoginWithRequestInfo:requestInfo completionHandler:handler];
        } else {
            dispatch_async(dispatch_get_main_queue(),^{
                if(handler){
                    handler(nil, error);
                }
            });
        }
    }];
}


// 获取备用方法 Facebook 登录的HTTP请求信息
+ (void)getFacebookStandbyLoginRequsetInfoWithViewController:(UIViewController *)viewController
                                           CompletionHandler:(DJCompletionHandler DJ_NULLABLE)handler {
    // 获取客户端信息
    DJClientInfo *clientInfo = [DJClientInfo initClientInfo];
    // 获取服务器信息
    DJServerInfo *serverInfo = [DJServerInfo initServerInfoWithURLSchems:SERVER_SCHEMES serverIp:SERVER_IP erverPort:SERVER_PORT serverRoute:LOGIN_ROUTE_STANDBY_Facebook];
    
    
    // 获取 Facebook 发放的token
    [DJLogin facebookLoginWithViewController:viewController handler:^(NSString * _Nullable token, NSError * _Nullable error) {
        if (!error) {
            
            // 获取第三方平台UserInfo
            DJThirdPartyUserInfo *thirdPartyUserInfo = [DJThirdPartyUserInfo initStandbyUserInfoWithToken:token loginPathWay:DJFacebookStandbyLoginType];
            // 获取请求体信息
            DJLoginParameters *parameters = [DJLoginParameters initLoginParametersWithPhone:nil email:nil verification_code:nil ttk_id:nil password:nil token:nil thirdPartyUserInfo:thirdPartyUserInfo clientInfo:clientInfo];
            // 获取HTTP请求信息
            DJRequestInfo *requestInfo = [DJRequestInfo initRequestInfoWithServerInfo:serverInfo parameters:parameters];
            dispatch_async(dispatch_get_main_queue(),^{
                if(handler){
                    // 返回HTTP请求信息
                    handler(requestInfo, nil);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(),^{
                if(handler){
                    handler(nil, error);
                }
            });
        }
    }];
}









//- (nonnull id)copyWithZone:(nullable NSZone *)zone {
//
//}

@end
