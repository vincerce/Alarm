//
//  OurController.m
//  AlarmManager
//
//  Created by vince chao on 15/5/26.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "OurController.h"

@interface OurController ()

@end

@implementation OurController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Our"]];
    background.frame = self.view.frame;
    [self.view addSubview:background];

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
