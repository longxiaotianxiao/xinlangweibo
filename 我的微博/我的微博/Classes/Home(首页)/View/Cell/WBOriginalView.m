//
//  WBOriginalView.m
//  我的微博
//
//  Created by wmd on 16/2/23.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBOriginalView.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "UIImageView+WebCache.h"
#import "WBPhotosView.h"
@interface WBOriginalView ()

//    头像
@property (nonatomic,weak) UIImageView *iconView;
//    昵称
@property (nonatomic,weak) UILabel *nameView;
//    vip
@property (nonatomic,weak) UIImageView *vipView;
//    时间
@property (nonatomic,weak) UILabel *timeview;
//    来源
@property (nonatomic,weak) UILabel *sourceView;
//    正文
@property (nonatomic,weak) UILabel *textView;
//    配图
@property (nonatomic,weak) WBPhotosView *photosView;

@end

@implementation WBOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
//        添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
        
    }
    return self;
}

- (void)setUpAllChildView
{
//    头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
//    昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = WBNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
//    vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
//    时间
    UILabel *timeview = [[UILabel alloc] init];
    timeview.font = WBTimeFont;
    timeview.textColor = [UIColor orangeColor];
    [self addSubview:timeview];
    _timeview = timeview;
//    来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = WBSourceFont;
    sourceView.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceView];
    _sourceView = sourceView;
//    正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = WBTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
//   配图
    WBPhotosView *photosView = [[WBPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
}

- (void)setStatusF:(WBStatusFrame *)statusF
{
    _statusF = statusF;
//    设置frame
    [self setUpFrame];
//    设置数据
    [self setUpData];
}

- (void)setUpData
{
    WBStatus *status = _statusF.status;
//    头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
//    vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    
    _vipView.image = [UIImage imageNamed:imageName];
//    时间
    _timeview.text = status.created_at;
//    来源
    _sourceView.text  = status.source;
//    正文
    _textView.text  = status.text;
//    配图
   _photosView.pic_urls = status.pic_urls;
    
    
}
- (void)setUpFrame
{
//    头像
    _iconView.frame = _statusF.originalIconFrame;
//    昵称
    _nameView.frame = _statusF.originalNameFrame;
//    vip
    if (_statusF.status.user.vip) {
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
//    时间
//    由于改了时间格式，所以每次都需要重新计算时间的frame
    
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + WBStatusCellMargin * 0.5;
    CGSize timeSize = [_statusF.status.created_at sizeWithFont:WBTimeFont];
    _timeview.frame = (CGRect){{timeX,timeY},timeSize};
    
//    _timeview.frame = _statusF.originalTimeFrame;
//    来源
    CGFloat sourceX = CGRectGetMaxX(_timeview.frame) + WBStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_statusF.status.source sizeWithFont:WBSourceFont];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
//    _sourceView.frame = _statusF.originalSourceFrame;
//    正文
    _textView.frame = _statusF.originalTextFrame;
//    配图
    _photosView.frame = _statusF.originalPhotosFrame;
}
@end
