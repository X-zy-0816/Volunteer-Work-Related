//
//  DJUpdataUserInfoView.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/6.
//

#import "DJUpdataUserInfoView.h"
#import "DJScreen.h"
#import "DJColor.h"
#import <BRPickerView/BRPickerView.h>

@implementation DJUpdataUserInfoView

- (void)loadUpdataUserInfoViewWithInfoType:(DJInfoType)infoType {
    CGRect viewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    switch (infoType) {
        case DJInfoTypeAvatar:     self.childView = [[DJAvatarInfoView alloc] initWithFrame:viewFrame];        break;
        case DJInfoTypeNickname:   self.childView = [[DJNicknameInfoView alloc] initWithFrame:viewFrame];      break;
        case DJInfoTypeBirthday:   self.childView = [[DJBirthdayInfoView alloc] initWithFrame:viewFrame];      break;
        case DJInfoTypeGender:     self.childView = [[DJGenderInfoView alloc] initWithFrame:viewFrame];        break;
        case DJInfoTypeAddress:    self.childView = [[DJAddressInfoView alloc] initWithFrame:viewFrame];       break;
        case DJInfoTypeSignature:  self.childView = [[DJSignatureInfoView alloc] initWithFrame:viewFrame];     break;
        default: return;
    }
    
    [self addSubview:self.childView];
}

@end



@implementation DJAvatarInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WECHAT_BACKGROUND_GREY;

        [self addSubview:({
            _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH)];
            _headImageView.image = [UIImage imageNamed:@"head"];
            _headImageView;
        })];
        [self addSubview:({
            _pickPictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _pickPictureButton.frame = CGRectMake(0, SCREEN_WIDTH + 120, SCREEN_WIDTH, 60);
            //[[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH + 120, SCREEN_WIDTH, 60)];
            [_pickPictureButton addSubview:({
                UILabel *buttonLabel = [[UILabel alloc] init];
                buttonLabel.text = @"从相册中选取图片";
                buttonLabel.font = [UIFont systemFontOfSize:18];
                buttonLabel.alpha = 0.7;
                [buttonLabel sizeToFit];
                buttonLabel.center = CGPointMake(_pickPictureButton.frame.size.width / 2, _pickPictureButton.frame.size.height / 2);
                buttonLabel;
            })];
            _pickPictureButton.backgroundColor = [UIColor whiteColor];
            _pickPictureButton;
        })];


    }
    return self;
}

@end


@implementation DJNicknameInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WECHAT_BACKGROUND_GREY;
        
        [self addSubview:({
            _textView = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, SCREEN_WIDTH - 30, 50)];
            _textView.borderStyle = UITextBorderStyleRoundedRect;
            _textView.placeholder = @"请输入新昵称";
            _textView.backgroundColor = [UIColor whiteColor];
            _textView.textColor = [UIColor blackColor];
            _textView.textAlignment = NSTextAlignmentLeft;
            _textView.font = [UIFont systemFontOfSize:17];
            _textView.text = @"Flipped";
            _textView;
        })];
        
    }
    return self;
}

@end



@implementation DJBirthdayInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WECHAT_BACKGROUND_GREY;
        
        NSDate *minDate = [NSDate br_setYear:1900 month:1 day:1];
        NSDate *maxDate = [NSDate date];
        [BRDatePickerView showDatePickerWithMode:BRDatePickerModeYMD title:@"你的生日" selectValue:nil minDate:minDate maxDate:maxDate isAutoSelect:NO resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            NSLog(@"");
        }];
        
        
    }
    return self;
}

@end



@implementation DJGenderInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *dataSource = @[@"男", @"女", @"其他"];
        [BRStringPickerView showPickerWithTitle:@"性别" dataSourceArr:dataSource selectIndex:0 resultBlock:^(BRResultModel * _Nullable resultModel) {
           
            NSLog(@"");
        }];
        
    }
    return self;
}

@end



@implementation DJAddressInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WECHAT_BACKGROUND_GREY;

        [BRAddressPickerView showAddressPickerWithMode:BRAddressPickerModeArea selectIndexs:nil isAutoSelect:NO resultBlock:^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
            NSString *address = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
            NSLog(@"");
        }];
        
    }
    return self;
}

@end



@implementation DJSignatureInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WECHAT_BACKGROUND_GREY;

        [self addSubview:({
            _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 100, SCREEN_WIDTH - 30, 100)];
            _textView.text = @"这个人很懒，什么都没有留下。。。";
            _textView.backgroundColor = [UIColor whiteColor];
            _textView.scrollEnabled = NO;
            _textView.editable = YES;
            _textView.textColor = [UIColor blackColor];
            _textView.font = [UIFont systemFontOfSize:17];
            _textView.layer.cornerRadius = 6;
            _textView.returnKeyType = UIReturnKeyDone;
            _textView;
        })];
    }
    return self;
}

@end


