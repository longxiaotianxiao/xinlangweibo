//
//  WBSearchBar.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageView.width += 10;
        imageView.contentMode = UIViewContentModeCenter;
        self.font = [UIFont systemFontOfSize:13];
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return  self;
}
@end
