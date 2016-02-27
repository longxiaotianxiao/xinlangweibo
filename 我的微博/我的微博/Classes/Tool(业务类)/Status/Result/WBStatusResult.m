//
//  WBStatusResult.m
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBStatusResult.h"
#import "WBStatus.h"
@implementation WBStatusResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[WBStatus class]};
}
@end
