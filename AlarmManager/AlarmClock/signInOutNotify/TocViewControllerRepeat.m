//
//  TocViewControllerRepeat.m
//  ProjectForToc
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "TocViewControllerRepeat.h"

@interface TocViewControllerRepeat (){
    __weak IBOutlet UITableView*                _tableView;
    __weak IBOutlet UIView*                     _buttonsView;
    
    
    NSArray*                    _array;
    NSString*                   _selectTime;
}

@end

@implementation TocViewControllerRepeat

- (instancetype)init{
    self = [super initWithNibName:@"TocViewControllerRepeat" bundle:nil];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _array = @[@"每天",@"工作日",@"周末"];
        _selectTime = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.bounces = NO;
    NSArray* times = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat width = (CGRectGetWidth(_buttonsView.frame)-6)/times.count;
    for (int i = 0; i < times.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        btn.frame = CGRectMake((width+1)*i, 0, width, CGRectGetHeight(_buttonsView.frame));
        [btn setTitle:times[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:200/255.0 green:1.0 blue:210/255.0 alpha:1.0];
        [btn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonsView addSubview:btn];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)selectDate:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _selectTime = [NSString stringWithFormat:@"%@%ld",_selectTime,btn.tag];
        btn.backgroundColor = [UIColor colorWithRed:200/255.0 green:228/255.0 blue:247/255.0 alpha:1.0];
    }else{
        _selectTime = [_selectTime stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%ld",btn.tag] withString:@""];
        btn.backgroundColor = [UIColor colorWithRed:200/255.0 green:1.0 blue:210/255.0 alpha:1.0];
    }
    [[NSUserDefaults standardUserDefaults] setObject:_selectTime forKey:REPEATTIMEKEY];
}

#pragma mark UITableViewDelegate UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* repeatCellIdent = @"repeatClockCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:repeatCellIdent];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:repeatCellIdent];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.text = _array[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cache;
    switch (indexPath.row) {
        case 0:
            cache = @"0123456";
            break;
        case 1:
            cache = @"12345";
            break;
        case 2:
            cache = @"06";
            break;
            
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] setObject:cache forKey:REPEATTIMEKEY];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
