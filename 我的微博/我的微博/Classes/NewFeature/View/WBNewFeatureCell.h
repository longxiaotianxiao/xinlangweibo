//
//  WBNewFeatureCell.h
//  我的微博
//
//  Created by wmd on 16/2/21.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBNewFeatureCell : UICollectionViewCell

@property(nonatomic,strong) UIImage *image;

//判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end
