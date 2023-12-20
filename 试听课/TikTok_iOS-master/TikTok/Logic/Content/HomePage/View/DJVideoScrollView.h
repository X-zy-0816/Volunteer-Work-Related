//
//  DJVideoScrollView.h
//  TikTok
//
//  Created by 邓杰 on 2023/9/24.
//

#import <UIKit/UIKit.h>
#import "DJVideoItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJVideoScrollView : UIScrollView
@property (nonatomic, strong) NSMutableArray<DJVideoItemView *> *videoItemsViewArray;


- (void)loadVideoScrollView;

@end

NS_ASSUME_NONNULL_END
