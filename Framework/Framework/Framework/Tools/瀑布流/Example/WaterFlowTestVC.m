//
//  ViewController.m
//  01-瀑布流
//
//  Created by Apple on 16/5/25.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//

#import "WaterFlowTestVC.h"
#import "WaterflowLayout.h"
#import "Shop.h"
#import <MJExtension.h>
#import <MJRefresh.h>

#import "ShopCell.h"

static NSString * const shopId = @"shopId";

@interface WaterFlowTestVC ()<UICollectionViewDataSource, WaterflowLayoutDelegate>

/** 所有商品*/
@property (nonatomic, strong) NSMutableArray *shops;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation WaterFlowTestVC

#pragma mark --------------------------
#pragma mark 懒加载

- (NSMutableArray *)shops{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

#pragma mark --------------------------
#pragma mark 初始

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
    
    [self setupRefresh];
}

- (void)setupRefresh{
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)setupCollectionView{
    
    // 布局
    WaterflowLayout *layout = [[WaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建 collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    collectionView.dataSource = self;
    
    // 注册 cell
    [collectionView registerNib:[UINib nibWithNibName:@"ShopCell" bundle:nil] forCellWithReuseIdentifier:shopId];
    self.collectionView = collectionView;
}

#pragma mark --------------------------
#pragma mark 数据获取
- (void)loadNewDatas{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *shops = [Shop mj_objectArrayWithFilename:@"shop.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        
        
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    });
}

- (void)loadMoreDatas{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *shops = [Shop mj_objectArrayWithFilename:@"shop.plist"];
        [self.shops addObjectsFromArray:shops];
        
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    });
}


#pragma mark --------------------------
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    self.collectionView.mj_footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopId forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}

#pragma mark --------------------------
#pragma mark WaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(WaterflowLayout *)waterfloawLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath andItemWidth:(CGFloat)itemWidth{
    
    Shop *shop = self.shops[indexPath.item];
    
    return 1.0 * itemWidth * shop.h / shop.w;
}

- (NSInteger)columnCountInWaterflowLayout:(WaterflowLayout *)waterflowLayout{
    
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterflowLayout *)waterflowLayout{
    
    return UIEdgeInsetsZero;
}


@end
