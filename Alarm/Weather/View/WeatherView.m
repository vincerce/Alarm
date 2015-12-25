//
//  WeatherView.m
//  AlarmManager
//
//  Created by vince chao on 15/5/23.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "WeatherView.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
@implementation WeatherView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.weatherImage = [[UIImageView alloc] init];
        [self addSubview:self.weatherImage];
        self.backView = [[UIView alloc] init];
        [self.weatherImage addSubview:self.backView];
        self.backView.backgroundColor = [UIColor blackColor];
        self.backView.alpha = 0.4;
        
        self.lineView = [[UIView alloc] init];
        [self.weatherImage addSubview:self.lineView];
        self.lineView.backgroundColor = [UIColor whiteColor];
        
        self.lineview = [[UIView alloc] init];
        [self.weatherImage addSubview:self.lineview];
        self.lineview.backgroundColor = [UIColor whiteColor];
        
        
        self.titleLa = [[UILabel alloc] init];
        [self.weatherImage addSubview:self.titleLa];
        self.titleLa.backgroundColor = [UIColor clearColor];
        self.titleLa.textColor = [UIColor whiteColor];
        self.titleLa.font = [UIFont systemFontOfSize:20];
        self.titleLa.textAlignment = NSTextAlignmentCenter;
        
        self.temperatureLa = [[UILabel alloc] init];
        [self.weatherImage addSubview:self.temperatureLa];
        self.temperatureLa.textColor = [UIColor whiteColor];
        self.temperatureLa.font = [UIFont systemFontOfSize:40];
        self.temperatureLaView = [[UIImageView alloc] init];
        [self.temperatureLa addSubview:self.temperatureLaView];
        
        self.weatherim = [[UIImageView alloc] init];
        [self.weatherImage addSubview:self.weatherim];
        
        self.temperaturel = [[UILabel alloc] init];
        [self.weatherImage addSubview:self.temperaturel];
        self.temperaturel.textColor = [UIColor whiteColor];
        self.temperaturelaView = [[UIImageView alloc] init];
        [self.temperaturel addSubview:self.temperaturelaView];
        self.temperaturel.font = [UIFont systemFontOfSize:15];
        
        
        self.timeLa = [[UILabel alloc] init];
        [self.weatherImage addSubview:self.timeLa];
        self.timeLa.textColor = [UIColor whiteColor];
        self.timeLa.numberOfLines = 2;
        self.timeLa.font = [UIFont systemFontOfSize:11];
        
        self.weatherLa = [[UILabel alloc] init];
        [self.weatherImage addSubview:self.weatherLa];
        self.weatherLa.textColor = [UIColor whiteColor];
        self.weatherLa.font = [UIFont systemFontOfSize:17];
        
        self.pmLa = [[UILabel alloc] init];
        [self.weatherImage addSubview:self.pmLa];
        self.pmLa.textAlignment = NSTextAlignmentCenter;
        self.pmLa.numberOfLines = 2;
        self.pmLa.font = [UIFont systemFontOfSize:17];
        self.pmLa.layer.borderWidth = 1;
        self.pmLa.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.pmLa.layer.cornerRadius = 10;
        self.pmLa.textColor = [UIColor whiteColor];
        self.pmView = [[UIView alloc] init];
        [self.pmLa addSubview:self.pmView];
        
        self.wind = [[UILabel alloc] init];
        [self.weatherImage addSubview:self.wind];
        self.wind.textAlignment = NSTextAlignmentCenter;
        self.wind.numberOfLines = 3;
        self.wind.font = [UIFont systemFontOfSize:20];
        self.wind.textColor = [UIColor whiteColor];
        
        self.windImage = [[UIImageView alloc] init];
        [self.weatherImage addSubview:self.windImage];
        
        self.rays = [[UILabel alloc] init];
        [self.weatherImage addSubview:self.rays];
        self.rays.textAlignment = NSTextAlignmentCenter;
        self.rays.numberOfLines = 4;
        self.rays.font = [UIFont systemFontOfSize:20];
        self.rays.textColor = [UIColor whiteColor];
        
        self.raysImage = [[UIImageView alloc] init];
        [self.weatherImage addSubview:self.raysImage];
        
        
        self.weatherImage.frame = self.bounds;
        self.backView.frame = self.weatherImage.bounds;
        self.lineView.frame = CGRectMake(0, HEIGHT / 6, WIDTH, 1);
        self.lineview.frame = CGRectMake(0, HEIGHT / 1.7, WIDTH / 3 * 1.95, 1);
        self.titleLa.frame = CGRectMake(0, HEIGHT / 18, WIDTH, HEIGHT / 10);
        
        
     
        
        //    NSLog(@"w = %f h = %f", WIDTH, HEIGHT);
        self.temperatureLa.frame = CGRectMake(WIDTH / 18.75, HEIGHT / 5, WIDTH / 4.69, HEIGHT / 3.75);
        self.temperatureLaView.frame = CGRectMake(self.temperatureLa.frame.size.width / 2, 0, self.temperatureLa.frame.size.width / 1.8, self.temperatureLa.frame.size.height / 1.8);
        self.temperaturel.frame = CGRectMake(WIDTH / 3.41, HEIGHT / 4.29, WIDTH / 4.68, HEIGHT / 10);
        self.temperaturelaView.frame = CGRectMake(self.temperaturel.frame.size.width / 1.6, 0, self.temperaturel.frame.size.width / 2.67, self.temperaturel.frame.size.height);
        self.timeLa.frame = CGRectMake(WIDTH / 1.97, HEIGHT / 4.29, WIDTH / 6.25, HEIGHT / 7);
        
        self.weatherim.frame = CGRectMake(WIDTH / 3.41, HEIGHT / 2.73, WIDTH / 9.375, HEIGHT / 7.5);
        self.weatherLa.frame = CGRectMake(WIDTH / 2.34, HEIGHT / 2.73, WIDTH / 4.5, HEIGHT / 7.5);
        
        self.pmLa.frame = CGRectMake(WIDTH / 1.5, HEIGHT / 5, WIDTH / 3.41, HEIGHT / 3.75);
        self.pmView.frame = CGRectMake(self.pmLa.frame.size.width / 10, self.pmLa.frame.size.height / 10, self.pmLa.frame.size.width * 0.8, 2);
        
        
        
        
        self.wind.frame = CGRectMake(WIDTH / 6.4, HEIGHT / 1.675, WIDTH / 3.1, HEIGHT / 2);
//        self.wind.backgroundColor = [UIColor redColor];
        self.windImage.frame = CGRectMake(WIDTH / 24, HEIGHT / 1.375, WIDTH / 9.375, HEIGHT / 7.5);
//        self.windImage.backgroundColor = [UIColor redColor];

        self.rays.frame = CGRectMake(WIDTH / 1.5, HEIGHT / 1.675, WIDTH / 3.1, HEIGHT / 2);
//        self.rays.backgroundColor = [UIColor redColor];

        self.raysImage.frame = CGRectMake(WIDTH / 1.8, HEIGHT / 1.375, WIDTH / 9.375, HEIGHT / 7.5);
//        self.raysImage.backgroundColor = [UIColor redColor];


        
    }
    return self;
}
@end
