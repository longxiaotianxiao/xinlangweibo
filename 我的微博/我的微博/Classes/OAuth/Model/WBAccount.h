//
//  WBAccount.h
//  我的微博
//
//  Created by wmd on 16/2/21.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject<NSCoding>
/*
 *获取数据的访问命令牌
 */
@property(nonatomic,copy) NSString *access_token;
/*
 *账号的有效期
 */
@property(nonatomic,copy) NSString *expires_in;
/*
 *用户唯一标识符
 */
@property(nonatomic,copy) NSString *uid;
/**
 *  昵称
 */
@property (nonatomic,copy) NSString *name;

//帐号过期时间
@property (nonatomic,strong)NSDate *expires_date;
@property(nonatomic,copy) NSString *remind_in;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
