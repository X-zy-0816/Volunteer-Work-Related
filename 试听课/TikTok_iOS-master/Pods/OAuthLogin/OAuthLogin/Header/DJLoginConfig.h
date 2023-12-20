//
//  DJLoginConfig.h
//  OAuthLogin
//
//  Created by 邓杰 on 2023/8/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJLoginConfig : NSObject

/*!
 * @abstract 注册 FaceBook 登录服务
 *
 * @param application        系统的唯一单例UIApplication
 * @param launchOptions    AppDelegate启动函数的参数launchingOption
 *
 * @discussion 此方法必须被调用, 以注册 FaceBook 登录服务
 *
 * 如果未调用此方法,FaceBook 登录服务将不可用
 */
+ (void)registerFacebookLoginConfigWithApplication:(UIApplication *)application
                              launchingWithOptions:(NSDictionary *)launchOptions;


/*!
 * @abstract 注册 Google 登录服务
 *
 * @param clienID        Google 开发平台发放的clientID
 *
 * @discussion 此方法必须被调用, 以注册 Google 登录服务
 *
 * 如果未调用此方法,Google 登录服务将不可用
 */
+ (void)registerGoogleLoginConfigWithClientID:(NSString *)clienID;





@end

NS_ASSUME_NONNULL_END
