//
//  WBComposeTool.m
//  我的微博
//
//  Created by wmd on 16/2/26.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBComposeTool.h"
#import "WBHttpTool.h"
#import "WBComposeParam.h"
#import "MJExtension.h"


@implementation WBComposeTool


+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failture:(void (^)(NSError *))failture
{
    WBComposeParam *param = [WBComposeParam param];
    param.status = status;
    
    [WBHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failture) {
            failture(error);
        }
    }];
}
@end
