//
//  AppDelegate.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/7.
//// 9f204ff9863d9722a909ae394508b9e2708d4582


#import "AppDelegate.h"
#import "AppDelegate+CYLTabBar.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@import FirebaseCore;
@import GoogleSignIn;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self configureForTabBarController];
    
    [FIRApp configure];
    
    [FBSDKApplicationDelegate.sharedInstance application:application didFinishLaunchingWithOptions:launchOptions];

    
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 判断是否是你的回调 URL
    if ([url.scheme isEqualToString:@"tiktok"] && [url.host isEqualToString:@"callback"]) {
        // 解析回调 URL，提取授权码
        NSString *query = [url query];
        NSArray *queryComponents = [query componentsSeparatedByString:@"&"];
        for (NSString *component in queryComponents) {
            NSArray *pairComponents = [component componentsSeparatedByString:@"="];
            NSString *key = [pairComponents firstObject];
            NSString *value = [pairComponents lastObject];
            if ([key isEqualToString:@"code"]) {
                // 在这里获取到了授权码 value，可以进行后续操作
                NSLog(@"授权码：%@", value);
                
                // 你可以在这里调用获取访问令牌的方法
                // ...
                [self exchangeAuthCodeForAccessToken:value];
                
                return YES;
            }
        }
    }
    
    // google登录
    //return [[GIDSignIn sharedInstance] handleURL:url];
    
    BOOL handled = [FBSDKApplicationDelegate.sharedInstance application:app openURL:url options:options];
    return handled;
    
    
    return NO;
}

- (void)exchangeAuthCodeForAccessToken:(NSString *)authCode {
    // 替换为你的 GitHub 应用的 Client ID 和 Client Secret
    NSString *clientID = @"c7efd3bd5e5dd6ed121e";
    NSString *clientSecret = @"9f204ff9863d9722a909ae394508b9e2708d4582";
    
    // 构建请求 URL
    NSString *tokenURLString = @"https://github.com/login/oauth/access_token";
    NSURL *tokenURL = [NSURL URLWithString:tokenURLString];
    
    // 构建请求参数
    NSDictionary *params = @{
        @"client_id": clientID,
        @"client_secret": clientSecret,
        @"code": authCode
        // 其他参数，根据 GitHub 文档要求
    };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:tokenURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // 构建请求体
    NSMutableString *body = [NSMutableString string];
    for (NSString *key in params) {
        NSString *encodedKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *encodedValue = [params[key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [body appendFormat:@"%@=%@&", encodedKey, encodedValue];
    }
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    // 发起请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"获取访问令牌失败：%@", error);
            return;
        }
        
        NSError *jsonError;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"解析响应失败：%@", jsonError);
            return;
        }
        
        NSString *accessToken = responseDict[@"access_token"];
        if (accessToken) {
            NSLog(@"访问令牌：%@", accessToken);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"backSafariView" object:nil];

            // 在这里可以使用访问令牌进行 GitHub API 请求
            // ...
        } else {
            NSLog(@"获取访问令牌失败");
        }
    }];
    [task resume];
}

//
//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}
//
//
//#pragma mark - Core Data stack
//
//@synthesize persistentContainer = _persistentContainer;
//
//- (NSPersistentCloudKitContainer *)persistentContainer {
//    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
//    @synchronized (self) {
//        if (_persistentContainer == nil) {
//            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"TikTok"];
//            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
//                if (error != nil) {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                    /*
//                     Typical reasons for an error here include:
//                     * The parent directory does not exist, cannot be created, or disallows writing.
//                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                     * The device is out of space.
//                     * The store could not be migrated to the current model version.
//                     Check the error message to determine what the actual problem was.
//                    */
//                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//                    abort();
//                }
//            }];
//        }
//    }
//
//    return _persistentContainer;
//}
//
//#pragma mark - Core Data Saving support
//
//- (void)saveContext {
//    NSManagedObjectContext *context = self.persistentContainer.viewContext;
//    NSError *error = nil;
//    if ([context hasChanges] && ![context save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
//}

@end
