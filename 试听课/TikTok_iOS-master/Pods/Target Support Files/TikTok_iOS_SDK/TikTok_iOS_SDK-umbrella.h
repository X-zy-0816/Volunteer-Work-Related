#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DJConfig.h"
#import "DJConstants.h"
#import "DJConversation.h"
#import "DJTikTokDelegate.h"
#import "DJUser.h"
#import "TikTok_iOS_SDK.h"

FOUNDATION_EXPORT double TikTok_iOS_SDKVersionNumber;
FOUNDATION_EXPORT const unsigned char TikTok_iOS_SDKVersionString[];

