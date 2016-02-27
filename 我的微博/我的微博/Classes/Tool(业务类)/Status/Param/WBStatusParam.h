//
//  WBStatusParam.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>

//参照接口文档的参数列表
@interface WBStatusParam : NSObject

@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,copy) NSString *since_id;
@property (nonatomic,copy) NSString *max_id;

@end
