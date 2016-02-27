//
//  WBUserParam.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBBaseParam.h"
@interface WBUserParam : WBBaseParam

/**
 *  当前用户的唯一标示
 */
@property (nonatomic,copy) NSString *uid;

@end
