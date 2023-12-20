//
//  DJConfig.h
//  TikTok_iOS_SDK
//
//  Created by 邓杰 on 2023/8/30.
//

#import <Foundation/Foundation.h>
#import <DJNetworking/DJUserNetworking.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - DJDeviceConfig 设备配置类
/**
 * 设备配置类
 */
@interface DJDeviceConfig : NSObject

@property (nonatomic, strong) NSString *deviceInfo;
@property (nonatomic, strong) NSString *clientInfo;
@property (nonatomic, strong) NSString *loginIp;

typedef void (^DJDeviceConfigHandler)( DJClientInfo * _Nullable config);

/// 获取设备配置
//+ (void)getDeviceConfigWithHandler:(DJDeviceConfigHandler)handler;


@end





#pragma mark - DJNetworkingConfig 网络配置类

/**
 * 网络配置类
 */
@interface DJNetworkingConfig : NSObject

@property (nonatomic, strong) NSString *server_ip;
@property (nonatomic, strong) NSString *server_port;
@property (nonatomic, strong) NSString *server_route;

///// 初始化网络配置
//+ (DJRequestInfo *)initNetworkingConfigWithRoute:(NSString *)route
//                                        headers:(NSDictionary * _Nullable)header
//                                     parameters:(NSDictionary * _Nullable)parameters;

@end





NS_ASSUME_NONNULL_END
