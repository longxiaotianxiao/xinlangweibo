//
//  WBAccountTool.h
//  我的微博
//
//  Created by wmd on 16/2/21.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBAccount;
@interface WBAccountTool : NSObject

+ (void)saveAccount:(WBAccount *)account;
+ (WBAccount *)account;
+ (void)accountWithCode:(NSString *)code success:(void(^)())sucess failture:(void(^)(NSError *erroe))failture;
@end
