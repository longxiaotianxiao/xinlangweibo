//
//  WBUserTool.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBUserResult;
@class WBUser;
@interface WBUserTool : NSObject
/**
 *   请求用户未读
 *
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
+ (void)unReadWithSuccess:(void(^)(WBUserResult *result))success failture:(void(^)(NSError *error))failture;
/**
 *  请求用户信息
 *
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
+ (void)userInfoWithSuccess:(void(^)(WBUser *user))success failture:(void(^)(NSError *error))failture;
@end
