//
//  TocSignClockCell.h
//  ProjectForToc
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TocSignClockCellAgent <NSObject>

- (void)touchOnSwitch:(BOOL)isOn withIndex:(NSInteger)index;

@end


@interface TocSignClockCell : UITableViewCell

@property (nonatomic,strong) NSString*                  time;
@property (nonatomic,strong) NSString*                  reason;
@property (nonatomic,assign) BOOL                       isOn;
@property (nonatomic,assign) id<TocSignClockCellAgent>  agent;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellIndex:(NSInteger)index;
@end


