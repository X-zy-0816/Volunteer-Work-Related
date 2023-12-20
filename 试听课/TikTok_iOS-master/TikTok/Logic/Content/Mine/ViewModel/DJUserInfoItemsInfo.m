//
//  DJUserInfoItemsInfo.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/4.
//

#import "DJUserInfoItemsInfo.h"

#define USERINFOITEM_NUMBER 6
#define AVATAR_ITEM_HEIGHT 100.0
#define OTHER_ITEM_HEIGHT 61.8
@implementation DJUserInfoItem

@end


@implementation DJUserInfoItemsInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableArray<DJUserInfoItem *> *mutableArray = @[].mutableCopy;
        
        NSArray *titleArray = @[@"头像", @"昵称", @"生日", @"性别", @"地址", @"签名"];
        NSArray<NSNumber *> *typeArray = @[[NSNumber numberWithUnsignedInteger:DJInfoTypeAvatar],
                                           [NSNumber numberWithUnsignedInteger:DJInfoTypeNickname],
                                           [NSNumber numberWithUnsignedInteger:DJInfoTypeBirthday],
                                           [NSNumber numberWithUnsignedInteger:DJInfoTypeGender],
                                           [NSNumber numberWithUnsignedInteger:DJInfoTypeAddress],
                                           [NSNumber numberWithUnsignedInteger:DJInfoTypeSignature],];
        
        NSArray<NSNumber *> *itemHeightArray = @[[NSNumber numberWithDouble:AVATAR_ITEM_HEIGHT],
                                            [NSNumber numberWithDouble:OTHER_ITEM_HEIGHT],
                                            [NSNumber numberWithDouble:OTHER_ITEM_HEIGHT],
                                            [NSNumber numberWithDouble:OTHER_ITEM_HEIGHT],
                                            [NSNumber numberWithDouble:OTHER_ITEM_HEIGHT],
                                            [NSNumber numberWithDouble:OTHER_ITEM_HEIGHT],];
        
        
        
        for (int i = 0; i < USERINFOITEM_NUMBER; i++) {
            DJUserInfoItem *item = [[DJUserInfoItem alloc] init];
            item.infoType = [typeArray[i] unsignedIntegerValue];
            item.height = (CGFloat)[itemHeightArray[i] doubleValue];
            item.text = titleArray[i];
            [mutableArray addObject:item];
        }
        self = mutableArray.copy;
    }
    return self;
}

@end
