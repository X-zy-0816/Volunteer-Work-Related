//
//  DJTikTok.m
//  TikTok_iOS_SDK
//
//  Created by 邓杰 on 2023/8/23.
//

#import "TikTok_iOS_SDK.h"
#import <OAuthLogin/OAuthLogin.h>

@implementation DJTikTok

+ (void)setupDJTikTok:(NSDictionary *)launchOptions appKey:(NSString *)appKey extra:(id)extra {
    
}




+ (void)addDelegate:(id <DJTikTokDelegate>)delegate withConversation:(DJConversation *)conversation {
    
}



+ (void)removeDelegate:(id <DJTikTokDelegate>)delegate withConversation:(DJConversation *)conversation {
    
    
}



+ (void)removeAllDelegates {
    
}




+ (void)registerForRemoteNotificationTypes:(NSUInteger)types categories:(NSSet *)categories {
    
}



+ (void)registerGoogleLoginWithClientID:(NSString *)clienID {

    [DJLoginConfig registerGoogleLoginConfigWithClientID:clienID];
}




+ (void)registerFacebookLoginWithApplication:(UIApplication *)application
                        launchingWithOptions:(NSDictionary *)launchOptions {
    
    [DJLoginConfig registerFacebookLoginConfigWithApplication:application launchingWithOptions:launchOptions];
}


+ (void)registerDeviceToken:(NSData *)deviceToken {
    
    
}


 


+ (BOOL)isMainAppKey:(NSString *)appKey {
    
    return YES;
}



+ (BOOL)isSetGlobalNoDisturb {
    
    return YES;
}





+ (void)setIsGlobalNoDisturb:(BOOL)isNoDisturb handler:(DJCompletionHandler)handler {
    
}





+ (void)noDisturbList:(DJCompletionHandler)handler {
    
}






+ (void)blackList:(DJCompletionHandler)handler {
    
}




+ (NSTimeInterval)currentServerTime {
    
    return 0;
}


static DJTikTok* _instance = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    });
    return _instance ;
    }
 
 //用alloc返回也是唯一实例
+ (DJTikTok *) allocWithZone:(struct _NSZone *)zone {
    return [DJTikTok shareInstance] ;
}
//对对象使用copy也是返回唯一实例
- (DJTikTok *)copyWithZone:(NSZone *)zone {
    return [DJTikTok shareInstance] ;//return _instance;
}
 //对对象使用mutablecopy也是返回唯一实例
- (DJTikTok *)mutableCopyWithZone:(NSZone *)zone {
    return [DJTikTok shareInstance] ;
}


@end
