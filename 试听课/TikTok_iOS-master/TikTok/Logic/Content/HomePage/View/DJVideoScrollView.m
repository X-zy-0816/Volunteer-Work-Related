//
//  DJVideoScrollView.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/24.
//

#import "DJVideoScrollView.h"
#import "DJScreen.h"

@implementation DJVideoScrollView

- (void)loadVideoScrollView {
    
    [self setContentSize:CGSizeMake(SCREEN_WIDTH, VIEW_HEIGHT(self) * 3)];
    [self setBounces:NO];
    [self setPagingEnabled:YES];
    [self setShowsVerticalScrollIndicator:NO];
    [self setShowsHorizontalScrollIndicator:NO];
    
//    self.videoItemsViewArray = [NSMutableArray arrayWithCapacity:3];
//    for (int i = 0; i < 3; i++) {
//        self.videoItemsViewArray[i] = [[DJVideoItemView alloc] initWithFrame:CGRectMake(0, i * VIEW_HEIGHT(self), SCREEN_WIDTH, VIEW_HEIGHT(self))];
//        [self.videoItemsViewArray[i] loadVideoItemView];
//        [self addSubview:self.videoItemsViewArray[i]];
//    }
}





@end
