//
//  WBUserResult.m
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBUserResult.h"

@implementation WBUserResult

- (int)messageCount
{
    return _cmt +_dm + _mention_cmt + _mention_status;
}

- (int)totalCount
{
    return self.messageCount + _status + _follower;
}
@end
