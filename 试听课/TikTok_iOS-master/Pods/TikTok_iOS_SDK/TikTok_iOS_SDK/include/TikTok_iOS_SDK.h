//
//  DJTikTok.h
//  TikTok_iOS_SDK
//
//  Created by 邓杰 on 2023/8/23.
//

#import <Foundation/Foundation.h>
#import <DJTikTokDelegate.h>
#import <DJUser.h>
#import <DJConversation.h>
#import "DJConstants.h"


@protocol DJTikTokDelegate;
@class    DJConversation;


extern NSString *const DJNetworkIsConnectingNotification;          // 正在连接中
extern NSString *const DJNetworkDidSetupNotification;              // 建立连接
extern NSString *const DJNetworkDidCloseNotification;              // 关闭连接
extern NSString *const DJNetworkDidRegisterNotification;           // 注册成功
extern NSString *const DJNetworkFailedRegisterNotification;        // 注册失败
extern NSString *const DKNetworkDidLoginNotification;              // 连接成功
extern NSString *const DJNetworkDidReceiveMessageNotification;     // 收到消息
extern NSString *const DJServiceErrorNotification;                 // 错误提示



///
/// DJTikTok核心头文件
///
/// 这是唯一需要导入到你的项目里的头文件，它引用了内部需要用到的头文件
///
@interface DJTikTok : NSObject

@property (nonatomic, strong) NSString *userToken;
@property (nonatomic, strong) DJUser *myUserInfo;

#define DJTIKTOK_VERSION @"0.1.6"


/**
 * @abstract 初始化DJTikTok_SDK
 *
 * @param launchOptions      AppDelegate启动函数的参数launchingOption(用于推送服务)
 * @param appKey                     appKey(应用Key值)
 * @param extra                       拓展字段，后续增加使用
 *
 * @discussion 此方法必须被调用, 以初始化 TikTok_SDK，如果未调用此方法, 本 SDK 的所有功能将不可用
 */
+ (void)setupDJTikTok:(NSDictionary *)launchOptions
               appKey:(NSString *)appKey
                extra:(id)extra;



/**
 * @abstract 增加回调(delegate protocol)监听
 *
 * @param delegate                  需要监听的 Delegate Protocol
 * @param conversation         接收与指定 conversation 相关的通知
 * - conversation 为 nil, 表示接收所有的通知, 不区分会话
 *
 * @discussion 默认监听全局 DJTikTokDelegate
 */
+ (void)addDelegate:(id <DJTikTokDelegate>)delegate withConversation:(DJConversation *)conversation;


/**
 * @abstract 移除回调(delegate protocol)监听
 *
 * @param delegate                  监听的 Delegate Protocol
 * @param conversation         基于某个会话的监听. 允许为 nil
 * - 为 nil, 表示全局的监听, 即所有会话相关
 * - 不为 nil, 表示特定的会话
 */
+ (void)removeDelegate:(id <DJTikTokDelegate>)delegate withConversation:(DJConversation *)conversation;


/**
 * @abstract 移除所有监听
 */
+ (void)removeAllDelegates;



/**
 * @abstract 获取项目唯一单例
 */
+ (instancetype)shareInstance;


/**
 * @abstract 注册远程推送
 * @param types               通知类型
 * @param categories    类别组
 *
 */
+ (void)registerForRemoteNotificationTypes:(NSUInteger)types categories:(NSSet *)categories;


/**
 * @abstract 注册 Google 登录服务
 * @param clienID               Google 开发平台发放的clientID
 *
 * @discussion 此方法必须被调用, 以注册 Google 登录服务
 */
+ (void)registerGoogleLoginWithClientID:(NSString *)clienID;



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
+ (void)registerFacebookLoginWithApplication:(UIApplication *)application
                        launchingWithOptions:(NSDictionary *)launchOptions;





/**
 * @abstract 注册 DeviceToken
 * @param deviceToken 从注册推送回调中拿到的 DeviceToken
 */
+ (void)registerDeviceToken:(NSData *)deviceToken;


/**
 *  @abstract 验证此 appKey 是否为当前应用 appKey
 *
 *  @param appKey 应用 AppKey
 *
 *  @return 是否为当前应用 appKey
 */
+ (BOOL)isMainAppKey:(NSString *)appKey;


/**
 * @abstract 判断是否设置全局免打扰
 *
 * @return YES/NO
 */
+ (BOOL)isSetGlobalNoDisturb;


/**
 * @abstract 设置是否全局免打扰
 *
 * @param isNoDisturb 是否全局免打扰 YES:是 NO: 否
 * @param handler 结果回调。回调参数：error 不为 nil,表示设置失败
 *
 * @discussion 此函数为设置全局的消息免打扰，建议开发者在 SDK 完全启动之后，再调用此接口获取数据
 */
+ (void)setIsGlobalNoDisturb:(BOOL)isNoDisturb handler:(DJCompletionHandler)handler;


/**
 * @abstract 用户免打扰列表
 *
 * @param handler 结果回调。回调参数：
 *
 * - resultObject 类型为 NSArray，数组里成员的类型为 JMSGUser、JMSGGroup
 * - error 错误信息
 *
 * 如果 error 为 nil, 表示设置成功
 * 如果 error 不为 nil,表示设置失败
 *
 * @discussion 从服务器获取，返回用户的免打扰列表。
 * 建议开发者在 SDK 完全启动之后，再调用此接口获取数据
 */
+ (void)noDisturbList:(DJCompletionHandler)handler;


/**
 * @abstract 黑名单列表
 *
 * @param handler 结果回调。回调参数：
 *
 * - resultObject 类型为 NSArray，数组里成员的类型为 JMSGUser
 * - error 错误信息
 *
 * 如果 error 为 nil, 表示设置成功
 * 如果 error 不为 nil,表示设置失败
 *
 * @discussion 从服务器获取，返回用户的黑名单列表。
 * 建议开发者在 SDK 完全启动之后，再调用此接口获取数据
 */
+ (void)blackList:(DJCompletionHandler)handler;


/**
 * @abstract 获取当前服务器端时间
 *
 * @discussion 可用于纠正本地时间。
 */
+ (NSTimeInterval)currentServerTime;


@end



/**
 * 用户登录设备信息
 */
@interface JMSGDeviceInfo: NSObject

/// 设备所属平台，Android、iOS、Windows、web
@property(nonatomic, assign, readonly) DJPlatformType platformType;
/// 是否登录，YES:已登录，NO:未登录
@property(nonatomic, assign, readonly) BOOL isLogin;
/// 是否在线，0:不在线，1:在线
@property(nonatomic, assign, readonly) UInt32 online;
/// 上次登录时间
@property(nonatomic, strong, readonly) NSNumber *mtime;
/// 默认为0，1表示该设备被当前登录设备踢出
@property(nonatomic, assign, readonly) NSInteger flag;

@end

