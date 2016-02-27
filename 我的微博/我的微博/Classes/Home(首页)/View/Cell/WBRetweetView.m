//
//  WBRetweetView.m
//  我的微博
//
//  Created by wmd on 16/2/23.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBRetweetView.h"
#import "WBStatus.h"
#import "WBStatusFrame.h"
#import "WBPhotosView.h"

@interface WBRetweetView ()

//    昵称
@property (nonatomic,weak) UILabel *nameView;
//    正文
@property (nonatomic,weak) UILabel *textView;
//    配图
@property (nonatomic,weak) WBPhotosView *photosView;

@end
@implementation WBRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //        添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

- (void)setUpAllChildView
{
//    昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = WBNameFont;
    nameView.textColor = [UIColor blueColor];
    [self addSubview:nameView];
    _nameView = nameView;

//    正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = WBTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
//    配图
    WBPhotosView *photosview = [[WBPhotosView alloc] init];
    [self addSubview:photosview];
    _photosView = photosview;
}

- (void)setStatusF:(WBStatusFrame *)statusF
{
    _statusF = statusF;
    WBStatus *status = statusF.status;
//    昵称
    _nameView.frame = statusF.retweetNameFrame;
    _nameView.text = status.retweetName;
//    正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
//    配图
    _photosView.frame = statusF.retweetPhotosView;
    _photosView.pic_urls = status.retweeted_status.pic_urls;
}

@end
