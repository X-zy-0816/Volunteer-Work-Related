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
#import <SVProgressHUD/SVProgressHUD.h>

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
    [DJUser getThirdPartyTokenWithLoginPathway:DJGoogleLoginType viewController:self completionHandler:^(id resultObject, NSError *error) {
        dispatch_async(dispatch_get_main_queue(),^{
            [SVProgressHUD showWithStatus:@"正在登录"];
        });
        
        [DJUser getThirePartyUserInfoWithToken:resultObject loginPathway:DJGoogleLoginType completionHandler:^(id resultObject, NSError *error) {
            [DJUser loginWithAccount:nil code:nil thirdPartyToken:nil thirdPartyUserInfo:resultObject loginPathway:DJGoogleStandbyLoginType completionHandler:^(id resultObject, NSError *error) {
                
                
                dispatch_async(dispatch_get_main_queue(),^{
                    [SVProgressHUD dismiss];
                });
                [self back];
                NSLog(@"");
            }];
        }];
    }];
    
//    [DJUser loginThirdPartyWithLoginPathway:DJGoogleStandbyLoginType viewController:self completionHandler:^(id resultObject, NSError *error) {
//
//
//        [self back];
//    }];
    
    
}

- (void)facebookLogin {
    [DJUser loginThirdPartyWithLoginPathway:DJFacebookStandbyLoginType viewController:self completionHandler:^(id resultObject, NSError *error) {
        [self back];
    }];


}



- (void)instagramLogin {
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backSafariView) name:@"backSafariView" object:nil];

    
}

- (void)githubLogin {
    [self openGitHubLogin];
}

- (void)registerFunc {
    DJRegisterViewController *regiserVC = [[DJRegisterViewController alloc] init];
    [self.navigationController pushViewController:regiserVC animated:YES];
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
