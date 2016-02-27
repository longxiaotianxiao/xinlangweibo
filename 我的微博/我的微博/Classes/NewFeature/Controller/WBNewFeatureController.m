//
//  WBNewFeatureController.m
//  我的微博
//
//  Created by wmd on 16/2/20.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBNewFeatureController.h"
#import "WBNewFeatureCell.h"
@interface WBNewFeatureController ()

@property(nonatomic,weak) UIPageControl *control;
@end

@implementation WBNewFeatureController

static NSString *ID = @"ccell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
//  设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
//  清空行距
    layout.minimumLineSpacing = 0;
//  设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor redColor];
//  注册cell
    [self.collectionView registerClass:[WBNewFeatureCell class] forCellWithReuseIdentifier:ID];
//  分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;

    [self setupPageControl];

}
//添加pageController
- (void)setupPageControl
{
//    添加pageController，只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
//    设置center
    control.center = CGPointMake(self.view.width*0.5, self.view.height-20);
    _control = control;
    [self.view addSubview:control];
}
#pragma mark - UIScrollView代理方法实现
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    
    _control.currentPage = page;
}
#pragma mark - collection 代理方法实现
//返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回第sectionyou几个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  4;
}
//返回cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WBNewFeatureCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
// 给cell传值
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row+1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:4];
    return cell;
}
@end
