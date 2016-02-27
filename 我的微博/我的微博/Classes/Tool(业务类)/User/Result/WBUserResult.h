//
//  WBUserResult.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUserResult : NSObject

@property (nonatomic,assign) int status;
@property (nonatomic,assign) int follower;
@property (nonatomic,assign) int cmt;
@property (nonatomic,assign) int dm;
@property (nonatomic,assign) int mention_status;
@property (nonatomic,assign) int mention_cmt;
/**
 *  消息的总和
 *
 *  @return 
 */
- (int) messageCount;
/**
 *  未读消息的总和
 *
 *  @return <#return value description#>
 */
- (int) totalCount;
@end
