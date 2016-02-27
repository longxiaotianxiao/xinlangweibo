//
//  WBStatusFrame.h
//  我的微博
//
//  Created by wmd on 16/2/23.
//  Copyright © 2016年 wmd. All rights reserved.
//  模型 + 对应控件的frame

#import <Foundation/Foundation.h>

@class WBStatus;
@interface WBStatusFrame : NSObject
/**
 *  微博数据
 */
@property (nonatomic,strong) WBStatus *status;
/**
 *  原创微博
 */
@property (nonatomic,assign) CGRect originalViewFrame;
/**********************原创微博子控件frame**************/
/**
 *  头像frame
 */
@property (nonatomic,assign) CGRect originalIconFrame;
/**
 *  昵称frame
 */
@property (nonatomic,assign) CGRect originalNameFrame;
/**
 *  vipframe
 */
@property (nonatomic,assign) CGRect originalVipFrame;
/**
 *  时间frame
 */
@property (nonatomic,assign) CGRect originalTimeFrame;
/**
 *  来源frame
 */
@property (nonatomic,assign) CGRect originalSourceFrame;
/**
 *  正文frame
 */
@property (nonatomic,assign) CGRect originalTextFrame;
/**
 *  配图frame
 */
@property (nonatomic,assign) CGRect originalPhotosFrame;



/**
 *  转发微博
 */
@property (nonatomic,assign) CGRect retweetViewFrame;
/**********************转发微博子控件frame**************/
/**
 *  昵称frame
 */
@property (nonatomic,assign) CGRect retweetNameFrame;
/**
 *  正文frame
 */
@property (nonatomic,assign) CGRect retweetTextFrame;
/**
 *  工具栏
 */
@property (nonatomic,assign) CGRect toolBarViewFrame;

//cell 高度
@property (nonatomic,assign) CGFloat cellHeight;
/**
 *  配图frame
 */
@property (nonatomic,assign) CGRect retweetPhotosView;
@end
