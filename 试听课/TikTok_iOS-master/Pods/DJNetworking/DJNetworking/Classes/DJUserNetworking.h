//
//  DJUserNetworking.h
//  DJNetworking
//
//  Created by 邓杰 on 2023/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DJNetworkingHandler)(id _Nullable resultObject , NSError  * _Nullable error );


#pragma mark - Login_type 声明
/// 登录途径
typedef NS_ENUM(NSUInteger, DJLoginPathway) {
    /// 手机验证码登录
    DJPhoneVerifyCodeLoginType = 1,
    /// 邮箱验证码登录
    DJEmailVerifyCodeLoginType = 2,
    /// 手机密码登录
    DJPhonePassLoginType = 3,
    /// 邮箱密码登录
    DJEmailLoginType = 4,
    /// ttk_id 密码登录
    DJTTkIDLoginType = 5,
    /// 第三方登录：Google
    DJGoogleLoginType = 6,
    /// 第三方登录：Facebook
    DJFacebookLoginType = 7,
    /// 第三方登录：Github
    DJGithubLoginType = 8,
    /// 备用接口第三方登录：Google
    DJGoogleStandbyLoginType = 9,
    /// 备用接口第三方登录：Facebook
    DJFacebookStandbyLoginType = 10,
    /// 备用接口第三方登录：Github
    DJGithubStandbyLoginType = 11,
};

#pragma mark - 客户端配置信息类
/**
 * 客户端配置信息类
 */
@interface DJClientInfo : NSObject
/// 设备信息（eg: iphone13 pro）
@property (nonatomic, strong) NSString *device_info;
/// 操作系统版本信息 （eg：iOS 16.2.4）
@property (nonatomic, strong) NSString *osInfo;
/// 客户端版本 （eg：TV_TikTok 0.4.12）
@property (nonatomic, strong) NSString *clientVersion;
/// 登录IP
@property (nonatomic, strong) NSString *loginIp;

+ (DJClientInfo *)initClientInfo;


@end

#pragma mark - 服务端配置信息类
/**
 * 客户端配置信息类
 */
@interface DJServerInfo : NSObject
/// 协议头
@property (nonatomic, strong) NSString *urlSchemes;
/// 服务器ip
@property (nonatomic, strong) NSString *server_ip;
/// 服务器端口号
@property (nonatomic, strong) NSString *server_port;
/// 服务器路由
@property (nonatomic, strong) NSString *server_route;
/// URI
@property (nonatomic, strong) NSString *URI;

+ (DJServerInfo *)initServerInfoWithURLSchems:(NSString *)urlSchemes
                                     serverIp:(NSString *)serverIp
                                    erverPort:(NSString *)serverPort
                                  serverRoute:(NSString *)serverRoute;

@end

#pragma mark - 第三方用户信息类
/**
 * 第三方用户信息类
 */
@interface DJThirdPartyUserInfo : NSObject
/// 第三方平台用户 id
@property (nonatomic, strong) NSString *thirdPartyId;
/// 第三方平台昵称
@property (nonatomic, strong) NSString *nickname;
/// 第三方平台头像URL
@property (nonatomic, strong) NSString *avatarUrl;
/// 第三方平台绑定邮箱
@property (nonatomic, strong) NSString *email;
/// 第三方平台类型
@property (nonatomic) DJLoginPathway *loginPathWay;

+ (DJThirdPartyUserInfo *)initStandbyUserInfoWithToken:(NSString *)token
                                          loginPathWay:(DJLoginPathway)loginPathWay;

@end


#pragma mark - 登录请求参数类
/**
 * 登录请求参数类
 */
@interface DJLoginParameters : NSObject
/// 手机号
@property (nonatomic, strong) NSString * __nullable phone;
/// 邮箱
@property (nonatomic, strong) NSString * __nullable email;
/// 验证码
@property (nonatomic, strong) NSString * __nullable verification_code;
/// ttk_id
@property (nonatomic, strong) NSString * __nullable ttk_id;
/// 密码
@property (nonatomic, strong) NSString * __nullable password;
/// 第三方登录token
@property (nonatomic, strong) NSString * __nullable token;
/// 第三方平台用户信息
@property (nonatomic, strong) DJThirdPartyUserInfo *thirdPartyUserInfo;
/// 登录设备信息
@property (nonatomic, strong) DJClientInfo *clientInfo;

+ (DJLoginParameters *)initLoginParametersWithPhone:(NSString * __nullable)phone
                                              email:(NSString * __nullable)email
                                  verification_code:(NSString * __nullable)verification_code
                                             ttk_id:(NSString * __nullable)ttk_id
                                           password:(NSString * __nullable)password
                                              token:(NSString * __nullable)token
                                 thirdPartyUserInfo:(DJThirdPartyUserInfo * __nullable)thirdPartyUserInfo
                                         clientInfo:(DJClientInfo * __nullable)clientInfo;

@end




#pragma mark - 请求信息类
/**
 * 服务器配置信息类
 */
@interface DJRequestInfo : NSObject
/// 服务器网络信息
@property (nonatomic, strong) DJServerInfo *serverInfo;
/// 请求头
@property (nonatomic, strong) NSDictionary * __nullable headers;
/// 请求体参数
@property (nonatomic, strong) DJLoginParameters * __nullable parameters;

+ (DJRequestInfo *)initRequestInfoWithServerInfo:(DJServerInfo *)serverInfo
                                      parameters:(DJLoginParameters *)parameters;

@end



#pragma mark - DJUser_Class 用户管理类(登录、登出、注册)

/**
 * 用户管理类
 * 主要包含用户登录、登出、注册等API
 */
@interface DJUserManageNetworking : NSObject


/**
 * @abstract 手机号/验证码 登录
 *
 * @param requestInfo               请求信息
 * @param handler                        结果回调，返回当前登录用户的 Token
 */
+ (void)phoneVerifyCodeLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                          completionHandler:(DJNetworkingHandler)handler;


/**
 * @abstract 手机/密码 登录
 *
 * @param requestInfo                请求信息
 * @param handler                        结果回调，返回当前登录用户的 Token
 */
+ (void)phonePasswordLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                        completionHandler:(DJNetworkingHandler)handler;


/**
 * @abstract 邮箱/验证码 登录
 *
 * @param requestInfo               请求信息
 * @param handler                        结果回调，返回当前登录用户的 Token
 */
+ (void)emailVerifyCodeLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                          completionHandler:(DJNetworkingHandler)handler;


/**
 * @abstract 邮箱/密码 登录
 *
 * @param requestInfo              请求信息
 * @param handler                       结果回调，返回当前登录用户的 Token
 */
+ (void)emailPasswordLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                        completionHandler:(DJNetworkingHandler)handler;


/**
 * @abstract ttk_ID/密码 登录
 *
 * @param requestInfo              请求信息
 * @param handler                       结果回调，返回当前登录用户的 Token
 */
+ (void)ttkIDPasswordLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                        completionHandler:(DJNetworkingHandler)handler;


/**
 * @abstract 第三方登录
 *
 * @param requestInfo              请求信息
 * @param handler                       结果回调，返回当前登录用户的 Token
 *
 * @discussion 由于网络原因，该方法在服务器上不一定成功，如果失败，则将自动调用下一个备用接口，以此获取ttk_token
 */
+ (void)thirdPartyLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                     completionHandler:(DJNetworkingHandler)handler;


/**
 * @abstract 第三方登录（备用接口）
 *
 * @param requestInfo              登录设备信息
 * @param handler                       结果回调，返回当前登录用户的 Token
 *
 * @discussion 该方法在本地请求第三方平台的用户数据，然后发往服务器，得到该用户的ttk_token
 */
+ (void)standbyThirdPartyLoginWithRequestInfo:(DJRequestInfo *)requestInfo
                            completionHandler:(DJNetworkingHandler)handler;




// get网络请求
+ (void)getNetworkingWithURL:(NSString *)url
                     headers:(NSDictionary *)headers
                  parameters:(NSDictionary *)parameters
           CompletionHandler:(DJNetworkingHandler)handler;




// post网络请求
+ (void)postNetworkingWithURL:(NSString *)url
                      headers:(NSDictionary *)headers
                   parameters:(NSDictionary *)parameters
            CompletionHandler:(DJNetworkingHandler)handler;



@end



#pragma mark - DJUserData 用户信息类

/**
 * 用户信息类
 * Get、Set、updata用户信息
 */

@interface DJUserData : NSObject







@end

NS_ASSUME_NONNULL_END
