//
//  DJMineView.h
//  TikTok
//
//  Created by 邓杰 on 2023/8/11.
//

#import <UIKit/UIKit.h>
#import "DJMineTopView.h"
#import "DJMineBottomSrcollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJMineView : UIView
@property(nonatomic, strong) UIScrollView *rootScrollView;
@property(nonatomic, strong) DJMineTopView *topView;
@property(nonatomic, strong) DJMineBottomSrcollView *bottomSrcollView;


- (void)loadMineView;

@end

NS_ASSUME_NONNULL_END
