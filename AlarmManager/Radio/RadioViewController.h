//
//  RadioViewController.h
//  AlarmManager
//
//  Created by vince chao on 15/5/20.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Radio.h"
@interface RadioViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)UILabel *rLabel;
@end
