//
//  DJHomePageView.h
//  TikTok
//
//  Created by 邓杰 on 2023/9/22.
//

#import <UIKit/UIKit.h>
#import "DJVideoNavBar.h"
#import "DJVideoScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJHomePageView : UIView
@property (nonatomic, strong) DJVideoNavBar *videoNavBar;
@property (nonatomic, strong) UIScrollView *homeScrollView;
@property (nonatomic, strong) NSMutableArray<UIScrollView *> *videoScrollViewArray;

@end

NS_ASSUME_NONNULL_END
