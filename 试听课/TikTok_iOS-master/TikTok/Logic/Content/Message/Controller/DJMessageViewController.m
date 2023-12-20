//
//  DJMessageViewController.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/11.
//

#import "DJMessageViewController.h"
#import "DJMessageView.h"
#import "DJScreen.h"

@interface DJMessageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) DJMessageView *messageView;

@end

@implementation DJMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor grayColor];
    
    self.messageView = [[DJMessageView alloc] init];
    [self.messageView setFrame:CGRectMake(VIEW_X(self.view), VIEW_Y(self.view), VIEW_WIDTH(self.view), VIEW_HEIGHT(self.view) - TABBARFULL_HEIGHT)];
    [self.messageView loadMessageView];
    [self.view addSubview:self.messageView];
    
    
    self.messageView.messageScrollView.delegate = self;

    // NavigationBar 按钮注册
    [self.messageView.messageNavBar.messageBtn addTarget:self action:@selector(clickMessageBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.messageView.messageNavBar.friendListBtn addTarget:self action:@selector(clickFriendListBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

#pragma mark --UIButton_callback - NavigationBar
- (void)clickMessageBtn {
    [UIView animateWithDuration:0.3 animations:^{
        self.messageView.messageNavBar.slider.frame = CGRectMake(MESSAGE_CENTER_X(self.messageView.messageNavBar) - VIEW_WIDTH(self.messageView.messageNavBar.slider) / 2,
                                                            VIEW_Y(self.messageView.messageNavBar.slider),
                                                            VIEW_WIDTH(self.messageView.messageNavBar.slider),
                                                            VIEW_HEIGHT(self.messageView.messageNavBar.slider));
        [self.messageView.messageScrollView setContentOffset:CGPointMake(0, 0)];
    }];
}

- (void)clickFriendListBtn {
    [UIView animateWithDuration:0.3 animations:^{
        self.messageView.messageNavBar.slider.frame = CGRectMake(FRIENDLIST_CENTER_X(self.messageView.messageNavBar) - VIEW_WIDTH(self.messageView.messageNavBar.slider) / 2,
                                                            VIEW_Y(self.messageView.messageNavBar.slider),
                                                            VIEW_WIDTH(self.messageView.messageNavBar.slider),
                                                            VIEW_HEIGHT(self.messageView.messageNavBar.slider));
        [self.messageView.messageScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    }];
}




#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 监听scrollView滑动
    self.messageView.messageNavBar.slider.center = CGPointMake(MESSAGE_CENTER_X(self.messageView.messageNavBar) + (scrollView.bounds.origin.x / SCREEN_WIDTH) * (FRIENDLIST_CENTER_X(self.messageView.messageNavBar) - MESSAGE_CENTER_X(self.messageView.messageNavBar)), VIEW_Y(self.messageView.messageNavBar.slider) + 1.5);
}


@end
