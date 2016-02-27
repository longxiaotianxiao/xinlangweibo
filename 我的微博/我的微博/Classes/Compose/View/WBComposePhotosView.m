//
//  WBComposePhotosView.m
//  我的微博
//
//  Created by wmd on 16/2/26.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBComposePhotosView.h"

@implementation WBComposePhotosView

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

//没添加一个子控件的时候调用，如果在viewdidload里面添加子控件不会调用
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat margin = 10;
    CGFloat wh = (self.width - (cols - 1) * margin)/cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (margin + wh);
        y = (row-1) * (margin + wh);
        
        imageV.frame = CGRectMake(x, y, wh, wh);
    }
}
@end
