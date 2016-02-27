//
//  WBStatusResult.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface WBStatusResult : NSObject <MJCoding>

/**
 *  用户的微博数组
 */
@property (nonatomic,strong) NSArray *statuses;
/**
 *  用户最近微博总数
 */
@property (nonatomic,assign) int total_number;


@end
