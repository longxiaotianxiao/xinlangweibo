//
//  WBHttpTool.h
//  我的微博
//
//  Created by wmd on 16/2/22.
//  Copyright © 2016年 wmd. All rights reserved.
//  处理网络请求

#import <Foundation/Foundation.h>

@interface WBHttpTool : NSObject

//get方法
/**
 *  get请求
 *  不需要返回值
 *  @param URLString  请求的基本url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;
//get方法
/**
 *  post请求
 *  不需要返回值
 *  @param URLString  请求的基本url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

@end
