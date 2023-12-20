//
//  DJVideoItemView.h
//  TikTok
//
//  Created by 邓杰 on 2023/9/26.
//

#import <UIKit/UIKit.h>
#import "DJVideoPlayerView.h"
//#import "DJVideoItemInfo.h"
#import "DJVideoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJVideoItemView : UIView
@property (nonatomic, strong) DJVideoPlayerView *videoPlayerView;

@property (nonatomic, strong) UIButton *profileBtn;
@property (nonatomic, strong) UIButton *attentionBtn;

@property (nonatomic, strong) UIButton *followBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UILabel *likeCount;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UILabel *commentCount;
@property (nonatomic, strong) UIButton *favoriteBtn;
@property (nonatomic, strong) UILabel *favoriteCount;
@property (nonatomic, strong) UIButton *transmitBtn;
@property (nonatomic, strong) UILabel *transmitCount;

@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) UIButton *userBtn;
@property (nonatomic, strong) UILabel *describe;
@property (nonatomic, strong) UIView *progressBar;

@property (nonatomic, strong) id delegate;

- (void)loadVideoItemView;

- (void)loadVideoItemData:(DJVideoItemInfo *)videoInfo;

@end

NS_ASSUME_NONNULL_END
