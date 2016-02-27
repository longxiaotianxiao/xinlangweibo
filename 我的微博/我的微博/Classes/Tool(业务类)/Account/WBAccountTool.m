//
//  WBAccountTool.m
//  我的微博
//
//  Created by wmd on 16/2/21.
//  Copyright © 2016年 wmd. All rights reserved.
//  专门处理帐号的业务

#import "WBAccountTool.h"
#import "WBAccount.h"
#import "AFNetworking.h"
#import "WBHttpTool.h"
#import "WBAccountparam.h"
#import "MJExtension.h"
#define WBAccount_file [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]   stringByAppendingPathComponent:@"account.data"]



@implementation WBAccountTool
//类方法中用静态变量代替成员属性
static WBAccount *_account;

+ (void)saveAccount:(WBAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:WBAccount_file];
}

+(WBAccount *)account
{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:WBAccount_file];
//  判断是否过期
        if ([[NSDate date]compare:_account.expires_date] !=NSOrderedAscending) {
            return nil;
        }
        
    }
//  当前时间＝ 当前保存时间＋有效期
    return _account;
}
+ (void)accountWithCode:(NSString *)code success:(void (^)())sucess failture:(void (^)(NSError *))failture
{
    WBAccountparam *param = [[WBAccountparam alloc] init];
    param.client_id = WBclient_id;
    param.client_secret = WBClient_secret;
    param.code = code;
    param.grant_type = @"authorization_code";
    param.redirect_uri = WBredirect_uri;
    
//  发送请求
    [WBHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues  success:^(id responseObject) {
        WBAccount *account = [WBAccount accountWithDict:responseObject];
        //      保存账号信息
         [WBAccountTool saveAccount:account];
        if (sucess) {
            sucess();
        }
        
    } failure:^(NSError *error) {
        if (failture) {
            failture(error);
        }
    }];  
 }
@end
