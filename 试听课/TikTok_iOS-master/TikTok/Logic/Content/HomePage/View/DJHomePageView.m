//
//  DJHomePageView.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/22.
//

#import "DJHomePageView.h"
#import "DJVideoNavBar.h"
#import "DJScreen.h"

#define VIDEOTYPE_COUNT 5

@implementation DJHomePageView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 加载rootScrollView
        _homeScrollView = [[UIScrollView alloc] init];
        _homeScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBARFULL_HEIGHT);
        _homeScrollView.contentSize = CGSizeMake(VIEW_WIDTH(self) * VIDEOTYPE_COUNT, 0);
        _homeScrollView.alwaysBounceHorizontal = YES;
        _homeScrollView.bounces = NO;
        _homeScrollView.pagingEnabled = YES;
        _homeScrollView.showsVerticalScrollIndicator = NO;
        _homeScrollView.showsHorizontalScrollIndicator = NO;
        
        
        _homeScrollView.backgroundColor = [UIColor greenColor];
        
        // 加载 videoScrollView
        _videoScrollViewArray = [NSMutableArray arrayWithCapacity:VIDEOTYPE_COUNT];
        for (int i = 0; i < VIDEOTYPE_COUNT; i++) {
            _videoScrollViewArray[i] = [[UIScrollView alloc] initWithFrame:CGRectMake(
                                                       VIEW_WIDTH(_homeScrollView) * i,
                                                       -TOPSTATUSBAR_HEIGHT,
                                                       VIEW_WIDTH(_homeScrollView),
                                                       VIEW_HEIGHT(_homeScrollView))];
            [_videoScrollViewArray[i] setAlwaysBounceVertical:YES];
            [_videoScrollViewArray[i] setBounces:NO];
            [_videoScrollViewArray[i] setPagingEnabled:YES];
            [_videoScrollViewArray[i] setShowsVerticalScrollIndicator:NO];
            [_videoScrollViewArray[i] setShowsHorizontalScrollIndicator:NO];
            [_homeScrollView addSubview:self.videoScrollViewArray[i]];
            
        }
        
        _videoScrollViewArray[4].backgroundColor = [UIColor orangeColor];
        _videoScrollViewArray[0].backgroundColor = [UIColor orangeColor];

        [self addSubview:_homeScrollView];
        
        // 加载自定义navigationBar
        _videoNavBar = [[DJVideoNavBar alloc] initWithFrame:CGRectMake(0, TOPSTATUSBAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_HEIGHT)];
        [_videoNavBar loadVideoNavBar];
        [self addSubview:_videoNavBar];
    }
    return self;
}


@end
