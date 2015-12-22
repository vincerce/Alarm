//
//  MainViewController.h
//  AlarmManager
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPStackMenu.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>
@interface MainViewController : UIViewController<UPStackMenuDelegate>
{
    
    AVCaptureDevice *device;
     NSInteger flag;
}

@property(nonatomic, retain)CMMotionManager *manager;

@property (nonatomic, strong)UILabel *timeLabel;
@end
