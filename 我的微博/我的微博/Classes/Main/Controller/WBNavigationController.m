//
//  WBNavigationController.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBNavigationController.h"
#import "UIBarButtonItem+Item.h"
#import "WBTabBar.h"
@interface WBNavigationController()<UINavigationControllerDelegate>

@property (nonatomic,strong)id popDelegate;
@end
@implementation WBNavigationController

+ (void)initialize
{
//    获取当前类的UIBarButtonItem 修改系统默认选中时的蓝色背景字体
    UIBarButtonItem * item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
////   设置不可用
//    titleAttr =  [NSMutableDictionary dictionary];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    [item setTitleTextAttributes:titleAttr forState:UIControlStateDisabled];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//  保存
    _popDelegate =self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
}
// 导航控制器跳转完成时跳用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {//显示根控制器
//      恢复滑动手势代理
        self.interactivePopGestureRecognizer.delegate =nil;
        
    }else{
       // 清空滑动返回手势的代理，就能实现滑动功能
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }
}
//导航控制器即将掉出新的控制器时掉用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[WBTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//  拦截NavigationController的push消息
    if (self.childViewControllers.count) {
//      使其push一个view时隐藏底部导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        
//      设置导航栏左边和右边
//      覆盖系统的返回按钮，滑动返回被禁用
//      左边
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = left;
 //     右边
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = right;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backToPre
{
    [self popViewControllerAnimated:YES];
}
- (void)backToRoot
{
    [self popToRootViewControllerAnimated:YES];
}



@end
