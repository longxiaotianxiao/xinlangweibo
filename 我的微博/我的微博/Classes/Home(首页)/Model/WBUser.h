//
//  WBUser.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject
/*
 *微博昵称
 */
@property(nonatomic,copy)NSString *name;
/*
 *微博头像
 */
@property(nonatomic,copy)NSString *profile_image_url;

@property (nonatomic,assign) int mbtype;
@property (nonatomic,assign) int mbrank;

@property (nonatomic,assign,getter=isVip) BOOL vip;

@end
