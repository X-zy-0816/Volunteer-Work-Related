//
//  DJMessageNavBar.h
//  TikTok
//
//  Created by 邓杰 on 2023/9/25.
//

#import <UIKit/UIKit.h>

#define MESSAGE_CENTER_X(messageNavBar) (VIEW_X(messageNavBar.messageBtn) + VIEW_WIDTH(messageNavBar.messageBtn) / 2)
#define FRIENDLIST_CENTER_X(messageNavBar) (VIEW_X(messageNavBar.friendListBtn) + VIEW_WIDTH(messageNavBar.friendListBtn) / 2)

NS_ASSUME_NONNULL_BEGIN

@interface DJMessageNavBar : UIView
// 添加朋友按钮
@property (nonatomic, strong) UIButton *addFriend;
// 搜索按钮
@property (nonatomic, strong) UIButton *searchBtn;
// 消息按钮
@property (nonatomic, strong) UIButton *messageBtn;
// 朋友列表按钮
@property (nonatomic, strong) UIButton *friendListBtn;
// 滑动块
@property (nonatomic, strong) UIView *slider;

- (void)loadMessageNavBar;

@end

NS_ASSUME_NONNULL_END
