//
//  WBTextView.m
//  我的微博
//
//  Created by wmd on 16/2/25.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBTextView.h"

@interface WBTextView ()

@property (nonatomic,weak)UILabel *placeHolderLabel;

@end
@implementation WBTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.font = [UIFont systemFontOfSize:13];
    }
    return  self;
}
- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        UILabel *lab = [[UILabel alloc] init];
        
        [self addSubview:lab];
        
        _placeHolderLabel = lab;
    }
    return  _placeHolderLabel;
}
- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.placeHolderLabel.text = placeHolder;
//  lable的尺寸和文字一样
    [self.placeHolderLabel sizeToFit];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = font;
    [self.placeHolderLabel sizeToFit];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}
- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    
    self.placeHolderLabel.hidden = hidePlaceHolder;
    
    
}
@end
