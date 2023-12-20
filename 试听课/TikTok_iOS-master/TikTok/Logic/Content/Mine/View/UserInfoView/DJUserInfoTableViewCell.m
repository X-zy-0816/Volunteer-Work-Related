//
//  DJUserInfoTableViewCell.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/4.
//

#import "DJUserInfoTableViewCell.h"
#import "DJScreen.h"
#import <TikTok_iOS_SDK/TikTok_iOS_SDK.h>

@interface DJUserInfoTableViewCell()

@property (nonatomic, strong, readwrite) DJUser *myUser;
@property (nonatomic, strong, readwrite) DJUserInfoItem *infoItem;
@property (nonatomic, strong, readwrite) UIImageView *headImageView;

@end

@implementation DJUserInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 设置右边的一个小箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutWithInfoItem:(nonnull DJUserInfoItem *)infoItem {
    self.infoItem = infoItem;
    self.textLabel.text = self.infoItem.text;
    
    self.myUser = [DJUser myInfo];
    
    switch (self.infoItem.infoType) {
        case DJInfoTypeAvatar:
            [self.contentView addSubview:({
                self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 39 - 75, 0, 75, 75)];
                self.headImageView.center = CGPointMake(self.headImageView.center.x, self.infoItem.height / 2);
                if (self.myUser.avatar != nil) {
                    NSURL *imageUrl = [NSURL URLWithString:self.myUser.avatar];
                    // 异步加载图片
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
                        UIImage *image = [UIImage imageWithData:imageData];
                        // 回到主线程更新UI
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.headImageView.image = image;
                            [self.headImageView setNeedsDisplay];
                        });
                    });
                } else {
                    self.headImageView.image = [UIImage imageNamed:@"head"];
                }
                
                self.headImageView.layer.cornerRadius = 8;
                self.headImageView.layer.masksToBounds = YES;
                self.headImageView;
            })];
            break;

            
        case DJInfoTypeNickname:
            self.detailTextLabel.text = self.myUser.nickname;
            break;
        case DJInfoTypeBirthday:
            self.detailTextLabel.text = self.myUser.birthday;
            break;
        case DJInfoTypeGender:
            if (self.myUser.gender == DJUserGenderMale) {
                self.detailTextLabel.text = @"男";
            } else if (self.myUser.gender == DJUserGenderFemale) {
                self.detailTextLabel.text = @"女";
            } else {
                self.detailTextLabel.text = @"";
            }
            break;
        case DJInfoTypeAddress:
            self.detailTextLabel.text = self.myUser.address;
            break;
        case DJInfoTypeSignature:
            self.detailTextLabel.text = self.myUser.signature;
            self.detailTextLabel.numberOfLines = 2;
            break;
    }
}

- (void)reLayoutWithInfoItem:(nonnull DJUserInfoItem *)infoItem {
    self.detailTextLabel.text = @"";
    if (self.headImageView != nil) {
        [self.headImageView removeFromSuperview];
        self.headImageView = nil;
    }
    [self layoutWithInfoItem:infoItem];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
