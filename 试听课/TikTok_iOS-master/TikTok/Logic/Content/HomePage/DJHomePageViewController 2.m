//
//  DJHomePageViewController.m
//  TikTok
//
//  Created by 邓杰 on 2023/8/11.
//

#import "DJHomePageViewController.h"
#import "DJLoginViewController.h"

@interface DJHomePageViewController ()

@end

@implementation DJHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    
    
    
    
    
    
    
}


- (void)addLoginNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLoginController) name:@"login" object:nil];
}


- (void)pushLoginController {
    UINavigationController *loginNC = nil;
    DJLoginViewController *loginVC = [[DJLoginViewController alloc] init];
    loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    loginNC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:loginNC animated:YES completion:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"login" object:nil];
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
