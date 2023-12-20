//
//  DJRegisterView.h
//  TikTok
//
//  Created by 邓杰 on 2023/8/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJRegisterView : UIView
@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) UITextField *textNickName;
@property(nonatomic, strong) UITextField *textAccount;
@property(nonatomic, strong) UITextField *textPassword;
@property(nonatomic, strong) UITextField *textSurePassword;
@property(nonatomic, strong) UIButton *registerBtn;


- (void)loadRegisterView;

@end

NS_ASSUME_NONNULL_END
