//
//  WBTabBar.h
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabBar;
@protocol WBTabBarDelegate <NSObject>

@optional
- (void)tabBar:(WBTabBar *)tabBar didClickButton:(NSInteger *)index;
/**
 *  点击加号按钮时调用
 *
 *  @param tabBar <#tabBar description#>
 *  @param index  <#index description#>
 */
- (void)tabBarDidClickPlusButton:(WBTabBar *)tabBar;

@end

@interface WBTabBar : UIView

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,weak) id<WBTabBarDelegate>delegate;

@end
