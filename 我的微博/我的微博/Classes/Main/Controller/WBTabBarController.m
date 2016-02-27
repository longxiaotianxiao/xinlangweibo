//
//  WBTabBarController.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBTabBarController.h"
#import "WBTabBar.h"
#import "WBHomeViewController.h"
#import "WBMessageViewController.h"
#import "WBDiscoverViewController.h"
#import "WBProfileViewController.h"
#import "WBNavigationController.h"
#import "UIImage+Image.h"
#import "WBUserTool.h"
#import "WBUserResult.h"
#import "WBComposeViewController.h"

@interface WBTabBarController ()<WBTabBarDelegate>
//保存itembars的数组
@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic,weak) WBHomeViewController *home;
@property (nonatomic,weak) WBMessageViewController *message;
@property (nonatomic,weak) WBProfileViewController *profile;

@end

@implementation WBTabBarController

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//  tabBarVc添加管理子控制器
    [self setUpAllChildViewController];
//  自定义tabBar
    [self setupTabBar];
//  每隔一段时间读取未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestunread) userInfo:nil repeats:YES];

}
- (void)requestunread
{
    //  请求微博的未读请求
    [WBUserTool unReadWithSuccess:^(WBUserResult *result) {
        //  设置首页未读书
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        //  设置消息未读书
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        //  设置我的未读数
        _profile.tabBarItem.badgeValue =[NSString stringWithFormat:@"%d",result.follower];
        //  设置应用程序的未读书
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
    } failture:^(NSError *error) {
        
    }];
}
#pragma mark - 设置tabBar
- (void)setupTabBar
{
    //自定义tabBar
    WBTabBar *tabBar = [[WBTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
//   设置代理
    tabBar.delegate = self;
//   给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    [self.tabBar addSubview:tabBar];
}
#pragma mark - 实现tabBar的代理  当点击tabBar上的按钮掉用
- (void)tabBar:(WBTabBar *)tabBar didClickButton:(NSInteger *)index
{
    if (index == 0&& self.selectedIndex == index) {//点击首页刷新
        [_home refresh];
    }
    self.selectedIndex = (NSUInteger)index;
}

- (void)tabBarDidClickPlusButton:(WBTabBar *)tabBar
{
    WBComposeViewController *composeVc = [[WBComposeViewController alloc] init];
    WBNavigationController *naV = [[WBNavigationController alloc] initWithRootViewController:composeVc];
    [self presentViewController:naV animated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 删除系统自带的tabBarButton
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if (![tabBarButton isKindOfClass:[WBTabBar class]]) {
//            [tabBarButton removeFromSuperview];
//        }
//    }
}

#pragma mark - 添加tabBar所有子控制器
- (void)setUpAllChildViewController
{
//  首页
    WBHomeViewController *home = [[WBHomeViewController alloc] init];
    [self setUpOneChildController:home image:[UIImage imageNamed:@"tabbar_home"] imageSelect:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
//  消息
    WBMessageViewController *message = [[WBMessageViewController alloc] init];
    [self setUpOneChildController:message image:[UIImage imageNamed:@"tabbar_message_center"] imageSelect:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;
   
//  发现
    WBDiscoverViewController *discover = [[WBDiscoverViewController alloc] init];
    [self setUpOneChildController:discover image:[UIImage imageNamed:@"tabbar_discover"] imageSelect:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];

    //  我
    WBProfileViewController *profile = [[WBProfileViewController alloc] init];
    [self setUpOneChildController:profile image:[UIImage imageNamed:@"tabbar_profile"] imageSelect:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    _profile = profile;
}

#pragma mark - 添加一饿 子控制器
- (void) setUpOneChildController:(UIViewController *)vc image:(UIImage*)imagedefault imageSelect:(UIImage *)imageSelect title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = imagedefault;
    vc.tabBarItem.selectedImage = imageSelect;
//  保存tabBaritem模型数组
    [self.items addObject:vc.tabBarItem];
//  添加tabbar的子控制器为导航控制器
//  initWithRootViewController底层会掉用push方法，把跟控制器压入栈
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
