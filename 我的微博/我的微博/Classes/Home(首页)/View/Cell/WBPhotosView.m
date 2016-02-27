//
//  WBPhotosView.m
//  我的微博
//
//  Created by wmd on 16/2/24.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBPhotosView.h"
#import "WBPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "WBPhotoView.h"
@interface WBPhotosView ()

@end
@implementation WBPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        添加所有子控件
        [self setUpAllChilView];
    }
    return  self;
}
- (void)setUpAllChilView
{
    for (int i = 0; i < 9; i++) {
        WBPhotoView *imageV = [[WBPhotoView alloc] init];
         imageV.tag = i;
//        添加手势
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        
        [self addSubview:imageV];
    }
}
#pragma mark -点击图片时调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = tap.view;
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
//  把WBphoto转成MJPhoto
    for (WBPhoto *photo in _pic_urls) {
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag;
    
    [brower show];
}
- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    int count = self.subviews.count;
    
    for (int i = 0; i < count; i++) {
        WBPhotoView *imageV = self.subviews[i];
        
        if (i <  pic_urls.count) {
            imageV.hidden = NO;
            WBPhoto *photo = pic_urls[i];
            imageV.photo = photo;
            }else{
            imageV.hidden = YES;
        }
    }
}
//计算尺寸
-  (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
//    计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i /cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
}
@end
