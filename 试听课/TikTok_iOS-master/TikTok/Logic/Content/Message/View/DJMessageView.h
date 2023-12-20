//
//  DJMessageView.h
//  TikTok
//
//  Created by 邓杰 on 2023/9/25.
//

#import <UIKit/UIKit.h>
#import "DJMessageNavBar.h"
#import "DJMessageTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJMessageView : UIView
@property (nonatomic, strong) DJMessageNavBar *messageNavBar;
@property (nonatomic, strong) UIScrollView *messageScrollView;
@property (nonatomic, strong) NSMutableArray<DJMessageTableView *> *messageTableViewArray;



- (void)loadMessageView;

@end

NS_ASSUME_NONNULL_END
