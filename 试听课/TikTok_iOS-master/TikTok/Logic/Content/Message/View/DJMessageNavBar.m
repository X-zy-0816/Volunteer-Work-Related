//
//  DJMessageNavBar.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/25.
//

#import "DJMessageNavBar.h"
#import "DJScreen.h"

@implementation DJMessageNavBar

- (void)loadMessageNavBar {
    [self setBackgroundColor:[UIColor whiteColor]];
    
    // 添加好友按钮
    self.addFriend = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addFriend setFrame:CGRectMake(20, 5, 30, 30)];
    [self.addFriend setBackgroundImage:[UIImage imageNamed:@"message_add_friend"] forState:UIControlStateNormal];
    [self.addFriend setShowsTouchWhenHighlighted:YES];
    [self addSubview:self.addFriend];
    // 搜索按钮
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn setFrame:CGRectMake(SCREEN_WIDTH - 50, 5, 30, 30)];
    [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"home_bar_search"] forState:UIControlStateNormal];
    [self.searchBtn setShowsTouchWhenHighlighted:YES];
    [self.searchBtn.layer setCornerRadius:6];
    [self addSubview:self.searchBtn];
    
    // 消息按钮
    self.messageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.messageBtn setFrame:CGRectMake(100, 5, (SCREEN_WIDTH - 200) / 2, 34)];
    [self.messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [self.messageBtn setTintColor:[UIColor blackColor]];
    [self.messageBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.messageBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self addSubview:self.messageBtn];
   
    // 朋友列表按钮
    self.friendListBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.friendListBtn setFrame:CGRectMake(VIEW_X(self.messageBtn) + VIEW_WIDTH(self.messageBtn),
                                       VIEW_Y(self.messageBtn),
                                       VIEW_WIDTH(self.messageBtn),
                                       VIEW_HEIGHT(self.messageBtn))];
    [self.friendListBtn setTitle:@"朋友" forState:UIControlStateNormal];
    [self.friendListBtn setTintColor:[UIColor blackColor]];
    [self.friendListBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.friendListBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self addSubview:self.friendListBtn];
    
    
    // 滑块
    self.slider = [[UIView alloc] init];
    [self.slider setFrame:CGRectMake(MESSAGE_CENTER_X(self) - 17.5, VIEW_Y(self.messageBtn) + VIEW_HEIGHT(self.messageBtn) - 5, 35, 3)];
    [self.slider setBackgroundColor:[UIColor blackColor]];
    [self.slider.layer setCornerRadius:2];
    [self addSubview:self.slider];
    
}





@end
