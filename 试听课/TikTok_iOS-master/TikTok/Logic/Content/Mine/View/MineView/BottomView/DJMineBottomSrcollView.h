//
//  DJMineBottomSrcollView.h
//  TikTok
//
//  Created by 邓杰 on 2023/8/12.
//

#import <UIKit/UIKit.h>
#import "DJMineVideoCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJMineBottomSrcollView : UIScrollView
@property(nonatomic, strong) NSMutableArray<DJMineVideoCollectionView *> *collectionViewArray;


- (void)loadBottomSrcollView;

@end

NS_ASSUME_NONNULL_END
