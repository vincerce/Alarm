//
//  TocLocalNotifyOperate.h
//  ProjectForToc
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TocLocalNotifyOperate : NSObject


+ (void)registLocationNotify:(NSDictionary*)notiDic;
+ (void)cancelLocalWithTime:(NSString*)time;
+ (void)cancelAllNotification;
@end
