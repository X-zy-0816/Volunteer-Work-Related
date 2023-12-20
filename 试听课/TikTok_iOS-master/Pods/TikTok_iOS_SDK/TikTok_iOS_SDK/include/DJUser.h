//
//  DJUser.h
//  TikTok_iOS_SDK
//
//  Created by 邓杰 on 2023/8/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DJConstants.h"
#import "DJConfig.h"

@class DJDeviceInfo;
@class DJUserInfo;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - UserData_enmu 声明
/**
 * @abstract 更新用户字段
 */
typedef NS_ENUM(NSUInteger, DJUserField) {
  /// 用户信息字段: 昵称
  DJUserFieldsNickname = 0,
  /// 用户信息字段: 生日
  DJUserFieldsBirthday = 1,
  /// 用户信息字段: 签名
  DJUserFieldsSignature = 2,
  /// 用户信息字段: 性别
  DJUserFieldsGender = 3,
  /// 用户信息字段: 区域
  DJUserFieldsRegion = 4,
  /// 用户信息字段: 头像 (内部定义的 media_id)
  DJUserFieldsAvatar = 5,
  /// 用户信息字段: 地址
  DJUserFieldsAddress = 6,
  /// 用户信息字段: 扩展字段
  DJUserFieldsExtras = 7,
};

/**
 * @abstract 用户性别
 */
typedef NS_ENUM(NSUInteger, DJUserGender) {
  /// 用户性别类型: 未知
  DJUserGenderUnknown = 0,
  /// 用户性别类型: 男
  DJUserGenderMale = 1,
  /// 用户性别类型: 女
  DJUserGenderFemale = 2,
};


#pragma mark - 用户信息类

/**
 * 用户信息类（仅用于修改用户信息、注册新用户）
 */
@interface DJUserInfo : NSObject
/** 昵称 */
@property(nonatomic, strong) NSString * nickname;
/** 生日，格式：时间戳 */
@property(nonatomic, strong) NSNumber * birthday;
/** 签名 */
@property(nonatomic, strong) NSString * signature;
/** 性别 */
@property(nonatomic, assign) DJUserGender gender;
/** 区域 */
@property(nonatomic, strong) NSString * region;
/** 地址 */
@property(nonatomic, strong) NSString * address;
/** 头像数据，注意：注册新用户时不支持同时上传头像 */
@property(nonatomic, strong) NSData   * avatarData;
/** 信息扩展字段，value 仅支持 NSString 类型*/
@property(nonatomic, strong) NSDictionary * extras;

@end




#pragma mark - DJUser_Class 用户管理类

/**
 * 用户管理类
 */
@interface DJUser : NSObject <NSCopying>

#pragma mark - User属性声明

///----------------------------------------------------
/// @name Basic Fields 基本属性
///----------------------------------------------------

/*!
 * @abstract 用户uid
 */
@property(nonatomic, assign, readonly) SInt64 uid;

/*!
 * @abstract 用户名
 *
 * @discussion 这是用户帐号，注册后不可变更。App 级别唯一。这是所有用户相关 API 的用户标识。
 */
@property(nonatomic, copy, readonly) NSString *username;

/*!
 * @abstract 邮箱
 */
@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE email;

/*!
 * @abstract 手机号
 */
@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE phoneNumber;

/*!
 * @abstract 用户昵称
 *
 * @discussion 用户自定义的昵称，可任意定义。
 */
@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE nickname;

/*!
 * @abstract 用户头像（媒体文件ID）
 *
 * @discussion 此文件ID仅用于内部更新，不支持外部URL。
 */
@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE avatar;

/*!
 * @abstract 性别
 *
 * @discussion 这是一个 enum 类型，支持 3 个选项：未知，男，女
 */
@property(nonatomic, assign, readonly) DJUserGender gender;

/*!
 * @abstract 生日
 */
@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE birthday;

@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE region;

@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE signature;

@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE address;

/*!
 * @abstract 备注名
 */
@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE noteName;

/*!
 * @abstract 备注信息
 */
@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE noteText;

/*!
 * @abstract 此用户所在的 appKey
 * @discussion 为主应用时, 此字段为空
 */
@property(nonatomic, copy, readonly) NSString * DJ_NULLABLE appKey;

/*!
 * @abstract 用户扩展字段
 */
@property(nonatomic, strong, readonly) NSDictionary * DJ_NULLABLE extras;

/*!
 * @abstract 该用户是否已被设置为免打扰
 *
 * @discussion YES:是 , NO: 否
 */
@property(nonatomic, assign, readonly) BOOL isNoDisturb;

/*!
 * @abstract 该用户是否已被加入黑名单
 *
 * @discussion YES:是 , NO: 否
 */
@property(nonatomic, assign, readonly) BOOL isInBlacklist;

/*!
 * @abstract 是否是好友关系
 *
 * @discussion 如果已经添加了好友，isFriend = YES ，否则为NO;
 */
@property(nonatomic, assign, readonly) BOOL isFriend;



///----------------------------------------------------
/// @name Class Methods 类方法
///----------------------------------------------------

#pragma mark - User登录注册方法

/**
 * @abstract 新用户注册(支持携带用户信息字段)
 *
 * @param username  用户名. 长度 4~128 位.
 *                  支持的字符: 字母,数字,下划线,英文减号,英文点,@邮件符号. 首字母只允许是字母或者数字.
 * @param password  用户密码. 长度 4~128 位.
 * @param userInfo  用户信息类，注册时携带用户信息字段，除用户头像字段
 * @param handler   结果回调. 返回正常时 resultObject 为 nil.
 *
 * @discussion 注意: 注册时不支持上传头像，其他信息全部支持
 */
+ (void)registerWithUsername:(NSString *)username
                    password:(NSString *)password
                    userInfo:(DJUserInfo * DJ_NULLABLE)userInfo
           completionHandler:(DJCompletionHandler DJ_NULLABLE)handler;


/**
 * @abstract 用户登录(账号密码登录)
 *
 * @param account                                    登录账号（邮箱 ｜ 手机号｜ttk_id）
 * @param code                                           确认码   （密码 ｜ 验证码）
 * @param token                                         第三方平台 token
 * @param thirdPartyUserInfo            第三方平台用户信息
 * @param loginPathway                          登录方式：手机密码｜手机验证码｜邮箱密码｜邮箱验证码｜ttkID密码 ｜第三方登录 等方式
 * @param handler                                     结果回调，resultObject 类型为 DJUser， error 错误信息
 *
 * - resultObject 简单封装的user对象
 * - error 错误信息
 */
+ (void)loginWithAccount:(NSString * DJ_NULLABLE)account
                    code:(NSString * DJ_NULLABLE)code
         thirdPartyToken:(NSString * DJ_NULLABLE)token
      thirdPartyUserInfo:(DJThirdPartyUserInfo * DJ_NULLABLE)thirdPartyUserInfo
            loginPathway:(DJLoginPathway)loginPathway
       completionHandler:(DJCompletionHandler DJ_NULLABLE)handler;


/*!
 * @abstract 第三方登录
 *
 * @param loginPathway                       登录方式：Google、Facebook、Github等第三方途径登录
 * @param viewController                  当前所在的控制器，在当前的控制器上弹出登录授权界面
 * @param handler                                  结果回调，resultObject 类型为 DJUser， error 错误信息
 *
 * @discussion 在项目 info 的 URL Types 添加一个项目，然后设置一个 URLSchemes，将该值作为参数传入方法
 */
+ (void)loginThirdPartyWithLoginPathway:(DJLoginPathway)loginPathway
                         viewController:(UIViewController *)viewController
                      completionHandler:(DJCompletionHandler DJ_NULLABLE)handler;



/*!
 * @abstract 获取第三方平台 Token
 *
 * @param loginPathway                       平台类型：Google、Facebook、Github等第三方平台
 * @param viewController                  当前所在的控制器，在当前的控制器上弹出登录授权界面
 * @param handler                                  结果回调，resultObject 类型为 NSString， error 错误信息
 *
 * @discussion 通过用户授权获取第三方平台发放的 token
 */
+ (void)getThirdPartyTokenWithLoginPathway:(DJLoginPathway)loginPathway
                            viewController:(UIViewController *)viewController
                         completionHandler:(DJCompletionHandler DJ_NULLABLE)handler;



/*!
 * @abstract  获取第三方平台用户信息
 *
 * @param token                                      第三方平台发放的 token
 * @param loginPathway                      平台类型：Google、Facebook、Github等第三方平台
 * @param handler                                  结果回调，resultObject 类型为 DJThirdPartyUserInfo， error 错误信息
 *
 * @discussion 通过第三方平台发放的 token 获取第三方平台用户信息
 */
+ (void)getThirePartyUserInfoWithToken:(NSString *)token
                          loginPathway:(DJLoginPathway)loginPathway
                     completionHandler:(DJCompletionHandler DJ_NULLABLE)handler;






/**
 * @abstract 当前用户退出登录
 *
 * @param handler 结果回调。正常返回时 resultObject 也是 nil。
 *
 */
+ (void)logout:(DJCompletionHandler DJ_NULLABLE)handler;




#pragma mark - Get方法（获取User信息）

/*!
 * @abstract 获取用户本身个人信息接口
 *
 * @return 当前登陆账号个人信息
 *
 * @discussion 注意：返回值有可能为空
 */
+ (DJUser *)myInfo;



/*!
 * @abstract 根据ttk_id获取用户信息
 *
 * @param ttk_id 用户的 ttk_id
 *
 * @return 该 ttk_id 用户信息
 *
 * @discussion 注意：返回值有可能为空，仅仅是本地查询
 */
+ (DJUser *DJ_NULLABLE)userWithUid:(SInt64)ttk_id;


/*!
 * @abstract 批量获取用户信息
 *
 * @param usernameArray 用户名列表。NSArray 里的数据类型为 NSString
 * @param handler 结果回调。正常返回时 resultObject 的类型为 NSArray，数组里的数据类型为 JMSGUser
 *
 * @discussion 这是一个批量接口。
 */
+ (void)userInfoArrayWithUsernameArray:(NSArray DJ_GENERIC(__kindof NSString *)*)usernameArray
                     completionHandler:(DJCompletionHandler)handler;


/*!
 * @abstract 获取头像缩略图文件数据
 *
 * @param handler 结果回调。回调参数:
 *
 * - data 头像数据;
 * - objectId 用户username;
 * - error 不为nil表示出错;
 *
 * 如果 error 为 ni, data 也为 nil, 表示没有头像数据.
 *
 * @discussion 需要展示缩略图时使用。
 * 如果本地已经有文件，则会返回本地，否则会从服务器上下载。
 */
- (void)thumbAvatarData:(DJAsyncDataHandler)handler;


/*!
 * @abstract 获取头像大图文件数据
 *
 * @param handler 结果回调。回调参数:
 *
 * - data 头像数据;
 * - objectId 用户username;
 * - error 不为nil表示出错;
 *
 * 如果 error 为 ni, data 也为 nil, 表示没有头像数据.
 *
 * @discussion 需要展示大图图时使用
 * 如果本地已经有文件，则会返回本地，否则会从服务器上下载。
 */
- (void)largeAvatarData:(DJAsyncDataHandler)handler;




#pragma mark - Set方法（设置User信息）

/*!
 * @abstract 添加黑名单
 * @param usernameArray 作用对象的username数组
 * @param handler 结果回调。回调参数： error 为 nil, 表示设置成功
 *
 * @discussion 可以一次添加多个用户
 */
+ (void)addUsersToBlacklist:(NSArray DJ_GENERIC(__kindof NSString *)*)usernameArray
          completionHandler:(DJCompletionHandler)handler;

/*!
 * @abstract 删除黑名单
 * @param usernameArray 作用对象的username数组
 * @param handler 结果回调。回调参数：error 为 nil, 表示设置成功
 *
 * @discussion 可以一次删除多个黑名单用户
 */
+ (void)delUsersFromBlacklist:(NSArray DJ_GENERIC(__kindof NSString *)*)usernameArray
            completionHandler:(DJCompletionHandler)handler;


/*!
 * @abstract 设置用户免打扰
 *
 * @param isNoDisturb 是否全局免打扰 YES:是 NO: 否
 * @param handler 结果回调。回调参数： error 为 nil, 表示设置成功
 *
 * @discussion 针对单个用户设置免打扰，这个接口支持跨应用设置免打扰
 */
- (void)setIsNoDisturb:(BOOL)isNoDisturb handler:(DJCompletionHandler)handler;



#pragma mark - update方法（更新User信息）

/*!
 * @abstract 更新用户信息（支持将字段统一上传）
 *
 * @param userInfo  用户信息对象，类型是 DJUserInfo
 * @param handler   更新用户信息回调接口函数
 *
 * @discussion 参数 userInfo 是 DJUserInfo 类，DJUserInfo 仅可用于修改用户信息
 */
+ (void)updateMyInfoWithUserInfo:(DJUserInfo *)userInfo
               completionHandler:(DJCompletionHandler)handler;


/*!
 * @abstract 更新头像（支持传图片格式）
 *
 * @param avatarData      头像数据
 * @param avatarFormat    头像格式，可以为空，不包括"."
 * @param handler         回调
 *
 * @discussion 头像格式参数直接填格式名称，不要带点。正确：@"png"，错误：@".png"
 */
+ (void)updateMyAvatarWithData:(NSData *)avatarData
                  avatarFormat:(NSString *)avatarFormat
             completionHandler:(DJCompletionHandler)handler;


/*!
 * @abstract 更新密码接口
 *
 * @param newPassword   用户新的密码
 * @param oldPassword   用户旧的密码
 * @param handler       更新密码回调接口函数
 */
+ (void)updateMyPasswordWithNewPassword:(NSString *)newPassword
                            oldPassword:(NSString *)oldPassword
                      completionHandler:(DJCompletionHandler DJ_NULLABLE)handler;


/*!
 * @abstract 修改好友备注名
 *
 * @param noteName 备注名
 *
 * @discussion 注意：这是建立在是好友关系的前提下，修改好友的备注名
 */
- (void)updateNoteName:(NSString *)noteName completionHandler:(DJCompletionHandler)handler;


/*!
 * @abstract 修改好友备注信息
 *
 * @param noteText 备注信息
 *
 * @discussion 注意：这是建立在是好友关系的前提下，修改好友的备注信息
 */
- (void)updateNoteText:(NSString *)noteText completionHandler:(DJCompletionHandler)handler;




@end




NS_ASSUME_NONNULL_END


