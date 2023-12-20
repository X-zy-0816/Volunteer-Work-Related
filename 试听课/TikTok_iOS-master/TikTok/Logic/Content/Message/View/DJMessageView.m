//
//  DJMessageView.m
//  TikTok
//
//  Created by 邓杰 on 2023/9/25.
//

#import "DJMessageView.h"
#import "DJScreen.h"

#define MESSAGETYPE_COUNT 2

@implementation DJMessageView

- (void)loadMessageView {
    [self setBackgroundColor:[UIColor whiteColor]];
    
    // 加载自定义navigationBar
    self.messageNavBar = [[DJMessageNavBar alloc] initWithFrame:CGRectMake(0, TOPSTATUSBAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_HEIGHT)];
    [self.messageNavBar loadMessageNavBar];
    [self addSubview:self.messageNavBar];
    
    // 加载 rootScrollView
    self.messageScrollView = [[UIScrollView alloc] init];
    [self.messageScrollView setFrame:CGRectMake(0,
                                                NAVIGATIONFULL_HEIGHT,
                                                VIEW_WIDTH(self),
                                                VIEW_HEIGHT(self) - NAVIGATIONFULL_HEIGHT)];
    [self.messageScrollView setContentSize:CGSizeMake(VIEW_WIDTH(self) * MESSAGETYPE_COUNT, VIEW_HEIGHT(self) - NAVIGATIONFULL_HEIGHT)];
    [self.messageScrollView setBounces:NO];
    [self.messageScrollView setPagingEnabled:YES];
    [self.messageScrollView setShowsVerticalScrollIndicator:NO];
    [self.messageScrollView setShowsHorizontalScrollIndicator:NO];
    
    
    // 加载 messageTableView
    self.messageTableViewArray = [NSMutableArray arrayWithCapacity:MESSAGETYPE_COUNT];
    for (int i = 0; i < MESSAGETYPE_COUNT; i++) {
        self.messageTableViewArray[i] = [[DJMessageTableView alloc] initWithFrame:CGRectMake(
                                                   VIEW_WIDTH(self.messageScrollView) * i,
                                                   0,
                                                   VIEW_WIDTH(self.messageScrollView),
                                                   VIEW_HEIGHT(self.messageScrollView))];
        [self.messageTableViewArray[i] loadMessageTableView];
        [self.messageScrollView addSubview:self.messageTableViewArray[i]];
    }
    self.messageTableViewArray[0].backgroundColor = [UIColor greenColor];
    self.messageTableViewArray[1].backgroundColor = [UIColor blueColor];
    [self addSubview:self.messageScrollView];
    
}


@end
