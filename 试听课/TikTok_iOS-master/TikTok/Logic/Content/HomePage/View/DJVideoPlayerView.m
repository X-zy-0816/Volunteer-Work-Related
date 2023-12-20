//
//  DJVideoPlayerView.m
//  TikTok
//
//  Created by 邓杰 on 2023/11/6.
//

#import "DJVideoPlayerView.h"
#import "DJScreen.h"
#import "DJVideoData.h"


@implementation DJVideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, frame.size.width, frame.size.height-300)];
            _coverView;
        })];
        
        [self addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - 5) / 2, 50, 50)];
            _playButton;
        })];
        _isPlaying = NO;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark - private
- (void)_tapToPlay {
    NSLog(@"tapToPlay");
    if (!_isPlaying) {
        [_playButton setHidden:YES];
        [_avPlayer play];
        _isPlaying = YES;
    } else {
        [_playButton setHidden:NO];
        [_avPlayer pause];
        _isPlaying = NO;
    }

    
}


#pragma mark - public
- (void)layoutWithVideoItem:(DJVideoItemInfo *)itemInfo {
    _coverView.image = [UIImage imageNamed:itemInfo.videoCoverURL];
    _playButton.image = [UIImage imageNamed:@"Video_play"];
    _videoUrl = itemInfo.videoURL;
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *videoFilePath = [[cachePath stringByAppendingPathComponent:itemInfo.avatarURL] stringByAppendingPathComponent:@".mp4"];
    
    
    AVAsset *asset = [AVAsset assetWithURL:[DJVideoData cachedFileURLForVideoURL:itemInfo.avatarURL]];
    
    NSArray *array = asset.tracks;
    //获取视频大小
    CGSize videoSize = CGSizeZero;
        for (AVAssetTrack *track in array) {
            if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
                CGSize realSize = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform);
                videoSize = CGSizeMake(fabs(realSize.width), fabs(realSize.height));
            }
        }
    NSLog(@"width = %f,height = %f",videoSize.width,videoSize.height);
    
    if(videoSize.width != 0 && videoSize.height != 0)
        [_coverView setFrame:CGRectMake(0,
                                       (SCREEN_HEIGHT - TABBARFULL_HEIGHT - videoSize.height * SCREEN_WIDTH / videoSize.width) / 2,
                                        SCREEN_WIDTH,
                                        videoSize.height * SCREEN_WIDTH / videoSize.width)];
    
    
    AVPlayerItem *videoItem = [AVPlayerItem playerItemWithAsset:asset];
    _avPlayer = [AVPlayer playerWithPlayerItem:videoItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    self.playerLayer.frame = _coverView.bounds;
    [_coverView.layer addSublayer:self.playerLayer];
}


@end
