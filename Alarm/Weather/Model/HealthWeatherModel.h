//
//  WeatherViewController.h
//  AlarmManager
//
//  Created by vince chao on 15/5/23.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthWeatherModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *weatherimg;
@property (nonatomic, copy) NSString *temp;
@property (nonatomic, copy) NSString *zstemp;
@property (nonatomic, retain) NSMutableArray *element;
@property (nonatomic, copy) NSString *tip;
@property (nonatomic, copy) NSString *bgimg;
@property (nonatomic, copy) NSString *last;
@end
