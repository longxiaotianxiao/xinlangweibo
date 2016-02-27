//
//  AppDelegate.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "AppDelegate.h"
#import "WBOAuthViewController.h"
#import "WBAccountTool.h"
#import "WBRootTool.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate ()

@property(nonatomic,strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//  注册通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
//  在真机上后台播放音乐
    AVAudioSession *sessin = [AVAudioSession sharedInstance];
    [sessin setCategory:AVAudioSessionCategoryPlayback error:nil];
    [sessin setActive:YES error:nil];
    
//  创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//判断有没有授权
    if ([WBAccountTool account]) {
        [WBRootTool chooseRootViewController:self.window];
    }else{
        WBOAuthViewController *oauthVc = [[WBOAuthViewController alloc] init];
        self.window.rootViewController = oauthVc;
    }

//  显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

//接收到内存警告的时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
//    停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
//    清楚缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player= [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    player.numberOfLoops = -1;
    
    [player play];
    _player = player;
    
}
#pragma mark - App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
//    开启一个后台任务,时间不确定，优先级比较低
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
//    当后台任务结束时调用
        [application endBackgroundTask:ID];
    }];
//    提高后台任务的优先级，播放音乐
//    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
