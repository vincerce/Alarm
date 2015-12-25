//
//  WeatherViewController.m
//  AlarmManager
//
//  Created by vince chao on 15/5/23.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "WeatherViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Colortransform.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface WeatherViewController ()

@end

@implementation WeatherViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.weather.element = [NSMutableArray array];
        self.weather = [[HealthWeatherModel alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableArray *province = [NSMutableArray array];
    province = [[NSUserDefaults standardUserDefaults] objectForKey:@"province"];
    if (province.count == 0) {
        [self loadInformationCityId:@"001"];
    } else {
        
        [self loadInformationCityId:province[1]];
    }
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            {
                NSLog(@"没有网络(断网)");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前没有网络可用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
                
                break;
        }
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            {
                NSLog(@"手机自带网络");
                //调用解析数据
                
                //判断城市文件路径是否存在
                if (province.count == 0) {
                    [self loadInformationCityId:@"001"];
                } else {
                    
                    [self loadInformationCityId:province[1]];
                }
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
            {
                NSLog(@"WIFI");
                //调用解析数据
                //读取本地存储城市信息 进行判断
                if (province.count == 0) {
                    [self loadInformationCityId:@"001"];
                } else {
                    
                    [self loadInformationCityId:province[1]];
                }
            }
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];

    
}
- (void)viewWillAppear:(BOOL)animated
{
    
}
- (void)loadInformationCityId: (NSString *)cityId
{

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    //    NSLog(@"天气%@，城市%@，年龄%@",weatherId,cityId,ageId);
    NSString *str = [NSString stringWithFormat:WEATHER, cityId];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSMutableDictionary *dic = [responseObject objectForKey:@"weatherinfo"];
                 [self.weather setValuesForKeysWithDictionary:dic];
                 self.weather.element = dic[@"element"];
             self.wView = [[WeatherView alloc] initWithFrame:self.view.bounds];
             [self.view addSubview:self.wView];
        
         //天气背景图片
         NSURL *url = [NSURL URLWithString:self.weather.bgimg];
         [self.wView.weatherImage sd_setImageWithURL:url];
         //天气时间
         self.wView.titleLa.text = [NSString stringWithFormat:@"%@", self.weather.date];
                 
         //实时温度
         self.wView.temperatureLa.text = self.weather.zstemp;
         self.wView.temperatureLaView.image = [UIImage imageNamed:@"温度"];
         //天气图片
         NSURL *url1 = [NSURL URLWithString:self.weather.weatherimg];
         [self.wView.weatherim  sd_setImageWithURL:url1];
         //今日气温
         self.wView.temperaturel.text = self.weather.temp;
         //
         self.wView.temperaturelaView.image = [UIImage imageNamed:@"温度"];
         //
         //更新时间
         self.wView.timeLa.text = self.weather.last;
         //天气信息
         self.wView.weatherLa.text = self.weather.weather;
         //风向图片
        self.wView.windImage.image = [UIImage imageNamed:@"风"];
         ////紫外线图标
        self.wView.raysImage.image = [UIImage imageNamed:@"紫外线"];
         
         //PM 2.5
         self.wView.pmLa.text = [NSString stringWithFormat:@" %@  %@ %@", self.weather.element[0][@"key"], self.weather.element[0][@"value"], self.weather.element[0][@"content"]];
        
         //pm显示
         self.wView.pmView.backgroundColor = [Colortransform colorWithHexString:self.weather.element[0][@"color"]];
         //风向
         self.wView.wind.text = [NSString stringWithFormat:@" %@%@  %@",self.weather.element[3][@"key"], self.weather.element[3][@"value"], self.weather.element[3][@"content"]];
         //紫外线强度
         self.wView.rays.text = [NSString stringWithFormat:@" %@%@   %@", self.weather.element[2][@"key"], self.weather.element[2][@"value"], self.weather.element[2][@"content"]];
        
         
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"%@", error);
     }
     ];

    
    
    
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
