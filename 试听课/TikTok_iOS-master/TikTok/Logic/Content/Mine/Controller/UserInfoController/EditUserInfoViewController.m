//
//  EditUserInfoViewController.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/3.
//

#import "EditUserInfoViewController.h"
#import "DJScreen.h"
#import "DJColor.h"
#import "DJUserInfoItemsInfo.h"
#import "DJUpdataUserInfoViewController.h"
#import "DJUserInfoTableViewCell.h"
#import <TikTok_iOS_SDK/TikTok_iOS_SDK.h>

@interface EditUserInfoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) UIView *navigationView;
@property (nonatomic, strong, readwrite) DJUser *myUser;
@property (nonatomic, strong, readwrite) NSArray<DJUserInfoItem *> *infoArray;
@property (nonatomic, strong, readwrite) NSTimer *timer;

@end

@implementation EditUserInfoViewController


#pragma mark - Controller 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        _myUser = [DJUser myInfo];
        _infoArray = (NSArray<DJUserInfoItem *> *)[[DJUserInfoItemsInfo alloc] init];
    }
    return self;
}

#pragma mark - view 加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationItem setTitle:@"个人信息"];
    [self.tabBarController.tabBar setHidden:YES];
    
    [self.view addSubview:({
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   NAVIGATIONFULL_HEIGHT,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT - NAVIGATIONFULL_HEIGHT)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.backgroundColor = WECHAT_BACKGROUND_GREY;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView;
    })];

    [self.tableView reloadData];
}

#pragma mark - view 生命周期结束
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self.tabBarController.tabBar setHidden:NO];
}




#pragma mark - TableView - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.infoArray[indexPath.row].height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DJUserInfoItem *itemInfo  = self.infoArray[indexPath.row];
    DJUpdataUserInfoViewController *updataUserInfoVC = [[DJUpdataUserInfoViewController alloc] initWithItemsInfo:itemInfo];
    [self.navigationController pushViewController:updataUserInfoVC animated:YES];
}





#pragma mark - TableView - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[DJUserInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
        [cell layoutWithInfoItem:self.infoArray[indexPath.row]];
    } else {
        [cell reLayoutWithInfoItem:self.infoArray[indexPath.row]];
    }

    return cell;
}


@end
