//
//  WBBaseParam.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//  基本的参数模型

#import <Foundation/Foundation.h>

@interface WBBaseParam : NSObject

@property (nonatomic,copy) NSString *access_token;
+ (instancetype)param;

@end
