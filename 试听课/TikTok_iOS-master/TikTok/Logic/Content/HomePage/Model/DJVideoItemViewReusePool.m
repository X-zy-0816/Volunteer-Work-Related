//
//  DJVideoItemViewReusePool.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/26.
//

#import "DJVideoItemViewReusePool.h"

@interface DJVideoItemViewReusePool()
@property (nonatomic, strong) NSMutableArray <DJVideoItemView *> *videoItemViewQueue;

@end

@implementation DJVideoItemViewReusePool

- (instancetype)init {
    self = [super init];
    if (self) {
        _videoItemViewQueue = [NSMutableArray arrayWithCapacity:REUSEPOOL_CAPACITY];
        for (int i = 0; i < REUSEPOOL_CAPACITY; i++) {
            DJVideoItemView *videoItemView = [[DJVideoItemView alloc] init];
            [videoItemView loadVideoItemView];
            [self enVideoItemViewReusePool:videoItemView];
        }
    }
    return self;
}

- (void)enVideoItemViewReusePool:(DJVideoItemView *)videoItemView {
    [self clearVideoItemViewData:videoItemView];
    @synchronized (self.videoItemViewQueue) {
        [self.videoItemViewQueue addObject:videoItemView];
    }
}



- (DJVideoItemView *)deVideoItemViewReusePool {
    DJVideoItemView *videoItemView = [self.videoItemViewQueue firstObject];
    @synchronized (self.videoItemViewQueue) {
        [self.videoItemViewQueue removeObjectAtIndex:0];
    }
    return videoItemView;
}

- (void)clearVideoItemViewData:(DJVideoItemView *)videoItemView {
    
    [videoItemView.profileBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [videoItemView.likeCount setText:[NSString stringWithFormat:@""]];
    [videoItemView.commentCount setText:[NSString stringWithFormat:@""]];
    [videoItemView.favoriteCount setText:[NSString stringWithFormat:@""]];
    [videoItemView.transmitCount setText:[NSString stringWithFormat:@""]];
    [videoItemView.describe setText:@""];
    [videoItemView.username setText:@""];
    [videoItemView.videoPlayerView.playerLayer removeFromSuperlayer];
    [videoItemView.videoPlayerView.avPlayer pause];
    videoItemView.videoPlayerView.isPlaying = NO;
    [videoItemView.videoPlayerView.playButton setHidden:NO];
}


@end
