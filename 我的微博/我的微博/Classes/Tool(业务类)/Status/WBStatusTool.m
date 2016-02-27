//
//  WBStatusTool.m
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBStatusTool.h"
#import "WBHttpTool.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBStatus.h"
#import "WBStatusParam.h"
#import "WBStatusResult.h"
@implementation WBStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId sucess:(void (^)(NSArray *))sucess failture:(void (^)(NSError *))failture
{
//  创建参数模型
    WBStatusParam *param =[[WBStatusParam alloc] init];
    param.access_token = [WBAccountTool account].access_token;
   
    if (sinceId) {
       param.since_id = sinceId;
    }
    
    [WBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject){
        
        //   将获取的数据转换成模型
        //        NSLog(@"%@",responseObject);
        //   获取微博的字典数组
        WBStatusResult *result = [WBStatusResult objectWithKeyValues:responseObject];
       if (sucess) {
            sucess(result.statuses);
        }
    }failure:^(NSError *error) {
        if (failture) {
            failture(error);
        }
    }];
}
+ (void)moreStatusWithMaxId:(NSString *)maxId sucess:(void (^)(NSArray *))sucess failture:(void (^)(NSError *))failture
{
    WBStatusParam *param = [[WBStatusParam alloc] init];
    param.access_token = [WBAccountTool account].access_token;
    if (maxId) {
        param.max_id = maxId;
    }
    
    [WBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject){
        
        //   将获取的数据转换成模型
        //        NSLog(@"%@",responseObject);
        //   获取微博的字典数组
        WBStatusResult *result = [WBStatusResult objectWithKeyValues:responseObject];
        if (sucess) {
            sucess(result.statuses);
        }
    }failure:^(NSError *error) {
        if (failture) {
            failture(error);
        }
    }];
}

@end
