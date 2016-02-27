//
//  WBProfileViewController.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBProfileViewController.h"

@implementation WBProfileViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settings)];
    NSMutableDictionary *settingsAttr = [NSMutableDictionary dictionary];
    settingsAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [settings setTitleTextAttributes:settingsAttr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = settings;
}

- (void)settings
{
    NSLog(@"设置");
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
    cell.textLabel.text = [NSString stringWithFormat:@"我数据－－%ld",indexPath.row];
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
