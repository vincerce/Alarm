//
//  Radio.h
//  redioTest
//
//  Created by vince chao on 15/5/18.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Radio : NSObject
@property (nonatomic,assign) BOOL isPlayed;//是否已经播放状态值

+ (Radio *) sharedInstance;//单例
- (void) setRadioUrlString:(NSString *) urlString;//设置播放地址
- (void) play;//开始播放
- (void) stop;//停止播放
@end
