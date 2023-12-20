//
//  DJVideoPlayerView.h
//  TikTok
//
//  Created by 邓杰 on 2023/11/6.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DJVideoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJVideoPlayerView : UIView
@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic) BOOL isPlaying;

- (void)layoutWithVideoItem:(DJVideoItemInfo *)itemInfo;

@end

NS_ASSUME_NONNULL_END
