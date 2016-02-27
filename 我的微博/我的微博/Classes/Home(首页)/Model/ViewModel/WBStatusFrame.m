//
//  CZStatusFrame.m
//  传智微博
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"



@implementation WBStatusFrame

- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = WbScreenW;
    CGFloat toolBarH = 35;
    _toolBarViewFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarViewFrame);
    
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    // 头像
    CGFloat imageX = WBStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + WBStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:WBNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + WBStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + WBStatusCellMargin;
    
    CGFloat textW = WbScreenW - 2 * WBStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:WBTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + WBStatusCellMargin;
    
    // 配图
    if (_status.pic_urls.count) {
        CGFloat photosX = WBStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + WBStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + WBStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = WbScreenW;
    
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}
#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * WBStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * WBStatusCellMargin;
    
    
    return CGSizeMake(w, h);
    
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = WBStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweetName sizeWithFont:WBNameFont];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + WBStatusCellMargin;
    
    CGFloat textW = WbScreenW - 2 * WBStatusCellMargin;
    // 注意：一定要是转发微博的正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:WBTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + WBStatusCellMargin;
    // 配图
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = WBStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + WBStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        
        _retweetPhotosView = (CGRect){{photosX,photosY},photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosView) + WBStatusCellMargin;
    }
    
    // 转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = WbScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}
@end
