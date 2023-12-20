//
//  DJUserInfoItemsInfo.h
//  TikTok
//
//  Created by 邓杰 on 2023/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// item 类型
typedef NS_ENUM(NSUInteger, DJInfoType) {
    DJInfoTypeAvatar                  = 0,  // 头像
    DJInfoTypeNickname                = 1,  // 昵称
    DJInfoTypeBirthday                = 2,  // 生日
    DJInfoTypeGender                  = 3,  // 性别
    DJInfoTypeAddress                 = 4,  // 地址
    DJInfoTypeSignature               = 5,  // 签名
};
 

@interface DJUserInfoItem : NSObject
@property (nonatomic, assign, readwrite) CGFloat height;
@property (nonatomic, assign, readwrite) DJInfoType infoType;
@property (nonatomic, copy,   readwrite) NSString *text;

@end

@interface DJUserInfoItemsInfo : NSArray

@end

NS_ASSUME_NONNULL_END
