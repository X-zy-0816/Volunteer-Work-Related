//
//  DJMineBottomSrcollView.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/12.
//

#import "DJMineBottomSrcollView.h"
#import "DJScreen.h"

@implementation DJMineBottomSrcollView
 
- (void)loadBottomSrcollView {
    
    self.backgroundColor = [UIColor grayColor];
    
    [self setContentSize:CGSizeMake(SCREEN_WIDTH * 3, SCREEN_WIDTH)];
    [self setBounces:NO];
    [self setPagingEnabled:YES];
    [self setShowsVerticalScrollIndicator:NO];
    [self setShowsHorizontalScrollIndicator:NO];
    
    self.collectionViewArray = [NSMutableArray arrayWithCapacity:3];
    for(int i = 0; i < 3; i++) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionViewArray[i] = [[DJMineVideoCollectionView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        [self addSubview:self.collectionViewArray[i]];
    }
    self.collectionViewArray[0].backgroundColor = [UIColor whiteColor];
    self.collectionViewArray[1].backgroundColor = [UIColor greenColor];
    self.collectionViewArray[2].backgroundColor = [UIColor grayColor];
    
}




@end
