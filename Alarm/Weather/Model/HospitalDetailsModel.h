//
//  HospitalDetailsModel.h
//  BabyLove
//
//  Created by dllo on 15/4/23.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HospitalDetailsModel : NSObject
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *address;
@property(nonatomic, copy)NSString *intro;
//经度
@property(nonatomic, copy)NSString *longitude;
//纬度
@property(nonatomic, copy)NSString *latitude;

@end
