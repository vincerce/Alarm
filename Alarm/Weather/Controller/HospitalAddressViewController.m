//
//  WeatherViewController.h
//  AlarmManager
//
//  Created by vince chao on 15/5/23.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "HospitalAddressViewController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface HospitalAddressViewController ()

@end

@implementation HospitalAddressViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.provinceArr = [NSMutableArray array];
        self.array = [NSMutableArray array];
        [self cityData];
    }
    return self;
}

- (void)cityData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"最新省市及id" ofType:@"txt"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *strArr = [str componentsSeparatedByString:@"\n"];
    for (NSString *temp in strArr) {
        if (![temp hasPrefix:@" "]) {
            HospitalProvince *pro = [[HospitalProvince alloc] init];
            pro.name = temp;
            [self.provinceArr addObject:pro];
        }
        else if ([temp hasPrefix:@"  "]) {
            HospitalCity *cit = [[HospitalCity alloc] init];
            cit.name = temp;
            HospitalProvince *pro = [self.provinceArr lastObject];
            [pro.arr addObject:cit];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
    self.proTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH * 0.35, HEIGHT * 0.89) style:UITableViewStylePlain];
    self.proTableView.dataSource = self;
    self.proTableView.delegate = self;
    [self.view addSubview:self.proTableView];
    self.proTableView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
    
    self.cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH * 0.35, 0, WIDTH * 0.65, HEIGHT * 0.89) style:UITableViewStylePlain];
    self.cityTableView.dataSource = self;
    self.cityTableView.delegate = self;
    [self.view addSubview:self.cityTableView];
    self.cityTableView.separatorStyle = NO;
    self.cityTableView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.proTableView) {
        HospitalProvince *pro = self.provinceArr[indexPath.row];
        self.citArr = pro.arr;
        self.one = indexPath.row;
        [self.cityTableView reloadData];
        self.cityTableView.separatorStyle = YES;
    }
    if (tableView == self.cityTableView) {
        HospitalCity *cit = self.citArr[indexPath.row];
        NSScanner *scanner = [NSScanner scannerWithString:cit.name];
        [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
        int number;
        [scanner scanInt:&number];
        NSString *str = [NSString stringWithFormat:@"%03d", number];
        [self.navigationController popViewControllerAnimated:YES];
        
        HospitalProvince *pro = self.provinceArr[self.one];
        HospitalCity *city = pro.arr[indexPath.row];
        NSCharacterSet *cSet = [NSCharacterSet characterSetWithCharactersInString:@" 0123456789"];
        NSString *cityName = [city.name  stringByTrimmingCharactersInSet:cSet];
        self.block(cityName);
//        NSMutableArray *arr = [NSMutableArray array];
//        arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"province"];
//        [arr removeAllObjects];
        [self.array addObject:cityName];
        [self.array addObject:str];
        
[[NSUserDefaults standardUserDefaults] setObject:self.array forKey:@"province"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.proTableView) {
        return self.provinceArr.count;
    }
    else {
        return self.citArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
    }
    if (tableView == self.proTableView) {
        HospitalProvince *pro = self.provinceArr[indexPath.row];
        NSCharacterSet *cSet = [NSCharacterSet characterSetWithCharactersInString:@" 0123456789"];
        NSString *proName = [pro.name  stringByTrimmingCharactersInSet:cSet];
        cell.textLabel.text = proName;
        cell.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    else {
        HospitalProvince *pro = self.provinceArr[self.one];
        HospitalCity *city = pro.arr[indexPath.row];
        NSCharacterSet *cSet = [NSCharacterSet characterSetWithCharactersInString:@" 0123456789"];
        NSString *cityName = [city.name  stringByTrimmingCharactersInSet:cSet];
        cell.textLabel.text = cityName;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;

        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];

        return cell;
    }
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
