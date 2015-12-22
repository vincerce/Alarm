//
//  TocAddClockCell.m
//  ProjectForToc
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "TocAddClockCell.h"

@interface TocAddClockCell(){
    __weak IBOutlet UILabel*             _clockLabel;
    __weak IBOutlet UILabel*             _messageLabel;
}
@end

@implementation TocAddClockCell


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [[NSBundle mainBundle] loadNibNamed:@"TocAddClockCell" owner:self options:nil][0];
    if (self) {
        
    }
    return self;
}

- (void)setClockTitle:(NSString *)clockTitle{
    _clockTitle = clockTitle;
    _clockLabel.text = _clockTitle;
}

- (void)setMessage:(NSString *)message{
    _message = message;
    _messageLabel.text = _message;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
