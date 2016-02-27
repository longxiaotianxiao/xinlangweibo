//
//  WBComposeTool.h
//  我的微博
//
//  Created by wmd on 16/2/26.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBComposeTool : NSObject

+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failture:(void(^)(NSError *error))failture;

@end
