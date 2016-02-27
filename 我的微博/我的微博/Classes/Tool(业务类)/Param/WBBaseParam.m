//
//  WBBaseParam.m
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBBaseParam.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
@implementation WBBaseParam


+ (instancetype)param
{
    WBBaseParam *param = [[self alloc] init];
    param.access_token = [WBAccountTool account].access_token;
    return param;
}
@end
