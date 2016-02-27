//
//  WBRootTool.m
//  我的微博
//
//  Created by wmd on 16/2/21.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBRootTool.h"
#import "WBTabBarController.h"
#import "WBNewFeatureController.h"

#define WBVersionKey @"version"
@implementation WBRootTool
+ (void)chooseRootViewController:(UIWindow *)window
{
    //  获取当前版本号
    NSString *currentVision = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //  获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:WBVersionKey];
    //  判断当前是否有新版本
        if ([currentVision isEqualToString:lastVersion]) {//没有新的版本号
            //  创建tabBarVc
            WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
            //  设置窗口的根控制器
            window.rootViewController = tabBarVc;
    
        }else{//有新的版本号
            //  加载新特性
            WBNewFeatureController *vc = [[WBNewFeatureController alloc] init];
            window.rootViewController = vc;
            //   保存当前版本到偏好设置
            //   1，不需要关心文件名 2，快速进行键值对的存储
            [[NSUserDefaults standardUserDefaults] setObject:currentVision forKey:WBVersionKey];
    }
}


@end
