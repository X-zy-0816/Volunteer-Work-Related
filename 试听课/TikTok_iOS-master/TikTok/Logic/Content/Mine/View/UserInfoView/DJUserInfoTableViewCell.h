//
//  DJUserInfoTableViewCell.h
//  TikTok
//
//  Created by 邓杰 on 2023/9/4.
//

#import <UIKit/UIKit.h>
#import "DJUserInfoItemsInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJUserInfoTableViewCell : UITableViewCell

/// 用cell信息布局
/// @param infoItem 信息
- (void)layoutWithInfoItem:(DJUserInfoItem *)infoItem;

/// 复用回收重定义cell
/// @param infoItem 信息
- (void)reLayoutWithInfoItem:(DJUserInfoItem *)infoItem;

@end

NS_ASSUME_NONNULL_END
