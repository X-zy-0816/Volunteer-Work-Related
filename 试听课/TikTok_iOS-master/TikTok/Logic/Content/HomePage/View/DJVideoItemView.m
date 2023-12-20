//
//  DJVideoItemView.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/26.
//

#import "DJVideoItemView.h"
#import "DJScreen.h"
#import "DJColor.h"


@implementation DJVideoItemView

- (void)loadVideoItemView {
    
    // 视频加载
    self.videoPlayerView = [[DJVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBARFULL_HEIGHT)];
    [self addSubview:self.videoPlayerView];
    
    // 头像按钮
    self.profileBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.profileBtn setFrame:CGRectMake(SCREEN_WIDTH - 55, 260, 50, 50)];
    //[self.profileBtn setBackgroundImage:[UIImage imageNamed:@"bg3"] forState:UIControlStateNormal];
    [self.profileBtn setShowsTouchWhenHighlighted:YES];
    [self.profileBtn.layer setMasksToBounds:YES];
    [self.profileBtn.layer setCornerRadius:50 / 2];
    [self addSubview:self.profileBtn];
    
    // 添加关注按钮 
    self.attentionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.attentionBtn setFrame:CGRectMake(VIEW_X(self.profileBtn) + VIEW_WIDTH(self.profileBtn) / 2 - 11, 300, 22, 22)];
    [self.attentionBtn setBackgroundImage:[UIImage imageNamed:@"home_attention"] forState:UIControlStateNormal];
    [self.attentionBtn setShowsTouchWhenHighlighted:YES];
    [self addSubview:self.attentionBtn];
    
    // 点赞按钮
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.likeBtn setFrame:CGRectMake(VIEW_X(self.profileBtn) + VIEW_WIDTH(self.profileBtn) / 2 - 17,
                                      VIEW_Y(self.profileBtn) + VIEW_HEIGHT(self.profileBtn) + 25,
                                      34,
                                      34)];
    [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"home_like_white"] forState:UIControlStateNormal];
    [self.likeBtn setShowsTouchWhenHighlighted:YES];
    [self.likeBtn.layer setMasksToBounds:YES];
    [self addSubview:self.likeBtn];
    // 点赞数
    self.likeCount = [[UILabel alloc] init];
    [self.likeCount setFrame:CGRectMake(VIEW_X(self.profileBtn) + VIEW_WIDTH(self.profileBtn) / 2 - 30,
                                        VIEW_Y(self.likeBtn) + VIEW_HEIGHT(self.likeBtn),
                                        60,
                                        20)];
    [self.likeCount setText:[NSString stringWithFormat:@"4301"]];
    [self.likeCount setTextColor:[UIColor whiteColor]];
    [self.likeCount setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium]];
    [self.likeCount setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.likeCount];
    
    
    // 评论按钮
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.commentBtn setFrame:CGRectMake(VIEW_X(self.likeBtn),
                                         VIEW_Y(self.likeCount) + VIEW_HEIGHT(self.likeCount) + 17,
                                         VIEW_WIDTH(self.likeBtn),
                                         VIEW_HEIGHT(self.likeBtn))];
    [self.commentBtn setBackgroundImage:[UIImage imageNamed:@"home_comment"] forState:UIControlStateNormal];
    [self.commentBtn setShowsTouchWhenHighlighted:YES];
    [self.commentBtn.layer setMasksToBounds:YES];
    [self addSubview:self.commentBtn];
    // 评论数
    self.commentCount = [[UILabel alloc] init];
    [self.commentCount setFrame:CGRectMake(VIEW_X(self.likeCount),
                                           VIEW_Y(self.commentBtn) + VIEW_HEIGHT(self.commentBtn),
                                           VIEW_WIDTH(self.likeCount),
                                           VIEW_HEIGHT(self.likeCount))];
    [self.commentCount setText:[NSString stringWithFormat:@"918"]];
    [self.commentCount setTextColor:[UIColor whiteColor]];
    [self.commentCount setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium]];
    [self.commentCount setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.commentCount];
    
    
    // 收藏按钮
    self.favoriteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.favoriteBtn setFrame:CGRectMake(VIEW_X(self.commentBtn),
                                          VIEW_Y(self.commentCount) + VIEW_HEIGHT(self.commentCount) + 17,
                                          VIEW_WIDTH(self.commentBtn),
                                          VIEW_HEIGHT(self.commentBtn))];
    [self.favoriteBtn setBackgroundImage:[UIImage imageNamed:@"home_favorite_white"] forState:UIControlStateNormal];
    [self.favoriteBtn setShowsTouchWhenHighlighted:YES];
    [self.favoriteBtn.layer setMasksToBounds:YES];
    [self addSubview:self.favoriteBtn];
    // 收藏数
    self.favoriteCount = [[UILabel alloc] init];
    [self.favoriteCount setFrame:CGRectMake(VIEW_X(self.commentCount),
                                            VIEW_Y(self.favoriteBtn) + VIEW_HEIGHT(self.favoriteBtn),
                                            VIEW_WIDTH(self.commentCount),
                                            VIEW_HEIGHT(self.commentCount))];
    [self.favoriteCount setText:[NSString stringWithFormat:@"2079"]];
    [self.favoriteCount setTextColor:[UIColor whiteColor]];
    [self.favoriteCount setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium]];
    [self.favoriteCount setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.favoriteCount];
    
    
    // 转发按钮
    self.transmitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.transmitBtn setFrame:CGRectMake(VIEW_X(self.favoriteBtn),
                                          VIEW_Y(self.favoriteCount) + VIEW_HEIGHT(self.favoriteCount) + 17,
                                          VIEW_WIDTH(self.favoriteBtn),
                                          VIEW_HEIGHT(self.favoriteBtn))];
    [self.transmitBtn setBackgroundImage:[UIImage imageNamed:@"home_transmit"] forState:UIControlStateNormal];
    [self.transmitBtn setShowsTouchWhenHighlighted:YES];
    [self.transmitBtn.layer setMasksToBounds:YES];
    [self addSubview:self.transmitBtn];
    // 转发数
    self.transmitCount = [[UILabel alloc] init];
    [self.transmitCount setFrame:CGRectMake(VIEW_X(self.commentCount),
                                            VIEW_Y(self.transmitBtn) + VIEW_HEIGHT(self.transmitBtn),
                                            VIEW_WIDTH(self.commentCount),
                                            VIEW_HEIGHT(self.commentCount))];
    [self.transmitCount setText:[NSString stringWithFormat:@"2079"]];
    [self.transmitCount setTextColor:[UIColor whiteColor]];
    [self.transmitCount setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium]];
    [self.transmitCount setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.transmitCount];


    
    
    
    // 进度条
    self.progressBar = [[UIView alloc] init];
    [self.progressBar setFrame:CGRectMake(15, SCREEN_HEIGHT - TABBARFULL_HEIGHT - 4.5, SCREEN_WIDTH - 30, 4.5)];
    [self.progressBar setBackgroundColor:[UIColor grayColor]];
    [self.progressBar.layer setCornerRadius:2];
    [self addSubview:self.progressBar];

    // 视频描述
    self.describe = [[UILabel alloc] init];
    [self.describe setFont:[UIFont systemFontOfSize:15]];
    [self.describe setText:@"今天天气不错呢，这是我的第一条视频"];
    [self.describe setTextColor:[UIColor whiteColor]];
    [self.describe setNumberOfLines:0];
    [self.describe setLineBreakMode:NSLineBreakByWordWrapping];
    CGSize describe_size = [self.describe sizeThatFits:CGSizeMake(SCREEN_WIDTH - 120, MAXFLOAT)];
    [self.describe setFrame:CGRectMake(15,
                                       VIEW_Y(self.progressBar) - describe_size.height - 15,
                                       describe_size.width,
                                       describe_size.height)];
    [self addSubview:self.describe];
    
    // 用户名
    self.username = [[UILabel alloc] init];
    //[self.username setText:@"@Flipped"];
    [self.username setTextColor:[UIColor whiteColor]];
    [self.username setFont:[UIFont systemFontOfSize:19 weight:UIFontWeightMedium]];
    [self.username setNumberOfLines:1];
    [self.username setLineBreakMode:NSLineBreakByWordWrapping];
//    CGSize username_size = [self.username sizeThatFits:CGSizeMake(MAXFLOAT, 25)];
//    [self.username setFrame:CGRectMake(15, VIEW_Y(self.describe) - 32, username_size.width, 25)];
    [self addSubview:self.username];

}



- (void)loadVideoItemData:(DJVideoItemInfo *)videoInfo {
    
    [self.profileBtn setBackgroundImage:[UIImage imageNamed:videoInfo.avatarURL] forState:UIControlStateNormal];
    [self.likeCount setText:[NSString stringWithFormat:@"%@", videoInfo.likeNumber]];
    [self.commentCount setText:[NSString stringWithFormat:@"%@", videoInfo.commemtNumber]];
    [self.favoriteCount setText:[NSString stringWithFormat:@"%@", videoInfo.favariteNumber]];
    [self.transmitCount setText:[NSString stringWithFormat:@"%@", videoInfo.transmitNumber]];
    
    [self.describe setText:videoInfo.describe];
    CGSize describe_size = [self.describe sizeThatFits:CGSizeMake(SCREEN_WIDTH - 120, MAXFLOAT)];
    [self.describe setFrame:CGRectMake(15,
                                                VIEW_Y(self.progressBar) - describe_size.height - 15,
                                                describe_size.width,
                                                describe_size.height)];
    [self.username setText:videoInfo.userName];
    CGSize username_size = [self.username sizeThatFits:CGSizeMake(MAXFLOAT, 25)];
    [self.username setFrame:CGRectMake(15, VIEW_Y(self.describe) - 32, username_size.width, 25)];
    
    
    if(!videoInfo.isStorage) {
        dispatch_semaphore_wait(videoInfo.dataSemaphore, DISPATCH_TIME_FOREVER);
    }
    [self.videoPlayerView layoutWithVideoItem:videoInfo];
    
    
    
}



@end
