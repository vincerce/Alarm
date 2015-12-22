//
//  MineViewController.m
//  AlarmManager
//
//  Created by vince chao on 15/5/20.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "MineViewController.h"

#import "MBProgressHUD.h"
#import "OurController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface MineViewController ()


@end

@implementation MineViewController


- (void)setView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = HEIGHT * 0.14993;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
    [self setView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
        cell.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
        cell.selectionStyle = NO;

    }
    if (indexPath.row == 0) {
        
        NSString *modelPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSString *cashesPath = [NSString stringWithFormat:@"%@/Caches", modelPath];
        cell.textLabel.text = [NSString stringWithFormat:@"清理缓存(%.2fM)", [self floatWithPath:cashesPath]];
        return cell;
    } else  if (indexPath.row == 1) {
        cell.textLabel.text = @"版权声明";
        return cell;
    }
    else {
        cell.textLabel.text = @"关于我们";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认清除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alertView show];
    } else if (indexPath.row == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版权声明" message:@"本软件（晨起助手）所有内容，包括文字、图片、音频、等均在网上搜集。访问者可将本软件提供的内容或服务用于个人学习、研究或欣赏，以及其他非商业性或非盈利性用途，但同时应遵守著作权法及其他相关法律的规定，不得侵犯本软件及相关权利人的合法权利。除此以外，将本软件任何内容或服务用于其他用途时，须征得本软件及相关权利人的书面许可，并支付报酬。本软件内容原作者如不愿意在本软件刊登内容，请及时通知本人，予以删除。\n电子邮箱：389798849@qq.com" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else if (indexPath.row == 2) {
        OurController *our = [[OurController alloc] init];
        [self.navigationController pushViewController:our animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex) {
        alertView.hidden = YES;
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        NSString *modelPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        //        NSString *cashesPath = [NSString stringWithFormat:@"%@/Caches", modelPath];
        [self removeCache];
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}

// 删除缓存
- (void)removeCache
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    NSLog(@"%@", cachePath);
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *p in files) {
        NSString *path = [NSString stringWithFormat:@"%@/%@", cachePath, p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
    }
}
// 计算清除的缓存大小
- (CGFloat)floatWithPath:(NSString *)path
{
    CGFloat num = 0;
    NSFileManager *man = [NSFileManager defaultManager];
    if ([man fileExistsAtPath:path]) {
        NSEnumerator *childFile = [[man subpathsAtPath:path] objectEnumerator];
        NSString *fileName;
        while ((fileName = [childFile nextObject]) != nil) {
            NSString *fileSub = [path stringByAppendingPathComponent:fileName];
            num += [self fileSizeAtPath:fileSub];
        }
    }
    return num / (1024.0 * 1024.0);
}

//计算单个文件大小
- (long long)fileSizeAtPath:(NSString *)file
{
    NSFileManager *man = [NSFileManager defaultManager];
    if ([man fileExistsAtPath:file]) {
        return [[man attributesOfItemAtPath:file error:nil] fileSize];
    }
    return 0;
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
