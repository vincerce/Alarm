//
//  HospitalAddressViewController.h
//  BabyLove
//
//  Created by dllo on 15/4/22.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalCity.h"
#import "HospitalProvince.h"

@interface HospitalAddressViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)NSMutableArray *provinceArr;
@property(nonatomic, retain)UITableView *proTableView;
@property(nonatomic, retain)UITableView *cityTableView;
@property(nonatomic, retain)NSMutableArray *proArr;
@property(nonatomic, retain)NSMutableArray *citArr;
@property(nonatomic, assign)NSInteger one;
@property(nonatomic, assign)NSInteger two;
@property (nonatomic, strong)NSMutableArray *array;
@property(nonatomic, copy)void (^block)(NSString *);

@end
