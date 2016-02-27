//
//  WBAccount.m
//  我的微博
//
//  Created by wmd on 16/2/21.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBAccount.h"
#import "MJExtension.h"

#define WBAccountTokenKey @"token"
#define WBUidKey @"uid"
#define WBExpiresKey @"expires"
#define WBExpise_dateKey @"date"
#define WBAccount_name @"name"
@implementation WBAccount
//遍历当前类将所有属性归档结档
MJCodingImplementation

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    WBAccount *account = [[self alloc] init];
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}
- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
//计算过期时间 = 当前时间＋有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
    
}
////归档的时候掉用，告诉系统哪个属性要归档，如何归档
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_access_token forKey:WBAccountTokenKey];
//    [aCoder encodeObject:_expires_in forKey:WBExpiresKey];
//    [aCoder encodeObject:_uid forKey:WBUidKey];
//    [aCoder encodeObject:_expires_date forKey:WBExpise_dateKey];
//    [aCoder encodeObject:_name forKey:WBAccount_name];
//}
////解档的时候掉用：告诉系统哪个属性要接档，如何接档
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        _access_token = [aDecoder decodeObjectForKey:WBAccountTokenKey];
//        _uid = [aDecoder decodeObjectForKey:WBUidKey];
//        _expires_in = [aDecoder decodeObjectForKey:WBExpiresKey];
//        _expires_date = [aDecoder decodeObjectForKey:WBExpise_dateKey];
//        _name = [aDecoder decodeObjectForKey:WBAccount_name];
//    }
//    return self;
//}


@end
