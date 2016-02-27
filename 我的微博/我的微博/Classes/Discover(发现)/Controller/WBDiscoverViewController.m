//
//  WBDiscoverViewController.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBDiscoverViewController.h"
#import "WBSearchBar.h"
@implementation WBDiscoverViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
//    创建搜索框
    WBSearchBar *searchBar = [[WBSearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    searchBar.placeholder = @"大家都在搜";
//    设置titleView为搜索框
    self.navigationItem.titleView = searchBar;
}


#pragma mark - TableView datasource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"发现数据－－%ld",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVc = [[UIViewController alloc] init];
    newVc.view.backgroundColor = [UIColor redColor];
    newVc.title = @"心控制器";
    
    [self.navigationController pushViewController:newVc animated:YES];
}
@end
