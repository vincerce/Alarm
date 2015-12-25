//
//  WeatherViewController.h
//  AlarmManager
//
//  Created by vince chao on 15/5/23.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherView.h"
#import "HealthWeatherModel.h"
@interface WeatherViewController : UIViewController
@property (nonatomic, strong) HealthWeatherModel *weather;
@property (nonatomic, strong) NSMutableArray *cityId;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong)WeatherView *wView;
@property (nonatomic, strong) UIButton *provinceBt;

@end
