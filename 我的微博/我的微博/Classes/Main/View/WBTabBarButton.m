//
//  WBTabBarButton.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBTabBarButton.h"
#import "WBBadgeView.h"

#define WBImageRidio 0.7

@interface WBTabBarButton ()

@property (nonatomic,weak) WBBadgeView *badgeView;

@end
@implementation WBTabBarButton


// 重写setHighLigeted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted{}
//懒加载badgeView
- (WBBadgeView *)badgeView
{
    if (_badgeView == nil) {
        WBBadgeView *btn = [WBBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _badgeView = btn;
    }
    return  _badgeView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//     设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
//      图片剧中
        self.imageView.contentMode = UIViewContentModeCenter;
//      文字局中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//      设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return  self;
}

//传递UITabBarItem给tabBarButton，给tabBarButton内容赋值
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
//  KVO：时刻坚挺一个对象的属性有没有改变
//  给谁添加观察者
//  Obsetver：按钮
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
 
}

//只要坚挺的属性一有新值，就会掉用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    self.badgeView.badgeValue = _item.badgeValue;
}
//修改按钮内部子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    1,imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height *WBImageRidio;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
//    2,Title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
//    3,badgeView
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
    
}
@end
