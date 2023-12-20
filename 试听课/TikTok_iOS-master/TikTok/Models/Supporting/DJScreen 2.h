//
//  DJScreen.h
//  TikTok
//
//  Created by 邓杰 on 2023/8/11.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef DJScreen_h
#define DJScreen_h

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define VIEW_X(View)            (View.frame.origin.x)
#define VIEW_Y(View)            (View.frame.origin.y)
#define VIEW_WIDTH(View)        (View.frame.size.width)
#define VIEW_HEIGHT(View)       (View.frame.size.height)



// 顶部高度
#define STATUSBARHEIGHT 22 // 还要注意statusBar下面的navigationBar的高度:44
#define NAVIGATIONBARHEIGHT (44)
#define STATUS_NAVIGATION_BAR_HEIGHT (STATUSBARHEIGHT + NAVIGATIONBARHEIGHT)  // 上面的整体高度

// 底部高度
#define SAFEDISTANCEBOTTOM safeDistanceBottom()
#define TABBARHEIGHT (49)
#define SAFEDISTANCE_TABBAR_HEIGHT (SAFEDISTANCEBOTTOM + TABBARHEIGHT)  // 下面的整体高度

#define UI(x) UIAdapter(x)
#define UIRect(x, y, width, height) UIRectAdapter(x, y, width, height)


// Mine 组件中
#define TOPVIEW_HEIGHT (400 + STATUS_NAVIGATION_BAR_HEIGHT)
#define BACKGROUND_ONE_HEIGHT 450
#define BACKGROUND_TWO_HEIGHT (TOPVIEW_HEIGHT - 75 - BACKGROUND_TWO_Y + STATUS_NAVIGATION_BAR_HEIGHT)
#define BACKGROUND_TWO_Y (BACKGROUND_ONE_HEIGHT - 42)



#endif /* DJScreen_h */
