//
//  DJRegisterViewController.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/14.
//

#import "DJRegisterViewController.h"
#import "DJRegisterView.h"
#import "DJScreen.h"

@interface DJRegisterViewController ()
@property(nonatomic, strong) DJRegisterView *registerView;

@end

@implementation DJRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.registerView = [[DJRegisterView alloc] init];
    [self.registerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.registerView loadRegisterView];
    [self.view addSubview:self.registerView];
    
    
    [self.registerView.registerBtn addTarget:self action:@selector(registerFunc) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)registerFunc {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
