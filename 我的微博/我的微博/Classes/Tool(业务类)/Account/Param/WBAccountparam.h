//
//  WBAccountparam.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccountparam : NSObject

@property (nonatomic,copy) NSString *client_id;
@property (nonatomic,copy) NSString *client_secret;
@property (nonatomic,copy) NSString *grant_type;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *redirect_uri;

@end
