//
//  DJMineTopView.h
//  TikTok
//
//  Created by 邓杰 on 2023/8/12.
//

#import <UIKit/UIKit.h>
#import <TikTok_iOS_SDK/TikTok_iOS_SDK.h>
#define MYVEDIO_CENTER_X(mineTopView) ((VIEW_X(mineTopView.myVideoBtn)*2 + VIEW_WIDTH(mineTopView.myVideoBtn)) / 2)
#define LIKE_CENTER_X(mineTopView) ((VIEW_X(mineTopView.likeBtn)*2 + VIEW_WIDTH(mineTopView.likeBtn)) / 2)
#define COLLECTION_CENTER_X(mineTopView) ((VIEW_X(mineTopView.collectionBtn)*2 + VIEW_WIDTH(mineTopView.collectionBtn)) / 2)

NS_ASSUME_NONNULL_BEGIN

@interface DJMineTopView : UIView
@property(nonatomic, strong) UIImageView *backgroundOne;
@property(nonatomic, strong) UIImageView *backgroundTwo;

@property(nonatomic, strong) UIImageView *profileImage;
@property(nonatomic, strong) UILabel *username;
@property(nonatomic, strong) UILabel *ttk_id;
@property(nonatomic, strong) UILabel *describe;

@property(nonatomic, strong) UILabel *favourCount;
@property(nonatomic, strong) UILabel *favourString;
@property(nonatomic, strong) UIButton *favourBtn;

@property(nonatomic, strong) UILabel *followingCount;
@property(nonatomic, strong) UILabel *followingString;
@property(nonatomic, strong) UIButton *followingBtn;

@property(nonatomic, strong) UILabel *funsCount;
@property(nonatomic, strong) UILabel *funsString;
@property(nonatomic, strong) UIButton *funsBtn;

@property(nonatomic, strong) UILabel *note;
@property(nonatomic, strong) UILabel *location;
@property(nonatomic, strong) UILabel *age;
@property(nonatomic, strong) UIImageView *gender;

@property(nonatomic, strong) UIButton *edittingBtn;
@property(nonatomic, strong) UIButton *settingBtn;

@property(nonatomic, strong) UIButton *storeBtn;
@property(nonatomic, strong) UIImageView *storeIcon;
@property(nonatomic, strong) UILabel *storeTitle;
@property(nonatomic, strong) UILabel *storeNote;

@property(nonatomic, strong) UIButton *historyBtn;
@property(nonatomic, strong) UIImageView *historyIcon;
@property(nonatomic, strong) UILabel *historyTitle;
@property(nonatomic, strong) UILabel *historyNote;

@property(nonatomic, strong) UIButton *recentlyVisitBtn;
@property(nonatomic, strong) UIImageView *recentlyVisitIcon;
@property(nonatomic, strong) UILabel *recentlyVisitTitle;
@property(nonatomic, strong) UILabel *recentlyVisitNote;

@property(nonatomic, strong) UIButton *myVideoBtn;
@property(nonatomic, strong) UIButton *likeBtn;
@property(nonatomic, strong) UIButton *collectionBtn;
@property(nonatomic, strong) UIView *slider;



- (void)loadTopViewWithUserInfo:(DJUser *)userInfo;

@end

NS_ASSUME_NONNULL_END
