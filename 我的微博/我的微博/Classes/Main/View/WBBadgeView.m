//
//  WBBadgeView.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBBadgeView.h"

#define WBBadgeViewFont [UIFont systemFontOfSize:11]
@implementation WBBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
   if(self = [super initWithFrame:frame])
    {
        
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        
//        设置字体
        self.titleLabel.font = WBBadgeViewFont;
        [self sizeToFit];
    }
    return  self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
//    判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    CGSize size = [badgeValue sizeWithFont:WBBadgeViewFont];
    
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}
@end
