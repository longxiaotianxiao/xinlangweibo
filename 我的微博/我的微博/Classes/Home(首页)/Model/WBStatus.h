//
//  WBStatus.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUser.h"
#import "MJExtension.h"
@interface WBStatus : NSObject <MJKeyValue>

/**
 *  转发的微博
 */
@property(nonatomic,strong)WBStatus*retweeted_status;
@property(nonatomic,copy)NSString *retweetName;
/**
 *  用户
 */
@property(nonatomic,strong)WBUser*user;
/*
 微博创建时间
 */
@property(nonatomic,copy)NSString *created_at;
/*
 字符串型的微博ID
 */
@property(nonatomic,copy)NSString *idstr;
/*
 微博信息内容
 */
@property(nonatomic,copy)NSString *text;
/*
 *微博来源
 */
@property(nonatomic,copy)NSString *source;
/*
 *转发数
 */
@property(nonatomic,assign)int reposts_count;
/*
 *评论数
 */
@property(nonatomic,assign)int comments_count;
/*
 *表态数
 */
@property(nonatomic,assign)int attitudes_count;
/*
 *配图数组（配图模型）
 */
@property(nonatomic,strong) NSArray*pic_urls;


@end
