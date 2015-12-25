//
//  WeatherView.h
//  AlarmManager
//
//  Created by vince chao on 15/5/23.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView
@property (nonatomic, strong) UIImageView *weatherImage;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *lineview;



@property (nonatomic, strong) UILabel *titleLa;

@property (nonatomic, strong) UILabel * temperatureLa;
@property (nonatomic, strong) UIImageView *temperatureLaView;

@property (nonatomic, strong) UIImageView *weatherim;
@property (nonatomic, strong) UILabel *temperaturel;
@property (nonatomic, strong) UIImageView *temperaturelaView;
@property (nonatomic, strong) UILabel *timeLa;
@property (nonatomic, strong) UILabel *weatherLa;
@property (nonatomic, strong) UILabel *pmLa;
@property (nonatomic, strong) UIView *pmView;

@property (nonatomic, strong) UILabel *wind;
@property (nonatomic, strong) UIImageView *windImage;
@property (nonatomic, strong) UILabel *rays;
@property (nonatomic, strong) UIImageView *raysImage;
@property (nonatomic, strong) UILabel *footLa;

@end
