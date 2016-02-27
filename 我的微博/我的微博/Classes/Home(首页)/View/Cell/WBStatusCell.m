//
//  WBStatusCell.m
//  我的微博
//
//  Created by wmd on 16/2/23.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBOriginalView.h"
#import "WBRetweetView.h"
#import "WBStatusToolBar.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
@interface WBStatusCell ()

@property (nonatomic,weak) WBOriginalView *originalView;
@property (nonatomic,weak) WBRetweetView *retweetView;
@property (nonatomic,weak) WBStatusToolBar *statusToolBar;

@end
@implementation WBStatusCell

//cell时用initWithStyle初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//      添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return  self;
}
#pragma mark - 添加所有子控件
- (void)setUpAllChildView
{
//    原创微博
    WBOriginalView *originalView = [[WBOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
//    转发微博
    WBRetweetView *retweetView = [[WBRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
//    工具条
    WBStatusToolBar *statusToolBar = [[WBStatusToolBar alloc] init];
    [self addSubview:statusToolBar];
    _statusToolBar = statusToolBar;
    
    
}

+ (instancetype)cellWithtabView:(UITableView *)tableView
{
    static NSString *ID= @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;
}

- (void)setStatusF:(WBStatusFrame *)statusF
{
    _statusF = statusF;
//    设置原创微博frame
    _originalView.frame = statusF.originalViewFrame;
    _originalView.statusF = statusF;
//    设置转发微博的frame
    if (statusF.status.retweeted_status) {
        _retweetView.frame = statusF.retweetViewFrame;
        _retweetView.statusF = statusF;
        _retweetView.hidden = NO;
    }else{
        _retweetView.hidden = YES;
    }
 
//    设置工具条的frame
    _statusToolBar.frame = statusF.toolBarViewFrame;
    _statusToolBar.status = statusF.status;
}

@end
