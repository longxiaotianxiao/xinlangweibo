//
//  WBUserTool.m
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBUserTool.h"
#import "WBHttpTool.h"
#import "WBUserParam.h"
#import "WBUserResult.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "MJExtension.h"
#import "WBUser.h"
@implementation WBUserTool

+ (void)unReadWithSuccess:(void (^)(WBUserResult *))success failture:(void (^)(NSError *))failture
{
//  创建参数模型
    WBUserParam *param = [WBUserParam param];
    param.uid = [WBAccountTool account].uid;
    
    [WBHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
//        字典转模型
        WBUserResult *result = [WBUserResult objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failture) {
            failture(error);
        }
    }];
}


+ (void)userInfoWithSuccess:(void (^)(WBUser *))success failture:(void (^)(NSError *))failture
{
    //  创建参数模型
    WBUserParam *param = [WBUserParam param];
    param.uid = [WBAccountTool account].uid;
    
    [WBHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        //        字典转模型
        WBUser *user = [WBUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failture) {
            failture(error);
        }
    }];}
@end
