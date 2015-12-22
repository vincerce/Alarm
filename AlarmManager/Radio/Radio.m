//
//  Radio.m
//  redioTest
//
//  Created by vince chao on 15/5/18.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "Radio.h"
#import <AVFoundation/AVFoundation.h>
#import "CyberPlayerController.h"
CyberPlayerController *cbPlayerController;//播放器控制器

@implementation Radio
static Radio *sharedInstance = nil ;

+ (Radio *) sharedInstance
{
    static dispatch_once_t onceToken;// 锁
    dispatch_once (& onceToken, ^ {// 最多调用一次
        sharedInstance = [[self  alloc] init];
    });
    return  sharedInstance;
}

// 当第一次使用这个单例时，会调用这个init方法。
- (id) init
{
    self = [super init];
    
    if (self) {
        //后台播放设置
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        //初始化播放器
        NSString *msAK = @"YAW03Vsfoy8lYGsfTaGyb3A0";
        NSString *msSK = @"AVatCW709q0Ftrq2cZzEoYGLmSwgDUKC";
        [[CyberPlayerController class] setBAEAPIKey:msAK SecretKey:msSK];
        cbPlayerController = [[CyberPlayerController alloc] init];
    }
    
    return self;
}

//设置播放地址
- (void) setRadioUrlString:(NSString *) urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    [cbPlayerController setContentURL:url];
}

//开始播放
- (void) play
{
    switch (cbPlayerController.playbackState) {
        case CBPMoviePlaybackStateStopped:
        case CBPMoviePlaybackStateInterrupted:
            //初始化完成后直接播放视频，不需要调用play方法
            cbPlayerController.shouldAutoplay = YES;
            //初始化视频文件
            [cbPlayerController prepareToPlay];
            
            sharedInstance.isPlayed = YES;
            break;
        default:
            [cbPlayerController prepareToPlay];
            sharedInstance.isPlayed = YES;
            break;
    }
}

//停止播放
- (void) stop
{
    [cbPlayerController stop];
    sharedInstance.isPlayed = NO;
}@end
