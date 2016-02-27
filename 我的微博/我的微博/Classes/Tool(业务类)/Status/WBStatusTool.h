//
//  WBStatusTool.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//  处理微博数据

#import <Foundation/Foundation.h>

@interface WBStatusTool : NSObject
/**
 *  请求更新的微博数据
 *
 *  @param sinceId  <#sinceId description#>
 *  @param sucess   <#sucess description#>
 *  @param failture <#failture description#>
 */
+ (void) newStatusWithSinceId:(NSString *)sinceId sucess:(void(^)(NSArray*statuses))sucess failture:(void(^)(NSError *error))failture;
+ (void)moreStatusWithMaxId:(NSString *)maxId sucess:(void (^)(NSArray *statuses))sucess failture:(void (^)(NSError *error))failture;
@end
