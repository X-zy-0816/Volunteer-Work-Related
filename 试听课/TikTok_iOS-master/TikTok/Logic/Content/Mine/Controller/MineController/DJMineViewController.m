//
//  DJMineViewController.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/11.
//

#import "DJMineViewController.h"
#import "DJScreen.h"
#import "DJMineView.h"
#import "EditUserInfoViewController.h"
#import "SettingViewController.h"


@interface DJMineViewController ()<UINavigationControllerDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) DJMineView *mineView;
@property (nonatomic, strong) DJUser *myUserInfo;

@end

@implementation DJMineViewController

- (instancetype)init {
    self = [super init];
    if(self) {
        _mineView = [[DJMineView alloc] init];

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.tabBar setHidden:NO];
    
    self.myUserInfo = [DJUser myInfo];
        
    [self.tabBarController.tabBar setHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.mineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.mineView loadMineView];
    [self.view addSubview:_mineView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
    self.mineView.rootScrollView.delegate = self;
    self.mineView.bottomSrcollView.delegate = self;
    
    
    
    [self.mineView.topView.myVideoBtn addTarget:self action:@selector(skipMyVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.mineView.topView.likeBtn addTarget:self action:@selector(skipLike) forControlEvents:UIControlEventTouchUpInside];
    [self.mineView.topView.collectionBtn addTarget:self action:@selector(skopCollection) forControlEvents:UIControlEventTouchUpInside];
    [self.mineView.topView.edittingBtn addTarget:self action:@selector(editUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.mineView.topView.settingBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];

}


#pragma mark --UIButton_callback
- (void)editUserInfo {
    EditUserInfoViewController *editUserInfoVC = [[EditUserInfoViewController alloc] init];
    [editUserInfoVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController.navigationBar setAlpha:1];
    [editUserInfoVC.navigationController.navigationItem setTitle:@"个人信息"];
    [self.navigationController pushViewController:editUserInfoVC animated:YES];
}
- (void)setting {
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)skipMyVideo {
    [UIView animateWithDuration:0.3 animations:^{
        self.mineView.topView.slider.frame = CGRectMake(MYVEDIO_CENTER_X(self.mineView.topView) - 20, VIEW_Y(self.mineView.topView.slider), VIEW_WIDTH(self.mineView.topView.slider), VIEW_HEIGHT(self.mineView.topView.slider));
        
        self.mineView.bottomSrcollView.contentOffset = CGPointMake(0, 0);
    }];
}
- (void)skipLike {
    [UIView animateWithDuration:0.3 animations:^{
        self.mineView.topView.slider.frame = CGRectMake(LIKE_CENTER_X(self.mineView.topView) - 20, VIEW_Y(self.mineView.topView.slider), VIEW_WIDTH(self.mineView.topView.slider), VIEW_HEIGHT(self.mineView.topView.slider));
        self.mineView.bottomSrcollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }];
}
- (void)skopCollection {
    [UIView animateWithDuration:0.3 animations:^{
        self.mineView.topView.slider.frame = CGRectMake(COLLECTION_CENTER_X(self.mineView.topView) - 20, VIEW_Y(self.mineView.topView.slider), VIEW_WIDTH(self.mineView.topView.slider), VIEW_HEIGHT(self.mineView.topView.slider));
        self.mineView.bottomSrcollView.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
    }];
}


#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 监听rootScrollView滑动
    if(scrollView == self.mineView.rootScrollView) {

        if(scrollView.bounds.origin.y > 150) {
            [self.navigationController.navigationBar setAlpha:(scrollView.bounds.origin.y - 150) / 95];
        } else {
            [self.navigationController.navigationBar setAlpha:0];
        }
    }
    
    // 监听bottomSrcollView滑动
    if(scrollView == self.mineView.bottomSrcollView) {
        self.mineView.topView.slider.center = CGPointMake((COLLECTION_CENTER_X(self.mineView.topView) - MYVEDIO_CENTER_X(self.mineView.topView)) * (scrollView.bounds.origin.x / (SCREEN_WIDTH * 2)) + MYVEDIO_CENTER_X(self.mineView.topView), VIEW_Y(self.mineView.topView.slider) + 1.5);
    }
    
    
}



#pragma mark --UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果进入的是当前视图控制器
    if (viewController == self) {
        [self.navigationController.navigationItem setTitle:self.mineView.topView.username.text];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else {
   // 进入其他视图控制器
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}




@end
