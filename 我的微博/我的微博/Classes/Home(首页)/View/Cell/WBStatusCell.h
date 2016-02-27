//
//  WBStatusCell.h
//  我的微博
//
//  Created by wmd on 16/2/23.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatusFrame;
@interface WBStatusCell : UITableViewCell

@property (nonatomic,strong) WBStatusFrame *statusF;

+ (instancetype)cellWithtabView:(UITableView *)tableView;
@end
