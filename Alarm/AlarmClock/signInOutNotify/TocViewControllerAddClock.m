//
//  TocViewControllerAddClock.m
//  ProjectForToc
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "TocViewControllerAddClock.h"
#import "TocAddClockCell.h"
#import "TocViewControllerRepeat.h"
#import "TocLocalNotifyOperate.h"

@interface TocViewControllerAddClock ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    __weak IBOutlet UIDatePicker*           _dataPicker;
    __weak IBOutlet UITableView*            _tableView;
    
    NSMutableArray*                         _messageArray;
    NSArray*                                _titleArray;
    NSString*                               _repeat;
    NSString*                               _alertBody;
}

@end

@implementation TocViewControllerAddClock

- (instancetype)init{
    self = [super initWithNibName:@"TocViewControllerAddClock" bundle:nil];
    if (self) {
        _messageArray = [NSMutableArray arrayWithObjects:@"无",@"提醒信息",@"提醒声", nil];
        _titleArray = @[@"重复",@"备注",@"声音"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"闹钟";
    _tableView.bounces = NO;
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClock)];
    
    }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _repeat = [[NSUserDefaults standardUserDefaults] objectForKey:REPEATTIMEKEY];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:REPEATTIMEKEY];
    if (_repeat.length >0) {
        [_messageArray replaceObjectAtIndex:0 withObject:@""];
    }else{
        _repeat = @"";
        [_messageArray replaceObjectAtIndex:0 withObject:@"无"];
    }
    [_tableView reloadData];
}

#pragma mark 保存提醒
- (void)saveClock{
    NSDate* date = _dataPicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:currentDateStr forKey:@"time"];
    [dic setObject:_repeat forKey:@"repeat"];
    [dic setObject:_alertBody.length == 0 ? @"提醒信息" : _alertBody forKey:@"body"];
    [dic setObject:@"1" forKey:@"state"];
    NSArray* arr = [[NSUserDefaults standardUserDefaults] objectForKey:CLOCKKEY];
    NSMutableArray* muArray;
    if (arr) {
        muArray = [NSMutableArray arrayWithArray:arr];
    }else{
        muArray = [NSMutableArray array];
    }
    [muArray addObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:muArray forKey:CLOCKKEY];
    [TocLocalNotifyOperate registLocationNotify:dic];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDelegate UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messageArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* addCellIdent = @"addClockCell";
    TocAddClockCell* cell = [tableView dequeueReusableCellWithIdentifier:addCellIdent];
    if (!cell) {
        cell = [[TocAddClockCell alloc] initWithReuseIdentifier:addCellIdent];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(TocAddClockCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.clockTitle = _titleArray[indexPath.row];
    cell.message = _messageArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            TocViewControllerRepeat* repeat = [[TocViewControllerRepeat alloc] init];
            [self.navigationController pushViewController:repeat animated:YES];
        }
            break;
            
            case 1:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改备注" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.tag = 1;
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert show];
        }
            break;
            case 2:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示音" message:@"请选择" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", @"起床铃声1",@"起床铃声2", @"起床铃声3", nil];
            alert.tag = 2;
            [alert show];
        }
        default:
            break;
    }
}

#pragma mark UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (alertView.tag) {
        case 1:
            if (buttonIndex == 1) {
                UITextField* textField = [alertView textFieldAtIndex:0];
                _alertBody = textField.text;
                if (!_alertBody) {
                    _alertBody = @"提醒信息";
                }
                [_messageArray replaceObjectAtIndex:1 withObject:_alertBody];
                [_tableView reloadData];
            }
            break;
            case 2:
            
            switch (buttonIndex) {
                case 2:
                    [[NSUserDefaults standardUserDefaults] setObject:@"起床铃声1" forKey:@"warningTone"];
                    break;
            case 3:
                    [[NSUserDefaults standardUserDefaults] setObject:@"起床铃声2" forKey:@"warningTone"];
           case 4:
                    [[NSUserDefaults standardUserDefaults] setObject:@"起床铃声3" forKey:@"warningTone"];
                default:
                    break;
            }
//            NSLog(@"%ld", buttonIndex);
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
