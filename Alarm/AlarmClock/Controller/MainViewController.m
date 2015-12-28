//
//  MainViewController.m
//  AlarmManager
//
//  Created by vince chao on 15/5/19.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "MainViewController.h"
#import "TimeView.h"
#import "UIColor_Random.h"
#import "UIViewController+KNSemiModal.h"
#import "MineViewController.h"
#import "RadioViewController.h"
#import "TocViewControllerAutoSign.h"
#import "TocLocalNotifyOperate.h"
#import "WeatherViewController.h"
#import "HospitalAddressViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface MainViewController (){
    UIView *contentView;
    UPStackMenu *stack;
    
}

@property (nonatomic, strong)TimeView *clockView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *first = [NSString string];
    first = [[NSUserDefaults standardUserDefaults] objectForKey:@"first"];
    
    if (first == nil) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请您在设置-通知中,开启本软件通知以便我们为您提供闹钟服务\n本软件在前台运行能够提供消息提醒，后台或锁屏状态根据用户的提示音提醒用户" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
       
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"first"];
    flag = 0;
    //AVCaptureDevice代表抽象的硬件设备
    // 找到一个合适的AVCaptureDevice
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![device hasTorch]) {//判断是否有闪光灯
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前设备没有闪光灯，不能提供手电筒功能" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alter show];
    }
    
    self.manager = [[CMMotionManager alloc] init];
    UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BGI"]];
    background.frame = self.view.frame;
    [self.view addSubview:background];
    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.9];
    [self createClockView];
    [self createMenuView];
    [self createFlashlight];
    [self createProvince];
}
#pragma mark 创建手电筒
- (void)createFlashlight
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"手电" style:UIBarButtonItemStylePlain target:self action:@selector(flashlight:)];
}
#pragma mark 省市按钮
- (void)createProvince
{
    NSMutableArray *province = [NSMutableArray array];
    province = [[NSUserDefaults standardUserDefaults] objectForKey:@"province"];
    
    if (province == nil) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:UIBarButtonItemStylePlain target:self action:@selector(Provinceclick:)];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:province[0] style:UIBarButtonItemStylePlain target:self action:@selector(Provinceclick:)];
        
    }
}

- (void)Provinceclick: (id)sender
{
    
    HospitalAddressViewController *hosAddress = [[HospitalAddressViewController alloc] init];
    void (^block)(NSString *) = ^(NSString *name) {
                self.navigationItem.rightBarButtonItem.title = name;
       
    };
    hosAddress.block = block;
    [self.navigationController pushViewController:hosAddress animated:YES];

}

- (void)flashlight: (id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否通过晃动手机开关手电" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开启",@"关闭", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        self.manager.accelerometerUpdateInterval = 0.5;
        [self.manager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            double x = pow(accelerometerData.acceleration.x, 2.0);
            double y = pow(accelerometerData.acceleration.y, 2.0);
            double z = pow(accelerometerData.acceleration.z, 2.0);
            double acc = sqrt(x + y + z);
            
            if (acc > 1.5 && flag == 0) {
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOn];
                [device unlockForConfiguration];
                flag = 1;
            } else if(acc > 1.5 && flag == 1)
            {
                [device lockForConfiguration:nil];
                [device setTorchMode: AVCaptureTorchModeOff];
                [device unlockForConfiguration];
                flag = 0;
            }
        }];

    } else {
        [self.manager stopAccelerometerUpdates];
    }
}
#pragma mark 创建电子表
- (void)createClockView
{
    if (WIDTH < 320)
    {
         self.clockView = [[TimeView alloc]initWithFrame:CGRectMake(0, 0, 250, 250)];
        self.clockView.center = CGPointMake(WIDTH / 2, 120);
    }
    else
    {
    self.clockView = [[TimeView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
    }
//    NSLog(@"%f", WIDTH);
    [self.view addSubview:self.clockView];
}
#pragma mark 创建菜单
- (void)createMenuView
{
    CGAdapter my = [AdapterModel getCGAdapter];
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50 * my.sWidth, 50 * my.sHeight)];
    [contentView setBackgroundColor:[UIColor colorWithRed:112./255. green:47./255. blue:168./255. alpha:1.]];
    [contentView.layer setCornerRadius:6.];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross"]];
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setFrame:CGRectInset(contentView.frame, 10 * my.sWidth, 10 * my.sHeight)];
    [contentView addSubview:icon];
    if(stack)
        [stack removeFromSuperview];
    
    stack = [[UPStackMenu alloc] initWithContentView:contentView];
    
    stack.center = CGPointMake(WIDTH / 2, HEIGHT * 0.83);
    CGRect stackViewFrame = [stack frame];
    stackViewFrame.size = CGSizeMake(WIDTH * my.sWidth,  HEIGHT / 3);
    
    [stack setDelegate:self];
    
    UPStackMenuItem *squareItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"square"] highlightedImage:nil title:@"我的"];
    UPStackMenuItem *circleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"circle"] highlightedImage:nil title:@"天气"];
    UPStackMenuItem *triangleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"triangle"] highlightedImage:nil title:@"网络电台"];
    UPStackMenuItem *crossItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"cross"] highlightedImage:nil title:@"添加闹钟"];
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:squareItem, circleItem, triangleItem, crossItem, nil];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitleColor:[UIColor whiteColor]];
    }];
    
    [stack setAnimationType:UPStackMenuAnimationType_progressiveInverse];
    [stack setStackPosition:UPStackMenuStackPosition_up];
    [stack setOpenAnimationDuration:.4];
    [stack setCloseAnimationDuration:.4];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        if(idx%2 == 0)
            [item setLabelPosition:UPStackMenuItemLabelPosition_left];
        else
            [item setLabelPosition:UPStackMenuItemLabelPosition_right];
    }];
    
    [stack addItems:items];
    [self.view addSubview:stack];
    
    [self setStackIconClosed:YES];
}


- (void)setStackIconClosed:(BOOL)closed
{
    UIImageView *icon = [[contentView subviews] objectAtIndex:0];
    float angle = closed ? 0 : (M_PI * (135) / 180.0);
    [UIView animateWithDuration:0.3 animations:^{
        [icon.layer setAffineTransform:CGAffineTransformRotate(CGAffineTransformIdentity, angle)];
    }];
}

- (void)stackMenuWillOpen:(UPStackMenu *)menu
{
    if([[contentView subviews] count] == 0)
        return;
    
    [self setStackIconClosed:NO];
}

- (void)stackMenuWillClose:(UPStackMenu *)menu
{
    if([[contentView subviews] count] == 0)
        return;
    
    [self setStackIconClosed:YES];
}

- (void)stackMenu:(UPStackMenu *)menu didTouchItem:(UPStackMenuItem *)item atIndex:(NSUInteger)index
{
    TocViewControllerAutoSign* autoSign = [[TocViewControllerAutoSign alloc] init];
    WeatherViewController *weather = [[WeatherViewController alloc] init];
    RadioViewController *radio = [[RadioViewController alloc] init];
     MineViewController *mine = [[MineViewController alloc] init];
//    NSLog(@"%ld", index);
    switch (index) {
        case 0:
            [self.navigationController pushViewController:mine animated:YES];
            break;
          case 1:
            weather.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.5);
            [self presentSemiViewController:weather withOptions:@{
                                                                   KNSemiModalOptionKeys.pushParentBack    : @(YES),
                                                                   KNSemiModalOptionKeys.animationDuration : @(0.5),
                                                                   KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                   }];
            break;
            case 2:
            [self.navigationController pushViewController:radio animated:YES];
            break;
            case 3:
           
            [self.navigationController pushViewController:autoSign animated:YES];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
