//
//  TocAddClockCell.h
//  ProjectForToc
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TocAddClockCell : UITableViewCell

@property (nonatomic, strong) NSString*         clockTitle;
@property (nonatomic, strong) NSString*         message;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
