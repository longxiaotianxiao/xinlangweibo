//
//  WBOneViewController.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBOneViewController.h"
#import "UIBarButtonItem+Item.h"
#import "WBTwoViewController.h"
@interface WBOneViewController ()

@end

@implementation WBOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

}

- (IBAction)jumpToTwo:(id)sender
{
    WBTwoViewController *two = [[WBTwoViewController alloc] init];
    [self.navigationController pushViewController:two animated:YES];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *ID = @"cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        cell.backgroundColor = [UIColor clearColor];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    return cell;
//    
//}
@end
