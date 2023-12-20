//
//  DJConstants.h
//  TikTok_iOS_SDK
//
//  Created by 邓杰 on 2023/8/25.
//

#ifndef DJConstants_h
#define DJConstants_h

#import <Foundation/Foundation.h>

typedef void (^DJCompletionHandler)(id resultObject, NSError *error);

typedef void (^DJAsyncDataHandler)(NSData *data, NSString *objectId, NSError *error);



/*!
 * 服务器配置信息
 */
#define SERVER_SCHEMES                            @"http://"
#define SERVER_IP                                 @"localhost"
#define SERVER_PORT                               @":8888"
#define LOGIN_ROUTE_PHONE_VERIFYCODE              @"/v1/sso/phoneVerifyCodeLogin"
#define LOGIN_ROUTE_PHONE_PASSWORD                @"/v1/sso/phonePassLogin"
#define LOGIN_ROUTE_EMAIL_VERIFYCODE              @"/v1/sso/emailVerifyCodeLogin"
#define LOGIN_ROUTE_EMAIL_PASSWORD                @"/v1/sso/phonePassLogin"
#define LOGIN_ROUTE_TTKID_PASSWORD                @"/v1/sso/TTKIDPassLogin"
#define LOGIN_ROUTE_GOOGLE                        @"/v1/sso/GoogleLogin"
#define LOGIN_ROUTE_FACEBOOK                      @"/v1/sso/FacebookLogin"
#define LOGIN_ROUTE_GITHUB                        @"/v1/sso/FacebookLogin"
#define LOGIN_ROUTE_STANDBY_GOOGLE                @"/v1/sso/StandbyGoogleLogin"
#define LOGIN_ROUTE_STANDBY_Facebook              @"/v1/sso/StandbyFacebookLogin"
#define LOGIN_ROUTE_STANDBY_GITHUB                @"/v1/sso/StandbyLogin"

#define GET_MYINFO_ROUTE                          @"/v1/user/self"





/*!
 * 平台类型
 */
typedef NS_ENUM(NSInteger, DJPlatformType) {
  /// 所有平台
  kJMSGPlatformTypeAll        = 0,
  /// Android 端
  kJMSGPlatformTypeAndroid    = 1,
  /// iOS 端
  kJMSGPlatformTypeiOS        = 2,
  /// Windows 端
  kJMSGPlatformTypeWindows    = 4,
  /// web 端
  kJMSGPlatformTypeWeb        = 16,
};


/*!
 * @abstract Generic 泛型
 */
#if __has_feature(objc_generics) || __has_extension(objc_generics)
#  define DJ_GENERIC(...) <__VA_ARGS__>
#else
#  define DJ_GENERIC(...)
#endif

/*!
 * @abstract nullable 用于定义某属性或者变量是否可允许为空
 */
#if __has_feature(nullability)
#  define DJ_NONNULL __nonnull
#  define DJ_NULLABLE __nullable
#else
#  define DJ_NONNULL
#  define DJ_NULLABLE
#endif



#endif /* DJConstants_h */
