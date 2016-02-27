//
//  WBComposeToolBar.h
//  我的微博
//
//  Created by wmd on 16/2/26.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBComposeToolBar;
@protocol WBComposeToolBarDelegate <NSObject>

@optional
- (void) composeToolBar:(WBComposeToolBar *)toolbar didClickBtn:(NSInteger)index;

@end


@interface WBComposeToolBar : UIView

@property (nonatomic,weak) id<WBComposeToolBarDelegate> delegate;
@end
