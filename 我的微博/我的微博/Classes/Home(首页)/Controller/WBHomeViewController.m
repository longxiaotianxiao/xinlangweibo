//
//  WBHomeViewController.m
//  我的微博
//
//  Created by wmd on 16/2/19.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBHomeViewController.h"

#import "UIBarButtonItem+Item.h"
#import "WBTitleButton.h"

#import "WBPopMenu.h"
#import "WBCover.h"
#import "WBOneViewController.h"
#import "AFNetworking.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBStatus.h"
#import "MJExtension.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "WBHttpTool.h"
#import "WBStatusTool.h"
#import "WBStatusResult.h"
#import "WBUserTool.h"
#import "WBStatusCell.h"
#import "WBStatusFrame.h"

@interface WBHomeViewController ()<WBCoverDelegate>
@property (nonatomic, weak) WBTitleButton *titleButton;
@property (nonatomic, strong) WBOneViewController *one;
/**
 *  WBStatusFrame
 */
@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation WBHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (WBOneViewController *)one
{
    if (_one == nil) {
        _one = [[WBOneViewController alloc] init];
    }
    
    return _one;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor grayColor];
//    取消分割线
    
    // 设置导航条内容
    [self setUpNavgationBar];
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
//  请求最新的微博
    [self loadNewStatus];
//  下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    [self.tableView headerBeginRefreshing];
    self.tableView.headerRefreshingText = @"正在刷新  ";
//  上来加载more
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    self.tableView.footerRefreshingText = @"正在加载";
    
//  请求单签用户的昵称
    [WBUserTool userInfoWithSuccess:^(WBUser *user) {
    
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
//   获取当前的账号
        WBAccount *account = [WBAccountTool account];
        account.name = user.name;
        [WBAccountTool saveAccount:account];
    
    } failture:^(NSError *error) {
        
    }];
    
}
#pragma mark - 请求More的微博
- (void)loadMoreStatus
{
    NSString *maxIdStr = nil;
    if (self.statusFrames.count) {
        WBStatus *s = [[self.statusFrames lastObject] status];
        
        long long maxId = [s.idstr longLongValue]-1;
        maxIdStr =[NSString stringWithFormat:@"%lld",maxId];
    }
    [WBStatusTool moreStatusWithMaxId:maxIdStr sucess:^(NSArray *statuses) {
        //   结束下拉刷新
        [self.tableView footerEndRefreshing];
        //   模型转成试图模型
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (WBStatus *status in statuses) {
            WBStatusFrame *statusF = [[WBStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        //   把最新的微博插到前面
        [self.statusFrames addObjectsFromArray:statusFrames];
        //   刷新表格
        [self.tableView reloadData];
    } failture:^(NSError *error) {
        //   结束下拉刷新
        [self.tableView footerEndRefreshing];
    }];
    
}
#pragma mark - 请求最新的微博
- (void)loadNewStatus
{
    NSString *sinced = nil;
    if (self.statusFrames.count) {
        WBStatus *s = [self.statusFrames[0] status];
        sinced = s.idstr;
    }
    [WBStatusTool newStatusWithSinceId:sinced sucess:^(NSArray *statuses) {
        //  展示最新的微博数
        [self showNewStatusCount:statuses.count];
        //   结束下拉刷新
        [self.tableView headerEndRefreshing];
        //   模型转成试图模型
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (WBStatus *status in statuses) {
            WBStatusFrame *statusF = [[WBStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
      
        //   把最新的微博插到前面
        [self.statusFrames insertObjects:statusFrames atIndexes:indexset];
        //   刷新表格
        [self.tableView reloadData];
    } failture:^(NSError *error) {
        //   结束下拉刷新
        [self.tableView headerEndRefreshing];
    }];
    

}
#pragma mark -  展示最细你的微博条数
- (void)showNewStatusCount:(int)count
{
    if (count == 0) return;
    
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame)- h;
    CGFloat x = 0;
    CGFloat w = self.view.width;

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    lab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    lab.text = [NSString stringWithFormat:@"最新微博数%d",count];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    
    [self.navigationController.view insertSubview:lab belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.25 animations:^{
        lab.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            lab.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [lab removeFromSuperview];
        }];
    }];
}
#pragma mark - 设置导航条
- (void)setUpNavgationBar
{
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
   WBTitleButton *titleButton = [WBTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    //    NSLog(@"%@",[CZAccountTool account].name);
    NSString *title = [WBAccountTool account].name?:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}
// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    // 弹出蒙板
    WBCover *cover = [WBCover show];
    cover.delegate = self;
    
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
   WBPopMenu *menu = [WBPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
    
    
}

// 点击蒙板的时候调用
- (void)coverDidClickCover:(WBCover *)cover
{
    // 隐藏pop菜单
    [WBPopMenu hide];
    
    _titleButton.selected = NO;
    
}

- (void)friendsearch
{
//    NSLog(@"%s",__func__);
}

- (void)pop
{
// 创建one控制器
//  首先去寻找有没有WBOneView.xib
//  WBOneViewControl.xib
//  默认几乎透明的view
    WBOneViewController *one = [[WBOneViewController alloc] init];
    
    [self.navigationController  pushViewController:one animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView 代理方法实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//  创建cell
    WBStatusCell *cell = [WBStatusCell cellWithtabView:tableView];
    
    WBStatusFrame *statusF= self.statusFrames[indexPath.row];

    cell.statusF = statusF;
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
    return cell;
}
//返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusFrame *statusF = self.statusFrames[indexPath.row];
    return  statusF.cellHeight;
}
- (void)refresh
{
    [self.tableView headerBeginRefreshing];
}
@end
