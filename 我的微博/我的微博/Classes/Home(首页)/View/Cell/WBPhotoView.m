//
//  WBPhotoView.m
//  我的微博
//
//  Created by wmd on 16/2/25.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBPhotoView.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"
@interface WBPhotoView ()

@property (nonatomic,weak) UIImageView *gifView;

@end
@implementation WBPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return  self;
}
-(void)setPhoto:(WBPhoto *)photo
{
    _photo = photo;
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
//    判断.gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}
//只有后缀名是.gif时显示
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}
@end
