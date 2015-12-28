//
//  TimeView.m
//  AlarmManager
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "TimeView.h"
#import "UIColor_Random.h"
#define WIDTH self.frame.size.width/2
#define HEIGHT self.frame.size.height/2
@implementation TimeView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGAdapter my = [AdapterModel getCGAdapter];
        if (WIDTH == 125) {
            self.timeLabel = [[UILabel alloc] init];
            self.timeLabel.frame = CGRectMake(0, 0, 180 * my.sWidth, 60 * my.sHeight);
            self.timeLabel.center = CGPointMake(WIDTH, HEIGHT);
            self.timeLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.timeLabel];
            self.timeLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:40.0f * my.sWidth];
            
            self.dateLabel = [[UILabel alloc] init];
            self.dateLabel.frame = CGRectMake(0, 0, 180 * my.sWidth, 40 * my.sHeight);
            self.dateLabel.center = CGPointMake(WIDTH, 130 * my.sHeight);
            self.dateLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.dateLabel];
            self.dateLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:25.0f * my.sWidth];
            self.dateLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
            
            
            self.fdTime = [[NSDateFormatter alloc] init];
            [self.fdTime setDateFormat:@"HH:mm"];
            self.fdDate = [[NSDateFormatter alloc] init];
            [self.fdDate setDateFormat:@"yyyy-MM-dd"];
            
            NSDate* now = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
            NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            comps = [calendar components:unitFlags fromDate:now];
            _a = [comps second];
            self.percentLayer.strokeEnd = _a / 60.0;
            
            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
            
            self.weekLabel = [[UILabel alloc] init];
            self.weekLabel.frame = CGRectMake(0, 0, 230 * my.sWidth, 40 * my.sHeight);
            self.weekLabel.center = CGPointMake(WIDTH, 240 * my.sHeight);
            self.weekLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.weekLabel];
            self.weekLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:30.0f * my.sWidth];
            self.weekLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
            
            switch ([comps weekday]) {
                case 1:
                    self.weekLabel.text = @"星期天";
                    break;
                case 2:
                    self.weekLabel.text = @"星期一";
                    break;
                case 3:
                    self.weekLabel.text = @"星期二";
                    break;
                case 4:
                    self.weekLabel.text = @"星期三";
                    break;
                case 5:
                    self.weekLabel.text = @"星期四";
                    break;
                case 6:
                    self.weekLabel.text = @"星期五";
                    break;
                case 7:
                    self.weekLabel.text = @"星期六";
                default:
                    break;
            }

        } else {
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.frame = CGRectMake(0, 0, 230 * my.sWidth, 60 * my.sHeight);
        self.timeLabel.center = CGPointMake(WIDTH, HEIGHT);
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeLabel];
        self.timeLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:50.0f * my.sWidth];
        
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.frame = CGRectMake(0, 0, 230 * my.sWidth, 40 * my.sHeight);
        self.dateLabel.center = CGPointMake(WIDTH, 130 * my.sHeight);
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.dateLabel];
        self.dateLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:30.0f * my.sWidth];
        self.dateLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
        
        
        self.fdTime = [[NSDateFormatter alloc] init];
        [self.fdTime setDateFormat:@"HH:mm"];
        self.fdDate = [[NSDateFormatter alloc] init];
         [self.fdDate setDateFormat:@"yyyy-MM-dd"];
        
        NSDate* now = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:now];
        _a = [comps second];
        self.percentLayer.strokeEnd = _a / 60.0;
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];

        self.weekLabel = [[UILabel alloc] init];
        self.weekLabel.frame = CGRectMake(0, 0, 230 * my.sWidth, 40 * my.sHeight);
        self.weekLabel.center = CGPointMake(WIDTH, 280 * my.sHeight);
        self.weekLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.weekLabel];
        self.weekLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:30.0f * my.sWidth];
        self.weekLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
      
        switch ([comps weekday]) {
            case 1:
                self.weekLabel.text = @"星期天";
                break;
            case 2:
                self.weekLabel.text = @"星期一";
                break;
            case 3:
                self.weekLabel.text = @"星期二";
                break;
            case 4:
                self.weekLabel.text = @"星期三";
                break;
            case 5:
                self.weekLabel.text = @"星期四";
                break;
            case 6:
                self.weekLabel.text = @"星期五";
                break;
            case 7:
                self.weekLabel.text = @"星期六";
            default:
                break;
        }
        
        }
        
        
        self.clockLayer = [CAShapeLayer layer];                            //创建CAShapeLayer
        self.clockLayer.path = [self drawPathWithArcCenter];               //获取贝塞尔曲线
        self.clockLayer.fillColor = [UIColor clearColor].CGColor;          //图形内部颜色
        self.clockLayer.strokeColor = [UIColor colorWithRed:18/255.0 green:135/255.0 blue:183/255.0 alpha:0.8].CGColor; //图形外围颜色
        self.clockLayer.lineWidth = 40;                                    //图形边框宽度
        [self.layer addSublayer:self.clockLayer];
        
        self.percentLayer = [CAShapeLayer layer];                          //创建CAShapeLayer
        self.percentLayer.path = [self drawShortBorderLayerPathWithArcCenter];      //获取贝塞尔曲线
        self.percentLayer.fillColor = [UIColor clearColor].CGColor;        //图形内部颜色
        self.percentLayer.strokeColor = [UIColor clearColor].CGColor;      //图形外围颜色
        self.percentLayer.lineWidth = 35;                                  //图形边框宽度
        [self.layer addSublayer:self.percentLayer];                        //将图形添加到当前类中

    }
    return self;
}
- (void)updateTime
{
    
    self.timeLabel.textColor = [UIColor randomColor];
    self.timeLabel.text = [self.fdTime stringFromDate:[NSDate date]];
    self.dateLabel.text = [self.fdDate stringFromDate:[NSDate date]];
    
        _a++;
    if (_a > 60) {
        _a = 1;
        
    }
    
    self.percentLayer.strokeColor = [UIColor randomColor].CGColor;
    [self startAnimationWithStepCount:_a];
    
}

- (CGPathRef)drawShortBorderLayerPathWithArcCenter
{
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH, HEIGHT - 8)
                                              //设置圆心坐标
        radius:HEIGHT-30                       //设置半径
        startAngle:(-M_PI_2)                   //起始角度
        endAngle:(3*M_PI_2)                    //终点角度
        clockwise:YES].CGPath;
}


#pragma mark - 获取计时器的贝塞尔Path
- (CGPathRef)drawPathWithArcCenter
{
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH, HEIGHT - 8) //设置圆心坐标
                                          radius:HEIGHT-30                  //设置半径
                                      startAngle:(-M_PI_2)                  //起始角度
                                        endAngle:(3*M_PI_2)                 //终点角度
                                       clockwise:YES].CGPath;
}

- (void)startAnimationWithStepCount:(NSInteger)stepCount
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    NSLog(@"%f",self.percentLayer.strokeEnd);
    pathAnimation.duration = 0.0;
    double percent = [self editPercent:stepCount];                                   double lastPercent = [self editStartPercent:stepCount];                      //获得上一个百分比数值
    pathAnimation.fromValue = @(lastPercent);                                    //动画起始值为"上一个百分比数值"
    pathAnimation.toValue = @(percent);                                          //动画终点值为"当前秒数与60秒百分比"
//    NSLog(@"%f,%f",lastPercent,percent);
    pathAnimation.removedOnCompletion = YES;
    [self.percentLayer addAnimation:pathAnimation forKey:nil];
}
#pragma mark - 获取当前步数与计划步数的百分比
-(double)editPercent:(double)stepCount  //stepCount为当前秒数
{
    double precent = 0.0;
    double planStepCount = 60;
    precent = stepCount / planStepCount;                         //计算百分比
    if (precent > 1)                                               {
        self.percentLayer.strokeEnd = 1;
        return 1;
    }
    else     //没达到目标返回值为百分比数值
    {
        self.percentLayer.strokeEnd = precent;
        return precent;
    }
}
#pragma mark - 获取上一个百分比数值
-(double)editStartPercent:(double)stepCount{
    double result = 0.0;
    double planStepCount = 60;      return result = (stepCount - 1)/planStepCount;               }
@end
