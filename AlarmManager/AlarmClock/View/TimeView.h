//
//  TimeView.h
//  AlarmManager
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView
{
    NSInteger _a;
}
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong) UILabel *weekLabel;

@property (nonatomic, strong)NSDateFormatter * fdTime;
@property (nonatomic, strong)NSDateFormatter * fdDate;
@property(nonatomic,retain)CAShapeLayer *clockLayer;
@property(nonatomic,retain)CAShapeLayer *percentLayer;
- (void)startAnimationWithStepCount:(NSInteger)stepCount;
@end
