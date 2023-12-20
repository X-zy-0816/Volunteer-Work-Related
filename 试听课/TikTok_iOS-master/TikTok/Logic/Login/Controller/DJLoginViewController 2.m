//
//  DJLoginViewController.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/13.
//

#import "DJLoginViewController.h"
#import "DJLoginView.h"
#import "DJScreen.h"
#import "DJRegisterViewController.h"
#import <TikTok_iOS_SDK/TikTok_iOS_SDK.h>

@interface DJLoginViewController ()<UINavigationControllerDelegate>
@property(nonatomic, strong) DJLoginView *loginView;


@end

@implementation DJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.loginView = [[DJLoginView alloc] init];
    [self.loginView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.loginView loadLoginView];
    [self.view addSubview:self.loginView];
    
    self.navigationController.delegate = self;
    


    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.loginView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.forgetPassBtn addTarget:self action:@selector(forgetPass) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.googleLoginBtn addTarget:self action:@selector(googleLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.qqLoginBtn addTarget:self action:@selector(facebookLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.wechatLoginBtn addTarget:self action:@selector(instagramLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.githubLoginBtn addTarget:self action:@selector(githubLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.registerBtn addTarget:self action:@selector(registerFunc) forControlEvents:UIControlEventTouchUpInside];
}


- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果进入的是当前视图控制器
    if (viewController == self) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
   // 进入其他视图控制器
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}


- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)login {
    NSURL *appBURL=[NSURL URLWithString:@"testGithub://ThisatestAPP"];
    [[UIApplication sharedApplication] openURL:appBURL options:@{} completionHandler:^(BOOL success) {
        NSLog(@"");
    }];

}

- (void)forgetPass {
    
}

- (void)googleLogin {
//    [DJUser loginAuthorizeWithPathway:(NSUInteger *)DJGoogleLoginType viewController:self completionHandler:^(id resultObject, NSError *error) {
//
//        __block id obj = nil;
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//
//
//        NSString *accessToken = (NSString *)resultObject;
//        NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/oauth2/v1/userinfo?access_token=%@", accessToken];
//        NSURL *url = [NSURL URLWithString:urlString];
//
//        NSURLSession *session = [NSURLSession sharedSession];
//        NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            if (error) {
//                NSLog(@"Error sending request: %@", error);
//                return;
//            }
//
//            NSError *jsonError = nil;
//            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//            if (jsonError) {
//                NSLog(@"Error parsing JSON: %@", jsonError);
//                return;
//            }
//            obj = jsonObject;
//
//            //NSLog(@"API Response: %@", jsonObject);
//
//            dispatch_semaphore_signal(semaphore);
//
//        }];
//
//        [task resume];
//
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        NSLog(@"%@",obj);
//
//    }];
//
    
    [DJUser loginThirdPartyWithLoginPathway:DJGoogleStandbyLoginType viewController:self completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"");
    }];
    
    
    
    
}

- (void)facebookLogin {
//    [DJUser loginAuthorizeWithPathway:(NSUInteger *)DJFacebookLoginType viewController:self completionHandler:^(id resultObject, NSError *error) {
//
//        __block id obj = nil;
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//
//        NSString *accessToken = (NSString *)resultObject;
//        NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/v13.0/me?fields=name,email,picture&access_token=%@", accessToken];
//        NSURL *url = [NSURL URLWithString:urlString];
//
//        NSURLSession *session = [NSURLSession sharedSession];
//        NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            if (error) {
//                NSLog(@"Error sending request: %@", error);
//                return;
//            }
//
//            NSError *jsonError = nil;
//            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//            if (jsonError) {
//                NSLog(@"Error parsing JSON: %@", jsonError);
//                return;
//            }
//
//            obj = jsonObject;
//
//            NSLog(@"API Response: %@", jsonObject);
//        }];
//
//        [task resume];
//
//
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        NSLog(@"%@",obj);
//
//
//        NSLog(@"");
//    }];

}



- (void)instagramLogin {
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backSafariView) name:@"backSafariView" object:nil];

    
}

- (void)githubLogin {
    [self openGitHubLogin];
}

- (void)registerFunc {
    DJRegisterViewController *registerVC = [[DJRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


- (void)openGitHubLogin {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backSafariView) name:@"backSafariView" object:nil];

    NSString *clientID = @"052476621b2960a3041e"; // 替换为你的 GitHub 应用的 Client ID
    NSString *redirectURI = @"tiktok://callback";      // 替换为你的应用的 URL Scheme

    NSString *urlString = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize?client_id=%@&redirect_uri=%@", clientID, redirectURI];
    __unused NSURL *url = [NSURL URLWithString:urlString];



    
}

- (void)backSafariView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backSafariView" object:nil];
}



@end
