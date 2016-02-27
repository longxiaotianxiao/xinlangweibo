//
//  WBNewFeatureCell.m
//  我的微博
//
//  Created by wmd on 16/2/21.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBNewFeatureCell.h"
#import "WBTabBarController.h"


@interface WBNewFeatureCell()

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) UIButton *shareButton;
@property (nonatomic,weak) UIButton *startButton;

@end

@implementation WBNewFeatureCell

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
    }
    return _shareButton;
}

- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:(UIControlStateNormal)];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateSelected];
        
        [startBtn sizeToFit];
        [self.contentView addSubview:startBtn];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        _startButton = startBtn;
    }
    
    return _startButton;
}
- (UIImageView *)imageView
{
    if (_imageView==nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
//      tabView和collectView要加载到contView上
        [self.contentView addSubview:imageV];
    }
    return _imageView;
}
//布局子空间的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
//  分享按钮
    self.shareButton.center = CGPointMake(self.width*0.5, self.height*0.8);
//  开始按钮
    self.startButton.center = CGPointMake(self.width*0.5, self.height*0.9);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = _image;
}

//判断当前cell是否时最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count -1) {
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    }else{
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}
//点击开始微博的时候掉用
- (void)start
{
//    进入tabBarVc
    WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
//    切换根控制器：可以直接把之前的根控制器清空
    WBKeyWindow.rootViewController = tabBarVc;
}
@end
