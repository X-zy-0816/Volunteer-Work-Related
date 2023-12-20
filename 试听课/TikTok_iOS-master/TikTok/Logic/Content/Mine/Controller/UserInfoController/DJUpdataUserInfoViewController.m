//
//  DJUpdataUserInfoViewController.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/4.
//

#import "DJUpdataUserInfoViewController.h"
#import "DJUpdataUserInfoView.h"
#import "DJColor.h"
#import "DJScreen.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <TikTok_iOS_SDK/TikTok_iOS_SDK.h>


@interface DJUpdataUserInfoViewController () <TZImagePickerControllerDelegate>
@property (nonatomic, strong, readwrite) DJUserInfoItem *itemsInfo;
@property (nonatomic, strong, readwrite) DJUser *user;
@property (nonatomic, strong, readwrite) DJUserInfo *userInfo;
@property (nonatomic, strong, readwrite) DJUpdataUserInfoView *updataView;
@property (nonatomic, strong, readwrite) UIButton *finishButton;
@property (nonatomic, strong, readwrite) DJAvatarInfoView *avatarView;



@end

@implementation DJUpdataUserInfoViewController

- (instancetype)initWithItemsInfo:(DJUserInfoItem *)infoItem {
    self = [super init];
    if (self) {
        _itemsInfo = infoItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationItem setTitle:self.itemsInfo.text];
    [self.navigationController.navigationBar setAlpha:1];
    
    self.updataView = [[DJUpdataUserInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.updataView loadUpdataUserInfoViewWithInfoType:self.itemsInfo.infoType];
    [self.view addSubview:self.updataView];

    // 完成按钮（在navigationBar上布局，不用UI适应）
    self.finishButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56, 34)];
    self.finishButton.backgroundColor = WECHAT_GREEN;
    self.finishButton.layer.cornerRadius = 5;
    self.finishButton.layer.masksToBounds = YES;
    [self.finishButton addSubview:({
        UILabel *buttonLabel = [[UILabel alloc] init];
        buttonLabel.text = @"完成";
        buttonLabel.font = [UIFont boldSystemFontOfSize:17];
        buttonLabel.textColor = [UIColor whiteColor];
        [buttonLabel sizeToFit];
        buttonLabel.center = CGPointMake(self.finishButton.frame.size.width / 2, 34 / 2);
        buttonLabel;
    })];
    [self.finishButton addTarget:self action:@selector(clickFinishButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:self.finishButton];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
    
    
    
    // AvatarInfoView 按钮注册监听
    if (self.itemsInfo.infoType == DJInfoTypeAvatar) {
        self.avatarView = (DJAvatarInfoView *)self.updataView.childView;
        [self.avatarView.pickPictureButton addTarget:self action:@selector(loadImagePickerViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

- (void)clickFinishButton {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadImagePickerViewController {
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    imagePickerVC.allowPickingVideo = NO;
    imagePickerVC.allowPickingImage = YES;
    imagePickerVC.allowPickingOriginalPhoto = YES;
    
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = SCREEN_WIDTH - 2 * left;
    NSInteger top = (SCREEN_HEIGHT - widthHeight) / 2;
    if ([TZCommonTools tz_isLandscape]) {
        top = 30;
        widthHeight = SCREEN_HEIGHT - 2 * left;
        left = (SCREEN_WIDTH - widthHeight) / 2;
    }
    imagePickerVC.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVC.scaleAspectFillCrop = YES;
    
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {

        self.avatarView.headImageView.image = photos[0];
        [self.avatarView.headImageView setNeedsDisplay];
        NSLog(@"");

    }];
    
    imagePickerVC.allowCrop = YES;
    imagePickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


@end
