//
//  DJHomePageViewController.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/11.
//

#import "DJHomePageViewController.h"
#import "DJLoginViewController.h"
#import "DJHomePageView.h"
#import "DJVideoItemViewReusePool.h"
#import "DJScreen.h"
#import "DJVideoData.h"

@interface DJHomePageViewController () <UIScrollViewDelegate>
@property (nonatomic) int videoCurrentNum;
@property (nonatomic, strong) DJHomePageView *homeView;
@property (nonatomic, strong) DJVideoItemViewReusePool *videoItemViewReusePool;
@property (nonatomic, strong) NSMutableArray <DJVideoItemInfo *> *videoInfoArray;

@end

@implementation DJHomePageViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _videoCurrentNum = 0;
        _videoItemViewReusePool = [[DJVideoItemViewReusePool alloc] init];
        
        _videoInfoArray = [DJVideoData getSimulationVideoData];
        [DJVideoData downloadAndCacheVideo:_videoInfoArray];
        // [self downloadAndCacheVideo];



    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    self.homeView = [[DJHomePageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBARFULL_HEIGHT)];
    [self.view addSubview:self.homeView];
    
    self.homeView.homeScrollView.delegate = self;
    self.homeView.videoScrollViewArray[4].delegate = self;
    [_homeView.videoScrollViewArray[4] setContentSize:CGSizeMake(SCREEN_WIDTH, VIEW_HEIGHT(_homeView.videoScrollViewArray[4]) * _videoInfoArray.count)];
    [_homeView.homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 4, 0)];


    
    // NavigationBar 按钮注册
    [self.homeView.videoNavBar.liveStreamingBtn addTarget:self action:@selector(clickLiveStreamingBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.videoNavBar.localBtn addTarget:self action:@selector(clickLocalBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.videoNavBar.attentionBtn addTarget:self action:@selector(clickAttentionBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.videoNavBar.friendBtn addTarget:self action:@selector(clickFriendBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.videoNavBar.recommendBtn addTarget:self action:@selector(clickRecommendBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // VideoItem 按钮注册
    for (int i = 0; i < REUSEPOOL_CAPACITY; i++) {
        DJVideoItemView *videoItemView = [self.videoItemViewReusePool deVideoItemViewReusePool];
        [videoItemView.attentionBtn addTarget:self action:@selector(clickAttentionUserBtn) forControlEvents:UIControlEventTouchUpInside];
        [videoItemView.likeBtn addTarget:self action:@selector(clickLikeBtn) forControlEvents:UIControlEventTouchUpInside];
        [videoItemView.favoriteBtn addTarget:self action:@selector(clickFavoriteBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.videoItemViewReusePool enVideoItemViewReusePool:videoItemView];
    }
    
    
    
    // 初始化加载 videoItemView
    for (int i = 0; i < 4; i++) {
        DJVideoItemView *videoView = [_videoItemViewReusePool deVideoItemViewReusePool];
        [videoView loadVideoItemData:_videoInfoArray[i]];
        [videoView setFrame:CGRectMake(0, VIEW_HEIGHT(_homeView.videoScrollViewArray[4]) * i, SCREEN_WIDTH, VIEW_HEIGHT(_homeView.videoScrollViewArray[4]))];
        videoView.tag = i + 1;
        [_homeView.videoScrollViewArray[4] addSubview:videoView];
    }

}


#pragma mark --UIButton_callback - NavigationBar
- (void)clickLiveStreamingBtn {
    [UIView animateWithDuration:0.3 animations:^{
        self.homeView.videoNavBar.slider.frame = CGRectMake(LIVESTREAMING_CENTER_X(self.homeView.videoNavBar) - VIEW_WIDTH(self.homeView.videoNavBar.slider) / 2,
                                                            VIEW_Y(self.homeView.videoNavBar.slider),
                                                            VIEW_WIDTH(self.homeView.videoNavBar.slider),
                                                            VIEW_HEIGHT(self.homeView.videoNavBar.slider));
        [self.homeView.homeScrollView setContentOffset:CGPointMake(0, 0)];
    }];
}

- (void)clickLocalBtn {

    [UIView animateWithDuration:0.3 animations:^{
        self.homeView.videoNavBar.slider.frame = CGRectMake(LOCAL_CENTER_X(self.homeView.videoNavBar) - VIEW_WIDTH(self.homeView.videoNavBar.slider) / 2,
                                                            VIEW_Y(self.homeView.videoNavBar.slider),
                                                            VIEW_WIDTH(self.homeView.videoNavBar.slider),
                                                            VIEW_HEIGHT(self.homeView.videoNavBar.slider));
        [self.homeView.homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    }];
}

- (void)clickAttentionBtn {
    [UIView animateWithDuration:0.3 animations:^{
        self.homeView.videoNavBar.slider.frame = CGRectMake(ATTENTION_CENTER_X(self.homeView.videoNavBar) - VIEW_WIDTH(self.homeView.videoNavBar.slider) / 2,
                                                            VIEW_Y(self.homeView.videoNavBar.slider),
                                                            VIEW_WIDTH(self.homeView.videoNavBar.slider),
                                                            VIEW_HEIGHT(self.homeView.videoNavBar.slider));
        [self.homeView.homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 2, 0)];
    }];
}

- (void)clickFriendBtn {
    [UIView animateWithDuration:0.3 animations:^{
        self.homeView.videoNavBar.slider.frame = CGRectMake(FRIEND_CENTER_X(self.homeView.videoNavBar) - VIEW_WIDTH(self.homeView.videoNavBar.slider) / 2,
                                                            VIEW_Y(self.homeView.videoNavBar.slider),
                                                            VIEW_WIDTH(self.homeView.videoNavBar.slider),
                                                            VIEW_HEIGHT(self.homeView.videoNavBar.slider));
        [self.homeView.homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 3, 0)];
    }];
}

- (void)clickRecommendBtn {
    [UIView animateWithDuration:0.3 animations:^{
        self.homeView.videoNavBar.slider.frame = CGRectMake(RECOMMEND_CENTER_X(self.homeView.videoNavBar) - VIEW_WIDTH(self.homeView.videoNavBar.slider) / 2,
                                                            VIEW_Y(self.homeView.videoNavBar.slider),
                                                            VIEW_WIDTH(self.homeView.videoNavBar.slider),
                                                            VIEW_HEIGHT(self.homeView.videoNavBar.slider));
        [self.homeView.homeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 4, 0)];
    }];
}


#pragma mark --UIButton_callback - VideoView
- (void)clickAttentionUserBtn {
    int target;
    if (self.videoCurrentNum == 0) {
        target = 1;
    } else if (self.videoCurrentNum == self.videoInfoArray.count - 1) {
        target = 4;
    } else if (self.videoCurrentNum == self.videoInfoArray.count - 2) {
        target = 3;
    } else {
        target = 2;
    }
    UIScrollView *scrollView = self.homeView.videoScrollViewArray[4];
    for (DJVideoItemView *subview in scrollView.subviews) {
        if (subview.tag == target) {
            // 执行按钮操作
            [subview.attentionBtn setHidden:YES];

        }
    }
    
}

- (void)clickLikeBtn {
    int target;
    if (self.videoCurrentNum == 0) {
        target = 1;
    } else if (self.videoCurrentNum == self.videoInfoArray.count - 1) {
        target = 4;
    } else if (self.videoCurrentNum == self.videoInfoArray.count - 2) {
        target = 3;
    } else {
        target = 2;
    }
    UIScrollView *scrollView = self.homeView.videoScrollViewArray[4];
    for (DJVideoItemView *subview in scrollView.subviews) {
        if (subview.tag == target) {
            // 执行按钮操作
            [subview.likeBtn setBackgroundImage:[UIImage imageNamed:@"home_like_red"] forState:UIControlStateNormal];

        }
    }
}

- (void)clickFavoriteBtn {
    int target;
    if (self.videoCurrentNum == 0) {
        target = 1;
    } else if (self.videoCurrentNum == self.videoInfoArray.count - 1) {
        target = 4;
    } else if (self.videoCurrentNum == self.videoInfoArray.count - 2) {
        target = 3;
    } else {
        target = 2;
    }
    UIScrollView *scrollView = self.homeView.videoScrollViewArray[4];
    for (DJVideoItemView *subview in scrollView.subviews) {
        if (subview.tag == target) {
            // 执行按钮操作
            [subview.favoriteBtn setBackgroundImage:[UIImage imageNamed:@"home_favorite_red"] forState:UIControlStateNormal];

        }
    }
}


#pragma mark --NSNotification
- (void)addLoginNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLoginController) name:@"login" object:nil];
}


- (void)pushLoginController {
    UINavigationController *loginNC = nil;
    DJLoginViewController *loginVC = [[DJLoginViewController alloc] init];
    loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    loginNC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:loginNC animated:YES completion:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"login" object:nil];
}


#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 监听scrollView滑动
    if (scrollView == self.homeView.homeScrollView) {
        self.homeView.videoNavBar.slider.center = CGPointMake(LIVESTREAMING_CENTER_X(self.homeView.videoNavBar) + (scrollView.bounds.origin.x / (SCREEN_WIDTH * 4)) * (RECOMMEND_CENTER_X(self.homeView.videoNavBar) - LIVESTREAMING_CENTER_X(self.homeView.videoNavBar)), VIEW_Y(self.homeView.videoNavBar.slider) + 1.5);
    }
    
    
    if (scrollView == self.homeView.videoScrollViewArray[4]) {
        int count = scrollView.bounds.origin.y / VIEW_HEIGHT(self.homeView.homeScrollView);
        // 如果向下划动
        if (count > self.videoCurrentNum && count > 1 && count < self.videoInfoArray.count - 2) {
            // 移除顶部视图
            for (UIView *subview in scrollView.subviews) {
                if (subview.tag == 1) {
                    [self.videoItemViewReusePool enVideoItemViewReusePool:(DJVideoItemView *)subview];
                    [subview removeFromSuperview];
                } else {
                    subview.tag--;
                }
            }
            // 预加载添加视图到底部
            DJVideoItemView *videoView = [self.videoItemViewReusePool deVideoItemViewReusePool];
            [videoView loadVideoItemData:self.videoInfoArray[count + 2]];
            [videoView setFrame:CGRectMake(0, VIEW_HEIGHT(scrollView) * (count + 2), SCREEN_WIDTH, VIEW_HEIGHT(scrollView))];
            videoView.tag = 4;
            [scrollView addSubview:videoView];
        }
        
        // 如果向上滑动
        if (count < self.videoCurrentNum && count > 0) {
            // 移除底部视图
            for (UIView *subview in scrollView.subviews) {
                if (subview.tag == 4) {
                    [self.videoItemViewReusePool enVideoItemViewReusePool:(DJVideoItemView *)subview];
                    [subview removeFromSuperview];
                } else {
                    subview.tag++;
                }
            }
            // 预加载添加视图到顶部
            DJVideoItemView *videoView = [self.videoItemViewReusePool deVideoItemViewReusePool];
            [videoView loadVideoItemData:self.videoInfoArray[count - 1]];
            [videoView setFrame:CGRectMake(0, VIEW_HEIGHT(scrollView) * (count - 1), SCREEN_WIDTH, VIEW_HEIGHT(scrollView))];
            videoView.tag = 1;
            [scrollView addSubview:videoView];
        }
        
        self.videoCurrentNum = count;
    }

}










@end
