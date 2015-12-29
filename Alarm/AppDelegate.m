//
//  AppDelegate.m
//  AlarmManager
//
//  Created by vince chao on 15/5/18.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <AudioToolbox/AudioToolbox.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:252 / 255.0 blue:235 / 255.0 alpha:1.0];
    [self.window makeKeyAndVisible];
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        //        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        //        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
    MainViewController *main = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main];
    nav.navigationBar.translucent = NO;
    nav.navigationBar.barTintColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:0.8];
    self.window.rootViewController = nav;
    
    
    return YES;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSString *str = [NSString string];
    
    str = [[NSUserDefaults standardUserDefaults] objectForKey:@"warningTone"];
    if (str == nil) {
        notification.soundName = [NSString stringWithFormat:@"%@.caf", @"起床铃声1"];
    } else {
        notification.soundName = [NSString stringWithFormat:@"%@.caf", str];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"晨起助手提示有您的提醒" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
