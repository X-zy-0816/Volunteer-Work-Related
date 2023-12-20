//
//  DJLoginView.h
//  TikTok
//
//  Created by 邓杰 on 2023/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
 
@interface DJLoginView : UIView
@property(nonatomic, strong) UIButton *backBtn;
@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) UITextField *textAccount;
@property(nonatomic, strong) UITextField *textPassword;
@property(nonatomic, strong) UIButton *loginBtn;
@property(nonatomic, strong) UIButton *forgetPassBtn;
@property(nonatomic, strong) UIButton *googleLoginBtn;
@property(nonatomic, strong) UIButton *qqLoginBtn;
@property(nonatomic, strong) UIButton *wechatLoginBtn;
@property(nonatomic, strong) UIButton *githubLoginBtn;
@property(nonatomic, strong) UIButton *registerBtn;


- (void)loadLoginView;

@end

NS_ASSUME_NONNULL_END
