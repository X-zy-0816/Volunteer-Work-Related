//
//  DJMineTopView.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/12.
//

#import "DJMineTopView.h"
#import "DJScreen.h"
#import "DJColor.h"


@implementation DJMineTopView


- (void)loadTopViewWithUserInfo:(DJUser *)userInfo {

#pragma mark -- background_view

    self.backgroundColor = [UIColor grayColor];
    
    // 背景图片1
    self.backgroundOne = [[UIImageView alloc] init];
    [self.backgroundOne setFrame:CGRectMake(0, -30, SCREEN_WIDTH, BACKGROUND_ONE_HEIGHT)];
    [self.backgroundOne setImage:[UIImage imageNamed:@"bg4"]];
    self.backgroundOne.contentMode = UIViewContentModeScaleAspectFill;
    /// 设置渐变颜色
    UIColor *colorOne = [UIColor colorWithRed:(70/255.0) green:(70/255.0) blue:(70/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(70/255.0) green:(70/255.0) blue:(70/255.0) alpha:0.0];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    /// 设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0.5, 0.9);
    gradient.endPoint = CGPointMake(0.5, 0.3);
    gradient.colors = colors;
    gradient.frame = CGRectMake(0, 0, SCREEN_WIDTH, BACKGROUND_ONE_HEIGHT);
    [self.backgroundOne.layer insertSublayer:gradient atIndex:0];
    [self addSubview:self.backgroundOne];
    
    // 背景图片2
    self.backgroundTwo = [[UIImageView alloc] init];
    [self.backgroundTwo setFrame:CGRectMake(0, BACKGROUND_TWO_Y, SCREEN_WIDTH, BACKGROUND_TWO_HEIGHT)];
    [self.backgroundTwo setImage:[UIImage imageNamed:@"bg2"]];
    /// 设置圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backgroundTwo.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.backgroundTwo.bounds;
    /// 设置圆角样式
    maskLayer.path = maskPath.CGPath;
    self.backgroundTwo.layer.mask = maskLayer;
    [self addSubview:self.backgroundTwo];


#pragma mark -- userInfo_view
    // 头像
    self.profileImage = [[UIImageView alloc] init];
    [self.profileImage setFrame:CGRectMake(20, 150, 90, 90)];
    [self.profileImage setImage:[UIImage imageNamed:@"bg3"]];
    
    /// 设置圆角
    self.profileImage.layer.masksToBounds=YES;
    /// 圆角半径
    self.profileImage.layer.cornerRadius = 45;
    [self addSubview:self.profileImage];
    
    
    // 昵称
    self.username = [[UILabel alloc] initWithFrame:CGRectMake(self.profileImage.frame.origin.x + self.profileImage.frame.size.width + 20,
                                                                                              self.profileImage.frame.origin.y + 25,
                                                                                                                               150,
                                                                                                                               30)];

    self.username.text = @"Flipped";//userInfo.nickname;
    self.username.textColor = [UIColor whiteColor];
    self.username.font = [UIFont systemFontOfSize:22 weight:UIFontWeightMedium];
    self.username.numberOfLines = 1;
    self.username.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.username];
    
    
    //ttk_id
    self.ttk_id = [[UILabel alloc] initWithFrame:CGRectMake(self.username.frame.origin.x,
                         self.username.frame.origin.y + self.username.frame.size.height,
                                                                                 200,
                                                                                  20)];
    self.ttk_id.text = [NSString stringWithFormat:@"ttk_id: %@", userInfo.username];//@"ttk_id: 1171276417";
    self.ttk_id.textColor = [UIColor whiteColor];
    self.ttk_id.font = [UIFont systemFontOfSize:15];
    self.ttk_id.numberOfLines = 1;
    self.ttk_id.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.ttk_id];
    
    
    // 点赞数
    self.favourCount = [[UILabel alloc] init];
    self.favourCount.text = @"4231";
    self.favourCount.textColor = [UIColor whiteColor];
    CGSize favourSize = [self.favourCount sizeThatFits:CGSizeMake(MAXFLOAT, 30)];
    [self.favourCount setFrame:CGRectMake(15, self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 15, favourSize.width + 5, 30)];
    self.favourCount.numberOfLines = 1;
    self.favourCount.textAlignment = NSTextAlignmentLeft;
    self.favourCount.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [self addSubview:self.favourCount];
    // 点赞string
    self.favourString = [[UILabel alloc] init];
    [self.favourString setFrame:CGRectMake(self.favourCount.frame.origin.x + self.favourCount.frame.size.width,
                                           self.favourCount.frame.origin.y + 6, 30, 20)];
    self.favourString.text = @"获赞";
    self.favourString.textColor = LIGHT_GRAY;
    self.favourString.font = [UIFont systemFontOfSize:12];
    self.favourString.numberOfLines = 1;
    [self addSubview:self.favourString];
    // 点赞列表button
    self.favourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.favourBtn setFrame:CGRectMake(self.favourCount.frame.origin.x,
                                        self.favourCount.frame.origin.y,
                                        self.favourCount.frame.size.width + 30,
                                        self.favourCount.frame.size.height)];
    self.favourBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.favourBtn];
    
    
    // 关注数
    self.followingCount = [[UILabel alloc] init];
    self.followingCount.text = @"134";
    self.followingCount.textColor = [UIColor whiteColor];
    CGSize followSize = [self.followingCount sizeThatFits:CGSizeMake(MAXFLOAT, 30)];
    [self.followingCount setFrame:CGRectMake(self.favourBtn.frame.origin.x + self.favourBtn.frame.size.width + 15, self.favourCount.frame.origin.y, followSize.width + 5, 30)];
    self.followingCount.numberOfLines = 1;
    self.followingCount.textAlignment = NSTextAlignmentLeft;
    self.followingCount.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [self addSubview:self.followingCount];
    // 关注string
    self.followingString = [[UILabel alloc] init];
    [self.followingString setFrame:CGRectMake(self.followingCount.frame.origin.x + self.followingCount.frame.size.width,
                                           self.followingCount.frame.origin.y + 6, 30, 20)];
    self.followingString.text = @"关注";
    self.followingString.textColor = LIGHT_GRAY;
    self.followingString.font = [UIFont systemFontOfSize:12];
    self.followingString.numberOfLines = 1;
    [self addSubview:self.followingString];
    // 关注列表button
    self.followingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.followingBtn setFrame:CGRectMake(self.followingCount.frame.origin.x,
                                      self.followingCount.frame.origin.y,
                                self.followingCount.frame.size.width + 30,
                                   self.followingCount.frame.size.height)];
    self.followingBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.followingBtn];
    
    
    
    // 粉丝数
    self.funsCount = [[UILabel alloc] init];
    self.funsCount.text = @"104万";
    self.funsCount.textColor = [UIColor whiteColor];
    CGSize funsSize = [self.funsCount sizeThatFits:CGSizeMake(MAXFLOAT, 30)];
    [self.funsCount setFrame:CGRectMake(self.followingBtn.frame.origin.x + self.followingBtn.frame.size.width + 15, self.favourCount.frame.origin.y, funsSize.width + 5, 30)];
    self.funsCount.numberOfLines = 1;
    self.funsCount.textAlignment = NSTextAlignmentLeft;
    self.funsCount.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [self addSubview:self.funsCount];
    // 粉丝string
    self.funsString = [[UILabel alloc] init];
    [self.funsString setFrame:CGRectMake(self.funsCount.frame.origin.x + self.funsCount.frame.size.width,
                                           self.funsCount.frame.origin.y + 6, 30, 20)];
    self.funsString.text = @"粉丝";
    self.funsString.textColor = LIGHT_GRAY;
    self.funsString.font = [UIFont systemFontOfSize:12];
    self.funsString.numberOfLines = 1;
    [self addSubview:self.funsString];
    // 粉丝列表button
    self.funsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.funsBtn setFrame:CGRectMake(self.funsCount.frame.origin.x,
                                      self.funsCount.frame.origin.y,
                                self.funsCount.frame.size.width + 30,
                                   self.funsCount.frame.size.height)];
    self.funsBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.funsBtn];
    

    // describe
    self.describe = [[UILabel alloc] init];
    self.describe.text = @"这个人懒，什么都没有留下....";
    self.describe.textColor = [UIColor whiteColor];
    self.describe.textAlignment = NSTextAlignmentNatural;
    self.describe.numberOfLines = 0;
    CGSize describeSize = [self.describe sizeThatFits:CGSizeMake(360, MAXFLOAT)];/**假设有多行，自适应高度*/
    if(describeSize.height < 20){/**如果只有一行，高度不变自适应宽度*/
        CGSize describeSize = [self.describe sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
        [self.describe setFrame:CGRectMake(15, self.favourBtn.frame.origin.y + self.favourBtn.frame.size.height, describeSize.width, 20)];
    }
    else{ /**如果有多行，直接返回高度*/
        [self.describe setFrame:CGRectMake(15, self.favourBtn.frame.origin.y + self.favourBtn.frame.size.height, 360, describeSize.height)];
    }
    
    self.describe.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.describe];
    
    
    // 城市
    self.location = [[UILabel alloc] init];
    self.location.text = @"IP:上海";
    [self.location setFrame:CGRectMake(15, self.describe.frame.origin.y + 5 + self.describe.frame.size.height, 50, 20)];
    self.location.textAlignment = NSTextAlignmentCenter;
    self.location.font = [UIFont systemFontOfSize:12];
    self.location.layer.backgroundColor = LIGHT_GRAY.CGColor;
    self.location.layer.cornerRadius = 9;
    [self addSubview:self.location];
    
    
    // 性别
    self.gender = [[UIImageView alloc] init];
    [self.gender setFrame:CGRectMake(self.location.frame.origin.x + self.location.frame.size.width + 10,
                                     self.location.frame.origin.y, 25, 20)];
    [self.gender setImage:[UIImage imageNamed:@"iconUserProfileGirl"]];
    self.gender.layer.backgroundColor = LIGHT_GRAY.CGColor;
    self.gender.contentMode = UIViewContentModeCenter;
    [self.gender.layer setCornerRadius:9];
    [self addSubview:self.gender];
    
    
#pragma mark -- setting_view
    
    // 编辑
    self.edittingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.edittingBtn setFrame:CGRectMake(250, self.gender.frame.origin.y, 80, 25)];
    [self.edittingBtn setTitle:@" 编辑资料 " forState:UIControlStateNormal];
    [self.edittingBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.edittingBtn.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
    [self.edittingBtn setShowsTouchWhenHighlighted:YES];
    [self.edittingBtn.layer setBackgroundColor:DARK_GRAY.CGColor];
    [self.edittingBtn.layer setCornerRadius:9];
    [self addSubview:self.edittingBtn];
    
    // 设置
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingBtn setFrame:CGRectMake(350, self.gender.frame.origin.y, 25, 25)];
    [self.settingBtn setBackgroundImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
    [self.settingBtn setShowsTouchWhenHighlighted:YES];
    [self.settingBtn.layer setBackgroundColor:DARK_GRAY.CGColor];
    [self.settingBtn.layer setCornerRadius:6];
    [self addSubview:self.settingBtn];
    
    
#pragma mark -- model_view
// 商城模块
    // 商城按钮
    self.storeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.storeBtn setFrame:CGRectMake(VIEW_X(self.location), VIEW_Y(self.location) + 35, (SCREEN_WIDTH - 50)/3, 45)];
    [self.storeBtn setBackgroundColor:DARK_GRAY];
    [self.storeBtn setShowsTouchWhenHighlighted:YES];
    [self.storeBtn.layer setCornerRadius:6];
    [self addSubview:self.storeBtn];
    // 商城icon
    self.storeIcon = [[UIImageView alloc] init];
    [self.storeIcon setFrame:CGRectMake(VIEW_X(self.storeBtn) + 15, VIEW_Y(self.storeBtn) + 5, 17, 17)];
    [self.storeIcon setImage:[UIImage imageNamed:@"user_store"]];
    [self addSubview:self.storeIcon];
    // 商城Title
    self.storeTitle = [[UILabel alloc] init];
    [self.storeTitle setFrame:CGRectMake(VIEW_X(self.storeIcon) + VIEW_WIDTH(self.storeIcon) + 5, VIEW_Y(self.storeIcon) - 2, 80, 20)];
    [self.storeTitle setText:@"购物商城"];
    [self.storeTitle setFont:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium]];
    [self.storeTitle setTextAlignment:NSTextAlignmentLeft];
    [self.storeTitle setTextColor:[UIColor whiteColor]];
    [self addSubview:self.storeTitle];
    // 商城note
    self.storeNote = [[UILabel alloc] init];
    [self.storeNote setFrame:CGRectMake(VIEW_X(self.storeIcon), VIEW_Y(self.storeIcon) + VIEW_HEIGHT(self.storeIcon) + 2, 90, 20)];
    [self.storeNote setText:@"查看推荐好物"];
    [self.storeNote setFont:[UIFont systemFontOfSize:10]];
    [self.storeNote setTextAlignment:NSTextAlignmentLeft];
    [self.storeNote setTextColor:LIGHT_GRAY];
    [self addSubview:self.storeNote];
    
    

// 历史模块（视频）
    // 按钮
    self.historyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.historyBtn setFrame:CGRectMake(VIEW_X(self.storeBtn) + VIEW_WIDTH(self.storeBtn) + 10, VIEW_Y(self.location) + 35, (SCREEN_WIDTH - 50)/3, 45)];
    [self.historyBtn setBackgroundColor:DARK_GRAY];
    [self.historyBtn setShowsTouchWhenHighlighted:YES];
    [self.historyBtn.layer setCornerRadius:6];
    [self addSubview:self.historyBtn];
    // icon
    self.historyIcon = [[UIImageView alloc] init];
    [self.historyIcon setFrame:CGRectMake(VIEW_X(self.historyBtn) + 15, VIEW_Y(self.historyBtn) + 5, 17, 17)];
    [self.historyIcon setImage:[UIImage imageNamed:@"user_history"]];
    [self addSubview:self.historyIcon];
    // Title
    self.historyTitle = [[UILabel alloc] init];
    [self.historyTitle setFrame:CGRectMake(VIEW_X(self.historyIcon) + VIEW_WIDTH(self.historyIcon) + 5, VIEW_Y(self.historyIcon) - 2, 80, 20)];
    [self.historyTitle setText:@"观看历史"];
    [self.historyTitle setFont:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium]];
    [self.historyTitle setTextAlignment:NSTextAlignmentLeft];
    [self.historyTitle setTextColor:[UIColor whiteColor]];
    [self addSubview:self.historyTitle];
    // note
    self.historyNote = [[UILabel alloc] init];
    [self.historyNote setFrame:CGRectMake(VIEW_X(self.historyIcon), VIEW_Y(self.historyIcon) + VIEW_HEIGHT(self.historyIcon) + 2, 90, 20)];
    [self.historyNote setText:@"快速找到观看历史"];
    [self.historyNote setFont:[UIFont systemFontOfSize:10]];
    [self.historyNote setTextAlignment:NSTextAlignmentLeft];
    [self.historyNote setTextColor:LIGHT_GRAY];
    [self addSubview:self.historyNote];
    
    
// 最常访问模块（用户）
    // 按钮
    self.recentlyVisitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.recentlyVisitBtn setFrame:CGRectMake(VIEW_X(self.historyBtn) + VIEW_WIDTH(self.historyBtn) + 10, VIEW_Y(self.location) + 35, (SCREEN_WIDTH - 50)/3, 45)];
    [self.recentlyVisitBtn setBackgroundColor:DARK_GRAY];
    [self.recentlyVisitBtn setShowsTouchWhenHighlighted:YES];
    [self.recentlyVisitBtn.layer setCornerRadius:6];
    [self addSubview:self.recentlyVisitBtn];
    // icon
    self.recentlyVisitIcon = [[UIImageView alloc] init];
    [self.recentlyVisitIcon setFrame:CGRectMake(VIEW_X(self.recentlyVisitBtn) + 15, VIEW_Y(self.recentlyVisitBtn) + 5, 17, 17)];
    [self.recentlyVisitIcon setImage:[UIImage imageNamed:@"user_people"]];
    [self addSubview:self.recentlyVisitIcon];
    // Title
    self.recentlyVisitTitle = [[UILabel alloc] init];
    [self.recentlyVisitTitle setFrame:CGRectMake(VIEW_X(self.recentlyVisitIcon) + VIEW_WIDTH(self.recentlyVisitIcon) + 5, VIEW_Y(self.recentlyVisitIcon) - 2, 80, 20)];
    [self.recentlyVisitTitle setText:@"最近访问"];
    [self.recentlyVisitTitle setFont:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium]];
    [self.recentlyVisitTitle setTextAlignment:NSTextAlignmentLeft];
    [self.recentlyVisitTitle setTextColor:[UIColor whiteColor]];
    [self addSubview:self.recentlyVisitTitle];
    // note
    self.recentlyVisitTitle = [[UILabel alloc] init];
    [self.recentlyVisitTitle setFrame:CGRectMake(VIEW_X(self.recentlyVisitIcon), VIEW_Y(self.recentlyVisitIcon) + VIEW_HEIGHT(self.recentlyVisitIcon) + 2, 90, 20)];
    [self.recentlyVisitTitle setText:@"查看最近访问的人"];
    [self.recentlyVisitTitle setFont:[UIFont systemFontOfSize:10]];
    [self.recentlyVisitTitle setTextAlignment:NSTextAlignmentLeft];
    [self.recentlyVisitTitle setTextColor:LIGHT_GRAY];
    [self addSubview:self.recentlyVisitTitle];
    
    
     
#pragma mark -- Video_category
    // 我的视频列表
    self.myVideoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.myVideoBtn setFrame:CGRectMake(80, BACKGROUND_TWO_Y + 10, (SCREEN_WIDTH - 160) / 3, 34)];
    [self.myVideoBtn setTitle:@"动态" forState:UIControlStateNormal];
    [self.myVideoBtn setTintColor:[UIColor blackColor]];
    [self.myVideoBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.myVideoBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self addSubview:self.myVideoBtn];

    // 点赞视频列表
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.likeBtn setFrame:CGRectMake(VIEW_X(self.myVideoBtn) + VIEW_WIDTH(self.myVideoBtn), VIEW_Y(self.myVideoBtn),(SCREEN_WIDTH - 180) / 3, 34)];
    [self.likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
    [self.likeBtn setTintColor:[UIColor blackColor]];
    [self.likeBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.likeBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self addSubview:self.likeBtn];
    
    // 收藏视频列表
    self.collectionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.collectionBtn setFrame:CGRectMake(VIEW_X(self.likeBtn) + VIEW_WIDTH(self.likeBtn), VIEW_Y(self.likeBtn),(SCREEN_WIDTH - 180) / 3, 34)];
    [self.collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.collectionBtn setTintColor:[UIColor blackColor]];
    [self.collectionBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.collectionBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self addSubview:self.collectionBtn];
    
    // 滑块
    self.slider = [[UIView alloc] init];
    [self.slider setFrame:CGRectMake(MYVEDIO_CENTER_X(self) - 20, VIEW_Y(self.myVideoBtn) + VIEW_HEIGHT(self.myVideoBtn) - 5, 40, 3)];
    [self.slider setBackgroundColor:[UIColor blackColor]];
    [self.slider.layer setCornerRadius:2];
    [self addSubview:self.slider];
    
    
    
    
}


@end
