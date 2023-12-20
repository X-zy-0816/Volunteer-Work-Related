//
//  DJRegisterView.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/14.
//

#import "DJRegisterView.h"
#import "DJColor.h"
#import "DJScreen.h"

@implementation DJRegisterView

- (void)loadRegisterView {
    
    [self setBackgroundColor:BABY_BLUE];
    
    // icon
    self.icon = [[UIImageView alloc] init];
    [self.icon setFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, 165, 50, 50)];
    [self.icon setImage:[UIImage imageNamed:@"icon1"]];
    [self.icon setContentMode:UIViewContentModeScaleAspectFit];
    [self.icon setContentMode:UIViewContentModeCenter];
    [self.icon.layer setCornerRadius:9];
    [self addSubview:self.icon];
    
    
    // 昵称
    self.textNickName = [[UITextField alloc] init];
    [self.textNickName setFrame:CGRectMake(SCREEN_WIDTH / 2 - 180, self.icon.frame.origin.y + 145, 360, 55)];
    [self.textNickName setPlaceholder:@" 昵称"];
    [self.textNickName setTextColor:[UIColor blackColor]];
    [self.textNickName setFont:[UIFont systemFontOfSize:14]];
    [self.textNickName setTextAlignment:NSTextAlignmentLeft];
    [self.textNickName setEnabled:YES];
    [self.textNickName setSecureTextEntry:NO];
    [self.textNickName setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textNickName setKeyboardType:UIKeyboardTypeNumberPad];
    [self.textNickName setReturnKeyType:UIReturnKeyNext];
    [self.textNickName setKeyboardAppearance:UIKeyboardAppearanceLight];
    [self addSubview:self.textNickName];
    
    
    // 账号
    self.textAccount = [[UITextField alloc] init];
    [self.textAccount setFrame:CGRectMake(SCREEN_WIDTH / 2 - 180, self.textNickName.frame.origin.y + 65, 360, 55)];
    [self.textAccount setPlaceholder:@" 手机号 ｜ 邮箱"];
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
    
    // 确认密码
    self.textSurePassword = [[UITextField alloc] init];
    [self.textSurePassword setFrame:CGRectMake(SCREEN_WIDTH / 2 - 180, self.textPassword.frame.origin.y + 65, 360, 55)];
    [self.textSurePassword setPlaceholder:@" 确认密码"];
    [self.textSurePassword setTextColor:[UIColor blackColor]];
    [self.textSurePassword setFont:[UIFont systemFontOfSize:14]];
    [self.textSurePassword setTextAlignment:NSTextAlignmentLeft];
    [self.textSurePassword setEnabled:YES];
    [self.textSurePassword setSecureTextEntry:YES];
    [self.textSurePassword setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textSurePassword setKeyboardType:UIKeyboardTypeNumberPad];
    [self.textSurePassword setReturnKeyType:UIReturnKeyNext];
    [self.textSurePassword setKeyboardAppearance:UIKeyboardAppearanceLight];
    [self addSubview:self.textSurePassword];
    
    
    // 注册
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerBtn setFrame:CGRectMake(SCREEN_WIDTH / 2 - 140, self.textSurePassword.frame.origin.y + 80, 280, 45)];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    /**设置自定义背景颜色*/
    [self.registerBtn setBackgroundImage:[self imageFromColor:SKY_BLUE withSize:CGSizeMake(self.registerBtn.frame.size.width, self.registerBtn.frame.size.height)] forState:UIControlStateNormal];
    /** 绘制圆角 需设置的圆角*/
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.registerBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    /** 设置大小*/
    [maskLayer setFrame:self.registerBtn.bounds];
    /** 设置图形样子*/
    [maskLayer setPath:maskPath.CGPath];
    [self.registerBtn.layer setMask:maskLayer];
    [self addSubview:self.registerBtn];

    
    
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
