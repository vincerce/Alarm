//
//  TocSignClockCell.m
//  ProjectForToc
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "TocSignClockCell.h"

@interface TocSignClockCell(){
    __weak IBOutlet UILabel*                _timeLabel;
    __weak IBOutlet UILabel*                _reasonLabel;
    __weak IBOutlet UISwitch*               _switch;
    
    
    NSInteger                               _index;
}
@end

@implementation TocSignClockCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellIndex:(NSInteger)index{
    self = [[NSBundle mainBundle] loadNibNamed:@"TocSignClockCell" owner:self options:nil][0];
    if (self) {
        _index = index;
    }
    return self;
}

- (void)setIsOn:(BOOL)isOn{
    _isOn = isOn;
    [_switch setOn:_isOn animated:YES];
}

- (void)setTime:(NSString *)time{
    _time = time;
    _timeLabel.text = _time;
}

- (void)setReason:(NSString *)reason{
    _reason = reason;
    _reasonLabel.text = _reason;
}

- (IBAction)touchOnOff:(UISwitch*)switchBtn{
    if ([_agent respondsToSelector:@selector(touchOnSwitch:withIndex:)]) {
        [_agent touchOnSwitch:switchBtn.on withIndex:_index];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
