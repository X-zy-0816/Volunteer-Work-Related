//
//  DJLoginView.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/13.
//

#import "DJLoginView.h"
#import "DJColor.h"
#import "DJScreen.h"

@implementation DJLoginView

- (void)loadLoginView {
    
    [self setBackgroundColor:BABY_BLUE];

    // 退出
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setFrame:CGRectMake(20, 60, 20, 20)];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [self addSubview:self.backBtn];
    
    
    // icon
    self.icon = [[UIImageView alloc] init];
    [self.icon setFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, 165, 50, 50)];
    [self.icon setImage:[UIImage imageNamed:@"icon1"]];
    [self.icon setContentMode:UIViewContentModeScaleAspectFit];
    [self.icon setContentMode:UIViewContentModeCenter];
    [self.icon.layer setCornerRadius:9];
    [self addSubview:self.icon];
    
    
    // 账号
    self.textAccount = [[UITextField alloc] init];
    [self.textAccount setFrame:CGRectMake(SCREEN_WIDTH / 2 - 180, self.icon.frame.origin.y + 145, 360, 55)];
    [self.textAccount setPlaceholder:@" ttk_id、手机号或邮箱"];
    [self.textAccount setTextColor:[UIColor blackColor]];
    [self.textAccount setFont:[UIFont systemFontOfSize:14]];
    [self.textAccount setTextAlignment:NSTextAlignmentLeft];
    [self.textAccount setEnabled:YES];
    [self.textAccount setSecureTextEntry:NO];
    [self.textAccount setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textAccount setKeyboardType:UIKeyboardTypeNumberPad];
    [self.textAccount setReturnKeyType:UIReturnKeyNext];
    [self.textAccount setKeyboardAppearance:UIKeyboardAppearanceLight];
    [self addSubview:self.textAccount];
     
    
    // 密码
    self.textPassword = [[UITextField alloc] init];
    [self.textPassword setFrame:CGRectMake(SCREEN_WIDTH / 2 - 180, self.textAccount.frame.origin.y + 65, 360, 55)];
    [self.textPassword setPlaceholder:@" 密码"];
    [self.textPassword setTextColor:[UIColor blackColor]];
    [self.textPassword setFont:[UIFont systemFontOfSize:14]];
    [self.textPassword setTextAlignment:NSTextAlignmentLeft];
    [self.textPassword setEnabled:YES];
    [self.textPassword setSecureTextEntry:YES];
    [self.textPassword setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textPassword setKeyboardType:UIKeyboardTypeNumberPad];
    [self.textPassword setReturnKeyType:UIReturnKeyNext];
    [self.textPassword setKeyboardAppearance:UIKeyboardAppearanceLight];
    [self addSubview:self.textPassword];
    
    
    // 登录
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setFrame:CGRectMake(SCREEN_WIDTH / 2 - 140, self.textPassword.frame.origin.y + 80, 280, 45)];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    /**设置自定义背景颜色*/
    [self.loginBtn setBackgroundImage:[self imageFromColor:SKY_BLUE withSize:CGSizeMake(self.loginBtn.frame.size.width, self.loginBtn.frame.size.height)] forState:UIControlStateNormal];
    /** 绘制圆角 需设置的圆角*/
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.loginBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    /** 设置大小*/
    [maskLayer setFrame:self.loginBtn.bounds];
    /** 设置图形样子*/
    [maskLayer setPath:maskPath.CGPath];
    [self.loginBtn.layer setMask:maskLayer];
    [self addSubview:self.loginBtn];

    
    // 忘记密码
    self.forgetPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetPassBtn setTitle:@"忘记密码了?" forState:UIControlStateNormal];
    [self.forgetPassBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.forgetPassBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.forgetPassBtn setFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, self.loginBtn.frame.origin.y + 60, 100, 30)];
    [self.forgetPassBtn setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.forgetPassBtn];
    
    
    // Google登录
    self.googleLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.googleLoginBtn setFrame:CGRectMake(30, SCREEN_HEIGHT - 110, 40, 40)];
    [self.googleLoginBtn setImage:[UIImage imageNamed:@"login_google"] forState:UIControlStateNormal];
    [self.googleLoginBtn.layer setMasksToBounds:YES];
    [self.googleLoginBtn.layer setCornerRadius:20];
    [self addSubview:self.googleLoginBtn];
    
    // 注册
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerBtn setFrame:CGRectMake(SCREEN_WIDTH - self.googleLoginBtn.frame.origin.x - self.googleLoginBtn.frame.size.width, self.googleLoginBtn.frame.origin.y, self.googleLoginBtn.frame.size.width, self.googleLoginBtn.frame.size.height)];
    [self.registerBtn setImage:[UIImage imageNamed:@"login_register"] forState:UIControlStateNormal];
    [self.registerBtn.layer setMasksToBounds:YES];
    [self.registerBtn.layer setCornerRadius:20];
    [self addSubview:self.registerBtn];
    
    // qq
    self.qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.qqLoginBtn setFrame:CGRectMake(self.googleLoginBtn.frame.origin.x + self.googleLoginBtn.frame.size.width + 32.5, self.googleLoginBtn.frame.origin.y,self.googleLoginBtn.frame.size.width, self.googleLoginBtn.frame.size.height)];
    [self.qqLoginBtn setImage:[UIImage imageNamed:@"login_facebook"] forState:UIControlStateNormal];
    [self.qqLoginBtn.layer setMasksToBounds:YES];
    [self.qqLoginBtn.layer setCornerRadius:20];
    [self addSubview:self.qqLoginBtn];
    
    // github
    self.githubLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.githubLoginBtn setFrame:CGRectMake(SCREEN_WIDTH - self.qqLoginBtn.frame.origin.x - self.qqLoginBtn.frame.size.width, self.googleLoginBtn.frame.origin.y, self.googleLoginBtn.frame.size.width, self.googleLoginBtn.frame.size.height)];
    [self.githubLoginBtn setImage:[UIImage imageNamed:@"login_github"] forState:UIControlStateNormal];
    [self.githubLoginBtn.layer setMasksToBounds:YES];
    [self.githubLoginBtn.layer setCornerRadius:20];
    [self addSubview:self.githubLoginBtn];
    
    
    // 微信
    self.wechatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wechatLoginBtn setFrame:CGRectMake((SCREEN_WIDTH - self.googleLoginBtn.frame.size.width) / 2, self.googleLoginBtn.frame.origin.y, self.googleLoginBtn.frame.size.width, self.googleLoginBtn.frame.size.height)];
    [self.wechatLoginBtn setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    [self.wechatLoginBtn.layer setMasksToBounds:YES];
    [self.wechatLoginBtn.layer setCornerRadius:20];
    [self addSubview:self.wechatLoginBtn];
    
}


/// 将颜色转为纯色圆角图片
- (UIImage *)imageFromColor: (nonnull UIColor *)color withSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}



@end
