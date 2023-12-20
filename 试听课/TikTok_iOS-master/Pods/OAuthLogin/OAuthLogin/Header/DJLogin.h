//
//  DJLogin.h
//  OAuthLogin
//
//  Created by 邓杰 on 2023/8/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJLogin : NSObject

typedef void (^ FacebookLoginGetTokenBlock)(NSString *_Nullable token, NSError *_Nullable error);
typedef void (^ GoogleLoginGetTokenBlock)(NSString *_Nullable token, NSError *_Nullable error);


/*!
 * @abstract google登录授权获取token
 *
 * @param viewController        当前控制器的实例，在该控制器上弹出授权界面
 *
 * @discussion 通过用户授权获得token
 *
 */
+ (void)googleLoginWithViewController:(UIViewController *)viewController
                              handler:(GoogleLoginGetTokenBlock _Nullable)handler;



/*!
 * @abstract facebook登录授权获取token
 *
 * @param viewController        当前控制器的实例，在该控制器上弹出授权界面
 *
 * @discussion 通过用户授权获得token
 *
 */
+ (void)facebookLoginWithViewController:(UIViewController *)viewController
                                handler:(FacebookLoginGetTokenBlock _Nullable)handler;








@end

NS_ASSUME_NONNULL_END
