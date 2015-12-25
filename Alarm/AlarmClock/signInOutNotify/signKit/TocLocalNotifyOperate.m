//
//  TocLocalNotifyOperate.m
//  ProjectForToc
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "TocLocalNotifyOperate.h"
#import <UIKit/UIKit.h>

@implementation TocLocalNotifyOperate

+ (void)registLocationNotify:(NSDictionary*)notiDic{
    NSString* time = notiDic[@"time"];
    NSString *s2 = [time substringToIndex:6];
    NSString * timer = [NSString stringWithFormat:@"%@01", s2];

    NSString* repeat = notiDic[@"repeat"];
    NSString* alertBody = notiDic[@"body"];
    [self translateData:timer repeat:repeat alertBody:alertBody];
}

+ (void)cancelLocalWithTime:(NSString*)time{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *localArr = [app scheduledLocalNotifications];
    if (localArr) {
        for (UILocalNotification *notiin in localArr) {
            NSDictionary *dict = notiin.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:time]) {
                    [app cancelLocalNotification:notiin];
                }
            }
        }
    }
}

+ (void)cancelAllNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+ (NSArray*)stringToArray:(NSString*)str{
    NSMutableArray* arr = [NSMutableArray arrayWithCapacity:str.length];
    for (int i = 0; i < str.length;i++) {
        [arr addObject:[NSString stringWithFormat:@"%c",[str characterAtIndex:i]]];
    }
    return arr;
}
//添加本地通知
+ (void)translateData:(NSString*)time repeat:(NSString*)repeat alertBody:(NSString*)body{
    NSInteger nowWeek = [self getWeekWithDate:[NSDate date]];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* now = [dateFormatter stringFromDate:[NSDate date]];
    NSString* day = [now componentsSeparatedByString:@" "].firstObject;
    NSString* notiDateStr = [NSString stringWithFormat:@"%@ %@",day,time];
    NSDate* date = [dateFormatter dateFromString:notiDateStr];
    NSDate* notiDate;
    NSString* temp = @"1234560";
    if (repeat.length == 0){
        ///不重复
        notiDate = date;
        //添加通知
        [self addNotification:[notiDate timeIntervalSince1970] withBody:body withKey:time];
    }else{
        //重复
        NSArray* reArray = [self stringToArray:repeat];
        NSInteger nowIndex = [temp rangeOfString:[NSString stringWithFormat:@"%ld",nowWeek]].location;
        for (NSString* weekStr in reArray) {
            NSInteger notiIndex = [temp rangeOfString:weekStr].location;
            //相差天数
            NSInteger num;
            if (nowIndex > notiIndex) {
                num = notiIndex-nowIndex+7;
            }else{
                num = notiIndex-nowIndex;
            }
            //添加通知
            [self addNotification:[date timeIntervalSince1970]+num*24*3600 withBody:body withKey:time];
        }
    }
}
#pragma mark 创建本地通知
+ (void)addNotification:(NSTimeInterval)time withBody:(NSString*)body withKey:(NSString*)key{
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    if (noti) {
        noti.fireDate = [NSDate dateWithTimeIntervalSince1970:time];
        noti.timeZone = [NSTimeZone defaultTimeZone];
        noti.repeatInterval = NSCalendarUnitWeekday;
//        noti.soundName = UILocalNotificationDefaultSoundName;
        NSString *str = [NSString string];
      str = [[NSUserDefaults standardUserDefaults] objectForKey:@"warningTone"];
        if (str == nil) {
            noti.soundName = [NSString stringWithFormat:@"%@.caf", @"起床铃声1"];
        } else {
          noti.soundName = [NSString stringWithFormat:@"%@.caf", str];
        }
        
        noti.alertBody = body;
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:key forKey:@"key"];
        noti.userInfo = infoDic;
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:noti];
    }
}

+ (NSInteger)getWeekWithDate:(NSDate*)date{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    return  [componets weekday];
}
@end
