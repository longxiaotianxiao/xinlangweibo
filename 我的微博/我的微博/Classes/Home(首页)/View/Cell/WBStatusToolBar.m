//
//  WBStatusToolBar.m
//  我的微博
//
//  Created by wmd on 16/2/23.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBStatusToolBar.h"
#import "WBStatus.h"
@interface WBStatusToolBar ()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSMutableArray *divideVs;
@property (nonatomic,weak) UIButton *retweet;
@property (nonatomic,weak) UIButton *comment;
@property (nonatomic,weak) UIButton *unlike;

@end
@implementation WBStatusToolBar

- (NSMutableArray *)divideVs
{
    if (_divideVs == nil) {
        _divideVs = [NSMutableArray array];
    }
    return  _divideVs;
}
- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
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
//    转发
    UIButton *retweet = [self setOneButtonWithTile:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet = retweet;
//    评论
    UIButton *comment = [self setOneButtonWithTile:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
//    赞
    UIButton *unlike = [self setOneButtonWithTile:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlike = unlike;
    for (int i = 0; i < 2; i++) {
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.divideVs addObject:divideV];
    }
}

- (UIButton *) setOneButtonWithTile:(NSString *)title image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
}
-(void)layoutSubviews
{
    NSUInteger count = self.btns.count;
//    设置按钮的frame
    CGFloat w = WbScreenW /count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.btns[i];
        x = i*w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    int i = 1;
    for (UIImageView *didvide in self.divideVs) {
        UIButton *btn = self.btns[i];
        didvide.x = btn.x;
        i++;
    }
}

- (void)setStatus:(WBStatus *)status
{
    _status = status;
//   设置转发
    [self setBtn:_retweet title:status.reposts_count];
//   设置评论
    [self setBtn:_comment title:status.comments_count];
//   设置赞
    [self setBtn:_unlike title:status.attitudes_count];
}
//设置按钮的标题
- (void) setBtn:(UIButton *)btn title:(int)count
{
    NSString *title = nil;
    if (count) {
        if (count >10000) {
            CGFloat floatCount = count / 10000.00;
            title = [NSString stringWithFormat:@"%.1fw",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{
            title = [NSString stringWithFormat:@"%d",count];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
    }
}
@end
