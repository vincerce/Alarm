//
//  TocViewControllerAutoSign.m
//  ProjectForToc
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//



#import "TocViewControllerAutoSign.h"
#import "TocSignClockCell.h"
#import "TocViewControllerAddClock.h"
#import "TocLocalNotifyOperate.h"

@interface TocViewControllerAutoSign ()<UITableViewDataSource,UITableViewDelegate,TocSignClockCellAgent>{
    __weak IBOutlet UITableView*                _tableView;
    __weak IBOutlet UILabel*                    _nullLabel;
    
    
    NSMutableArray*                             _dataArray;
}




@end

@implementation TocViewControllerAutoSign

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNotifity)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    NSMutableArray* arr = [[NSUserDefaults standardUserDefaults] objectForKey:CLOCKKEY];
    if (arr) {
        _tableView.hidden = NO;
        _nullLabel.hidden = YES;
        
            _dataArray = [NSMutableArray arrayWithArray:arr];
        
        [_tableView reloadData];
    }else{
        _tableView.hidden = YES;
        _nullLabel.center = self.view.center;
    }
}

#pragma mark 添加提醒
- (void)addNotifity{
    TocViewControllerAddClock* addColock = [[TocViewControllerAddClock alloc] init];
    [self.navigationController pushViewController:addColock animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate UITableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary* dic = _dataArray[indexPath.row];
        [TocLocalNotifyOperate cancelLocalWithTime:dic[@"time"]];
        [_dataArray removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [[NSUserDefaults standardUserDefaults] setObject:_dataArray forKey:CLOCKKEY];
        [_tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* signCellIdent = @"signClockCell";
    TocSignClockCell* cell = [tableView dequeueReusableCellWithIdentifier:signCellIdent];
    if (!cell) {
        cell = [[TocSignClockCell alloc] initWithReuseIdentifier:signCellIdent cellIndex:indexPath.row];
    }
    cell.agent = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(TocSignClockCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic = _dataArray[indexPath.row];
    NSString* time = dic[@"time"];
    NSArray* arr = [time componentsSeparatedByString:@":"];
    NSInteger hour = [arr[0] integerValue];
    if (hour > 12) {
        NSString* timeStr = [NSString stringWithFormat:@"%ld:%@:00 %@",hour-12,arr[1],@"PM"];
        cell.time = timeStr;
    }else{
        NSString* timeStr = [NSString stringWithFormat:@"%ld:%@:00 %@",hour,arr[1],@"AM"];
        cell.time = timeStr;
    }
    
    
    if ([@"1" isEqualToString:dic[@"state"]]) {
        cell.isOn = YES;
    }else{
        cell.isOn = NO;
    }
    cell.reason = dic[@"body"];
}
//#warning !!!!!!!!!!!!!!!!!!!
#pragma mark TocSignClockCellAgent
- (void)touchOnSwitch:(BOOL)isOn withIndex:(NSInteger)index{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:_dataArray[index]];

    if (isOn) {
        [dic setObject:@"1" forKey:@"state"];
        [TocLocalNotifyOperate registLocationNotify:dic];
    }else{
        [dic setObject:@"0" forKey:@"state"];
        [TocLocalNotifyOperate cancelLocalWithTime:dic[@"time"]];
    }
    [_dataArray replaceObjectAtIndex:index withObject:dic];
    
    [[NSUserDefaults standardUserDefaults] setObject:_dataArray forKey:CLOCKKEY];
//    [_tableView reloadData];
}
@end
