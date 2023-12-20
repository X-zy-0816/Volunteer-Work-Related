//
//  DJUpdataUserInfoView.h
//  TikTok
//
//  Created by 邓杰 on 2023/9/6.
//

#import <UIKit/UIKit.h>
#import "DJUserInfoItemsInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJUpdataUserInfoView : UIView

@property (nonatomic, strong) UIView *childView;


- (void)loadUpdataUserInfoViewWithInfoType:(DJInfoType)infoType;

@end


/// 头像信息 View 类
@interface DJAvatarInfoView : UIView
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIButton *pickPictureButton;

@end


/// 昵称信息 View 类
@interface DJNicknameInfoView : UIView
@property (nonatomic, strong, readwrite) UITextField *textView;
@property (nonatomic, strong, readwrite) UILabel *numberLabel;

@end


/// 生日信息 View 类
@interface DJBirthdayInfoView : UIView

@end


/// 性别信息 View 类
@interface DJGenderInfoView : UIView

@end


/// 地址信息 View 类
@interface DJAddressInfoView : UIView

@end


/// 签名信息 View 类
@interface DJSignatureInfoView : UIView
@property (nonatomic, strong, readwrite) UITextView *textView;
@property (nonatomic, strong, readwrite) UILabel *numberLabel;

@end




NS_ASSUME_NONNULL_END
