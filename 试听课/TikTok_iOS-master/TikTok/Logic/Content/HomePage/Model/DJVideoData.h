//
//  DJVideoData.h
//  TikTok
//
//  Created by 邓杰 on 2023/11/21.
//

#import <Foundation/Foundation.h>
//#import "DJVideoItemInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJVideoItemInfo : NSObject

@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, strong) NSString *videoCoverURL;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *likeNumber;
@property (nonatomic, strong) NSString *commemtNumber;
@property (nonatomic, strong) NSString *favariteNumber;
@property (nonatomic, strong) NSString *transmitNumber;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *describe;

@property (nonatomic) BOOL isLike;
@property (nonatomic) BOOL isFavarite;

@property (nonatomic) BOOL isStorage;
@property (nonatomic, strong) dispatch_semaphore_t dataSemaphore;

@end





@interface DJVideoData : NSObject

+ (NSMutableArray <DJVideoItemInfo *>*)getSimulationVideoData;

+ (void)downloadAndCacheVideo:(NSMutableArray <DJVideoItemInfo *>*)videoArray;

+ (NSURL *)cachedFileURLForVideoURL:(NSString *)videoURLString;

@end

NS_ASSUME_NONNULL_END
