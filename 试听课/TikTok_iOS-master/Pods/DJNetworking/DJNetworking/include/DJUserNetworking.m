//
//  DJUserNetworking.m
//  DJNetworking
//
//  Created by 邓杰 on 2023/8/28.
//

#import "DJUserNetworking.h"
#import <AFNetworking/AFNetworking.h>



#pragma mark - 客户端配置信息类
@implementation DJClientInfo

+ (DJClientInfo *)initClientInfo {
    DJClientInfo *clientConfig = [[DJClientInfo alloc] init];
    
    UIDevice *currentDevice = [UIDevice currentDevice];
    // 获取设备名称（iPhone、iPad、iPod touch 等）
    __unused NSString *deviceName = currentDevice.name;
    
    clientConfig.device_info = currentDevice.model;
    clientConfig.osInfo = [NSString stringWithFormat:@"%@ %@", currentDevice.systemName, currentDevice.systemVersion];
    clientConfig.clientVersion = @"TV_TikTok Version: 0.1.14";
    clientConfig.loginIp = [DJClientInfo getPublicIP];
    
    return clientConfig;
}

+ (NSString *)getPublicIP {
    __block NSString *ipAddress = nil;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURL *url = [NSURL URLWithString:@"https://api.ipify.org?format=json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSError *jsonError = nil;
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError) {
                NSLog(@"JSON Error: %@", jsonError.localizedDescription);
            } else {
                ipAddress = jsonData[@"ip"];
            }
        }
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    [task resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return ipAddress;
}

@end






#pragma mark - 服务端配置信息类
@implementation DJServerInfo

+ (DJServerInfo *)initServerInfoWithURLSchems:(NSString *)urlSchemes
                                     serverIp:(NSString *)serverIp
                                    erverPort:(NSString *)serverPort
                                  serverRoute:(NSString *)serverRoute {
    DJServerInfo *serverInfo = [[DJServerInfo alloc] init];
    serverInfo.urlSchemes = urlSchemes;
    serverInfo.server_ip = serverIp;
    serverInfo.server_port = serverPort;
    serverInfo.server_route = serverRoute;
    serverInfo.URI = [NSString stringWithFormat:@"%@%@%@%@", urlSchemes, serverIp, serverPort, serverRoute];
    
    return serverInfo;
}

@end





#pragma mark - 第三方用户信息类
@implementation DJThirdPartyUserInfo

+ (DJThirdPartyUserInfo *)initStandbyUserInfoWithToken:(NSString *)token
                                       loginPathWay:(DJLoginPathway)loginPathWay {
    switch ((NSUInteger)loginPathWay) {
        case DJGoogleStandbyLoginType:    return [DJThirdPartyUserInfo getGoogleUserInfoWithToken:token];   break;
        case DJFacebookStandbyLoginType:  return [DJThirdPartyUserInfo getFacebookUserInfoWithToken:token]; break;
        default:                          return nil;
    }
    
}

+ (DJThirdPartyUserInfo *)getGoogleUserInfoWithToken:(NSString *)token {
    __block DJThirdPartyUserInfo *userInfo = [[DJThirdPartyUserInfo alloc] init];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/oauth2/v1/userinfo?access_token=%@", token];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error sending request: %@", error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Error parsing JSON: %@", jsonError);
            return;
        }
        userInfo.thirdPartyId = [jsonObject valueForKey:@"id"];
        userInfo.nickname = [jsonObject valueForKey:@"name"];
        userInfo.avatarUrl = [jsonObject valueForKey:@"picture"];
        userInfo.email = [jsonObject valueForKey:@"email"];
        userInfo.loginPathWay = (NSUInteger *)DJGoogleStandbyLoginType;
        
        dispatch_semaphore_signal(semaphore);

    }];
    
    [task resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return userInfo;
}

+ (DJThirdPartyUserInfo *)getFacebookUserInfoWithToken:(NSString *)token {
    __block DJThirdPartyUserInfo *userInfo = [[DJThirdPartyUserInfo alloc] init];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/v13.0/me?fields=name,email,picture&access_token=%@", token];
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error sending request: %@", error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Error parsing JSON: %@", jsonError);
            return;
        }
        userInfo.thirdPartyId = [jsonObject valueForKey:@"id"];
        userInfo.nickname = [jsonObject valueForKey:@"name"];
        userInfo.avatarUrl = [jsonObject valueForKey:@"picture"];
        userInfo.email = [jsonObject valueForKey:@"email"];
        userInfo.loginPathWay = (NSUInteger *)DJGoogleStandbyLoginType;
        
        dispatch_semaphore_signal(semaphore);

    }];
    
    [task resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return userInfo;
}

@end


#pragma mark - 请求参数类
@implementation DJLoginParameters

+ (DJLoginParameters *)initLoginParametersWithPhone:(NSString * _Nullable)phone
                                              email:(NSString * _Nullable)email
                                  verification_code:(NSString * _Nullable)verification_code
                                             ttk_id:(NSString * _Nullable)ttk_id
                                           password:(NSString * _Nullable)password
                                              token:(NSString * _Nullable)token
                                 thirdPartyUserInfo:(DJThirdPartyUserInfo * _Nullable)thirdPartyUserInfo
                                         clientInfo:(DJClientInfo * _Nullable)clientInfo {
    DJLoginParameters *loginParameters = [[DJLoginParameters alloc] init];
    loginParameters.phone = phone;
    loginParameters.email = email;
    loginParameters.verification_code = verification_code;
    loginParameters.ttk_id = ttk_id;
    loginParameters.password = password;
    loginParameters.token = token;
    loginParameters.thirdPartyUserInfo = thirdPartyUserInfo;
    loginParameters.clientInfo = clientInfo;
    
    return loginParameters;
}


@end


#pragma mark - 请求信息类
@implementation DJRequestInfo

+ (DJRequestInfo *)initRequestInfoWithServerInfo:(DJServerInfo *)serverInfo
                                      parameters:(DJLoginParameters *)parameters {
    DJRequestInfo *requestInfo = [[DJRequestInfo alloc] init];
    requestInfo.serverInfo = serverInfo;
    requestInfo.parameters = parameters;
    
    if (parameters.token) {
        requestInfo.headers = @{
            @"Authorization":parameters.token
        };
    }
    
    return requestInfo;
}

@end



@implementation DJUserManageNetworking

/// 手机号 / 验证码登录
+ (void)phoneVerifyCodeLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                          completionHandler:(DJNetworkingHandler)handler {
    
    
}


/// 手机号 / 密码登录
+ (void)phonePasswordLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                        completionHandler:(DJNetworkingHandler)handler {
    
    
}


/// 邮箱 / 验证码登录
+ (void)emailVerifyCodeLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                          completionHandler:(DJNetworkingHandler)handler {
    
    
    
}


/// 邮箱 / 密码登录
+ (void)emailPasswordLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                        completionHandler:(DJNetworkingHandler)handler {
    
    
}


/// ttk_ID / 密码登录
+ (void)ttkIDPasswordLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                        completionHandler:(DJNetworkingHandler)handler {
    
    
}



/// 第三方登录
+ (void)thirdPartyLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                     completionHandler:(DJNetworkingHandler)handler {
    
    NSDictionary *clientInfo = @{
        @"device_info"   : requestInfo.parameters.clientInfo.device_info,
        @"osInfo"        : requestInfo.parameters.clientInfo.osInfo,
        @"clientVersion" : requestInfo.parameters.clientInfo.clientVersion,
        @"loginIp"       : requestInfo.parameters.clientInfo.loginIp
    };
    
    NSDictionary *parameter = @{
        @"token"         : requestInfo.parameters.token,
        @"clientInfo"    : clientInfo
    };
    
    [DJUserManageNetworking postNetworkingWithURL:requestInfo.serverInfo.URI headers:nil parameters:parameter CompletionHandler:^(id  _Nullable resultObject, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            if(handler){
                handler(resultObject, error);
            }
        });
    }];
}


// 第三方登录（备用接口）
+ (void)standbyThirdPartyLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                            completionHandler:(DJNetworkingHandler)handler {
    
    NSDictionary *clientInfo = @{
        @"device_info"   : requestInfo.parameters.clientInfo.device_info,
        @"osInfo"        : requestInfo.parameters.clientInfo.osInfo,
        @"clientVersion" : requestInfo.parameters.clientInfo.clientVersion,
        @"loginIp"       : requestInfo.parameters.clientInfo.loginIp
    };
    
    NSDictionary *standbyUserInfo = @{
        @"thirdPartyId"  : requestInfo.parameters.thirdPartyUserInfo.thirdPartyId,
        @"nickname"      : requestInfo.parameters.thirdPartyUserInfo.nickname,
        @"avatarUrl"     : requestInfo.parameters.thirdPartyUserInfo.avatarUrl,
        @"email"         : requestInfo.parameters.thirdPartyUserInfo.email
    };
    
    NSDictionary *parameter = @{
        @"standbyUserInfo" : standbyUserInfo,
        @"clientInfo"      : clientInfo
    };
    
    [DJUserManageNetworking postNetworkingWithURL:requestInfo.serverInfo.URI headers:nil parameters:parameter CompletionHandler:^(id  _Nullable resultObject, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            if(handler){
                handler(resultObject, error);
            }
        });
    }];

}











// get网络请求
+ (void)getNetworkingWithURL:(NSString *)url
                     headers:(NSDictionary *)headers
                  parameters:(NSDictionary *)parameters
           CompletionHandler:(DJNetworkingHandler)handler {
    
    // 创建 AFHTTPSessionManager 对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    // 设置请求格式为 JSON
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 发起 GET 请求
    [manager GET:url
      parameters:parameters
         headers:headers
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // 请求成功处理
        dispatch_async(dispatch_get_main_queue(),^{
            if(handler){
                handler(responseObject, nil);
            }
        });


         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             // 请求失败处理
        dispatch_async(dispatch_get_main_queue(),^{
            if(handler){
                handler(nil, error);
            }
        });
    }];
}


// post网络请求
+ (void)postNetworkingWithURL:(NSString *)url
                      headers:(NSDictionary *)headers
                   parameters:(NSDictionary *)parameters
            CompletionHandler:(DJNetworkingHandler)handler {
    
    // 创建 AFHTTPSessionManager 对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    // 设置请求格式为 JSON
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 发起 GET 请求
    [manager POST:url
      parameters:parameters
         headers:headers
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // 请求成功处理
        dispatch_async(dispatch_get_main_queue(),^{
            if(handler){
                handler(responseObject, nil);
            }
        });


         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             // 请求失败处理
        dispatch_async(dispatch_get_main_queue(),^{
            if(handler){
                handler(nil, error);
            }
        });
    }];
}







@end
