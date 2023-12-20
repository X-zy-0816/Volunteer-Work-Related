//
//  DJVideoItemViewReusePool.h
//  TikTok
//
//  Created by 邓杰 on 2023/9/26.
//

#import <Foundation/Foundation.h>
#import "DJVideoItemView.h"
#define REUSEPOOL_CAPACITY 5

NS_ASSUME_NONNULL_BEGIN

@interface DJVideoItemViewReusePool : NSObject

- (void)enVideoItemViewReusePool:(DJVideoItemView *)videoItemView;

- (DJVideoItemView *)deVideoItemViewReusePool;


@end

NS_ASSUME_NONNULL_END
