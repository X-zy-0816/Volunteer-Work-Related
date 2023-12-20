//
//  DJVideoData.m
//  TikTok
//
//  Created by 邓杰 on 2023/11/21.
//

#import "DJVideoData.h"

@implementation DJVideoItemInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataSemaphore = dispatch_semaphore_create(0);
        _isStorage = NO;
    }
    return self;
}
@end


@implementation DJVideoData

+ (NSMutableArray <DJVideoItemInfo *>*)getSimulationVideoData {
    NSMutableArray <DJVideoItemInfo *>*videoInfoArray = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        DJVideoItemInfo *videoInfo = [[DJVideoItemInfo alloc] init];
        videoInfo.videoCoverURL = @"bg10";
        videoInfo.likeNumber = @"4214";
        videoInfo.favariteNumber = @"124";
        videoInfo.commemtNumber = @"8194";
        videoInfo.transmitNumber = @"63";
        videoInfo.describe = @"今天天气不错呢，这是我的第一条视频";

        [videoInfoArray addObject:videoInfo];
    }
    videoInfoArray[0].userName = @"@小羊";
    videoInfoArray[1].userName = @"@小猪";
    videoInfoArray[2].userName = @"@猪猪侠";
    videoInfoArray[3].userName = @"@张三";
    videoInfoArray[4].userName = @"@李四";
    videoInfoArray[5].userName = @"@加多宝";
    videoInfoArray[6].userName = @"@王老五";
    videoInfoArray[7].userName = @"@王老吉";
    videoInfoArray[8].userName = @"@怡宝";
    videoInfoArray[9].userName = @"@康师傅";
    
    videoInfoArray[0].avatarURL = @"head1";
    videoInfoArray[1].avatarURL = @"head2";
    videoInfoArray[2].avatarURL = @"head3";
    videoInfoArray[3].avatarURL = @"head4";
    videoInfoArray[4].avatarURL = @"head5";
    videoInfoArray[5].avatarURL = @"head6";
    videoInfoArray[6].avatarURL = @"head7";
    videoInfoArray[7].avatarURL = @"head8";
    videoInfoArray[8].avatarURL = @"head9";
    videoInfoArray[9].avatarURL = @"head10";

    
    
    //videoInfoArray[0].videoURL = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
//    videoInfoArray[1].videoURL = @"https://media.w3.org/2010/05/sintel/trailer.mp4";
//    videoInfoArray[2].videoURL = @"https://prod-streaming-video-msn-com.akamaized.net/0b927d99-e38a-4f51-8d1a-598fd4d6ee97/3493c85c-f35a-488f-9a8f-633e747fb141.mp4";
    videoInfoArray[0].videoURL = @"https://media.w3.org/2010/05/sintel/trailer.mp4";
//    videoInfoArray[4].videoURL = @"http://www.w3school.com.cn/example/html5/mov_bbb.mp4";
//    videoInfoArray[5].videoURL = @"http://vfx.mtime.cn/Video/2021/07/10/mp4/210710122716702150.mp4";
//    videoInfoArray[6].videoURL = @"http://vfx.mtime.cn/Video/2021/07/10/mp4/210710095541348171.mp4";
//    videoInfoArray[7].videoURL = @"http://vfx.mtime.cn/Video/2021/07/10/mp4/210710094507540173.mp4";
//    videoInfoArray[8].videoURL = @"http://vjs.zencdn.net/v/oceans.mp4";
//    videoInfoArray[9].videoURL = @"http://www.w3school.com.cn/example/html5/mov_bbb.mp4";
    
    
    videoInfoArray[1].videoURL = @"https://www.w3schools.com/html/movie.mp4";
    videoInfoArray[2].videoURL = @"https://media.w3.org/2010/05/sintel/trailer.mp4";
    videoInfoArray[3].videoURL = @"https://www.w3schools.com/html/movie.mp4";
    videoInfoArray[4].videoURL = @"https://www.w3schools.com/html/movie.mp4";
    videoInfoArray[5].videoURL = @"https://www.w3schools.com/html/movie.mp4";
    videoInfoArray[6].videoURL = @"https://www.w3schools.com/html/movie.mp4";
    videoInfoArray[7].videoURL = @"https://www.w3schools.com/html/movie.mp4";
    videoInfoArray[8].videoURL = @"https://www.w3schools.com/html/movie.mp4";
    videoInfoArray[9].videoURL = @"https://www.w3schools.com/html/movie.mp4";

    return videoInfoArray;
}


+ (void)downloadAndCacheVideo:(NSMutableArray <DJVideoItemInfo *>*)videoArray {
    // 创建 NSURLCache，指定缓存大小和路径
       NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    for (int i = 0; i < videoArray.count; i++) {
        // 视频URL作为视频路径标识符
        NSString *videoCachePath = [cachePath stringByAppendingPathComponent:videoArray[i].videoURL];
        // 为了确保目录存在，创建它
        //[[NSFileManager defaultManager] createDirectoryAtPath:videoCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        // 初始化 NSURLCache，设置为全局共享缓存对象
        NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:videoCachePath];
        [NSURLCache setSharedURLCache:urlCache];
        // 视频地址
        NSURL *videoURL = [NSURL URLWithString:videoArray[i].videoURL];
        // 创建一个 URL 会话
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        // 创建下载任务
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:videoURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"Error downloading video: %@", error);
                return;
            }
            
            // 将文件移动到缓存目录
            NSError *moveError;
            // 示例：删除目标文件
//            NSError *removeError;
//            if (![[NSFileManager defaultManager] removeItemAtURL:[DJVideoData cachedFileURLForVideoURL:videoArray[i].videoURL] error:&removeError]) {
//                NSLog(@"Error removing existing file: %@", removeError);
//            }
            
            if (![[NSFileManager defaultManager] moveItemAtURL:location toURL:[DJVideoData cachedFileURLForVideoURL:videoArray[i].avatarURL] error:&moveError]) {
                NSLog(@"Error moving downloaded file: %@", moveError);
                /// return;
            }
            
            // 告诉播放段资源以准备好
            videoArray[i].isStorage = YES;
            dispatch_semaphore_signal(videoArray[i].dataSemaphore);
        }];
        
        // 启动下载任务
        [downloadTask resume];
    }
    

}


+ (NSURL *)cachedFileURLForVideoURL:(NSString *)videoURLString {
    NSURL *videoURL = [NSURL URLWithString:videoURLString];
    // 获取缓存目录
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *cachedFilePath = [[cachePath stringByAppendingPathComponent:videoURLString] stringByAppendingString:@".mp4"];
    
    // 返回文件 URL
    return [NSURL fileURLWithPath:cachedFilePath];
}


@end
