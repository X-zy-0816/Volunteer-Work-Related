//
//  DJTabBarController.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/25.
//


#import "DJTabBarController.h"
#import "DJHomePageViewController.h"
#import "DJMessageViewController.h"
#import "DJPublishViewController.h"
#import "DJECommerceViewController.h"
#import "DJMineViewController.h"
#import "DJLoginViewController.h"


#define TABBARITE_NUMBER 5

@interface DJTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UIButton *postButton;

@end

@implementation DJTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //    UITabBar *tabBar = [UITabBar appearance];
    //    //[tabBar setBackgroundImage:[UIImage imageNamed:@"bg2"]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"bg2"]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 初始化设置所有UITabBarItems属性
    NSArray *classNameArray = @[@"DJHomePageViewController",
                                @"DJMessageViewController",
                                @"DJPublishViewController",
                                @"DJECommerceViewController",
                                @"DJMineViewController"];
    NSArray *titleArray = @[@"首页", @"消息", @"", @"商城", @"我的"];
    NSArray *imageNameArray = @[@"home_normal",
                                @"message_normal",
                                @"post_normal",
                                @"fishpond_normal",
                                @"account_normal",];
    NSArray *hightImageNameArray = @[@"home_highlight",
                                     @"message_highlight",
                                     @"post_highlight",
                                     @"fishpond_highlight",
                                     @"account_highlight"];
    
    // 加载控制器
    NSMutableArray *navigationControllers = @[].mutableCopy;
    for (int i = 0; i < TABBARITE_NUMBER; i++) {
        UIViewController *viewController = [[NSClassFromString(classNameArray[i]) alloc] init];
        viewController.tabBarItem.title = titleArray[i];
        viewController.tabBarItem.image = [UIImage imageNamed:imageNameArray[i]];
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:hightImageNameArray[i]];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [navigationControllers addObject:navigationController];
    }
    [self setViewControllers:navigationControllers.copy];
    
    //tabBar上添加一个UIButton遮盖住中间的UITabBarButton
    self.postButton.frame = CGRectMake((self.tabBar.frame.size.width-self.tabBar.frame.size.height)/2, 5, self.tabBar.frame.size.height, self.tabBar.frame.size.height);
    [self.tabBar addSubview:self.postButton];
    
    self.delegate = (id)self;
}

// 即将点击哪个控制器代理方法，需设置self.delegate = self;
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UINavigationController *navVC = (UINavigationController *)viewController;
    
    
    if (![navVC.topViewController isKindOfClass:[DJMineViewController class]] && ![navVC.topViewController isKindOfClass:[DJHomePageViewController class]]) {
        DJLoginViewController *loginVC = [[DJLoginViewController alloc] init];
        loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:loginVC animated:YES completion:nil];
        
        return NO;
    }
    
    
    if ([viewController isKindOfClass:[UITableViewController class]]) {
        // 点击了中间的那个控制器，此时需要替换成自己的点击事件
        [self centerButtonAction];
        return NO;
    }
    
    
    
    
    return YES;
}

- (UIButton *)centerButton {
    if (!_postButton) {
        _postButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_postButton setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [_postButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        
        [_postButton addTarget:self action:@selector(centerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postButton;
}

- (void)centerButtonAction {
    NSLog(@"拦截了控制器跳转，在这里面做自己想做的事");
}

@end
