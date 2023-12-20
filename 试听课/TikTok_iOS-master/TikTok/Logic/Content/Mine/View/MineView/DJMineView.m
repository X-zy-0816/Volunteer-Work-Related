//
//  DJMineView.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/11.
//

#import "DJMineView.h"
#import "DJScreen.h"

@implementation DJMineView

- (void)loadMineView {
    self.backgroundColor = [UIColor whiteColor];
    
    self.rootScrollView = [[UIScrollView alloc] init];
    [self.rootScrollView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.rootScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + BACKGROUND_TWO_Y - NAVIGATIONFULL_HEIGHT - NAVIGATIONFULL_HEIGHT - 30);
    self.rootScrollView.showsVerticalScrollIndicator = NO;
    self.rootScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.rootScrollView];
    
    
    self.topView = [[DJMineTopView alloc] init];
    [self.topView setFrame:CGRectMake(0, -NAVIGATIONFULL_HEIGHT, SCREEN_WIDTH, TOPVIEW_HEIGHT + NAVIGATIONFULL_HEIGHT)];
    [self.topView loadTopViewWithUserInfo:[DJUser myInfo]];
    [self.rootScrollView addSubview:self.topView];
    
    
    self.bottomSrcollView = [[DJMineBottomSrcollView alloc] initWithFrame:CGRectMake(0, TOPVIEW_HEIGHT - 75, SCREEN_WIDTH, SCREEN_HEIGHT - TOPVIEW_HEIGHT)];
    [self.bottomSrcollView loadBottomSrcollView];
    [self.rootScrollView addSubview:self.bottomSrcollView];

}



@end
