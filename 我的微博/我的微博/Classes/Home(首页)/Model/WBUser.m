//
//  WBUser.m
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = _mbtype > 2;
}

@end
