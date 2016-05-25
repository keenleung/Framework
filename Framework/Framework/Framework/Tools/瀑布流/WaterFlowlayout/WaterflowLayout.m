//
//  WaterflowLayout.m
//  01-瀑布流
//
//  Created by Apple on 16/5/25.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//


#import "WaterflowLayout.h"

/** 默认的列数*/
static const NSInteger DefaultColumnCount = 3;
/** 每一列之间的距离*/
static const CGFloat DefaultColumnMargin = 10;
/** 每一行之间的间距*/
static const CGFloat DefaultRowMargin = 10;
/** 边缘间距*/
static const UIEdgeInsets DefaultEdgeInsets = {10, 10, 10, 10};

@interface WaterflowLayout()

/** 存放所有 cell 的布局属性*/
@property (nonatomic, strong) NSMutableArray *attrsArray;

/** 存放所有列的当前高度*/
@property (nonatomic, strong) NSMutableArray *columnHeights;

/** 记录内容的高度*/
@property (nonatomic, assign) CGFloat contentHeight;


/** 数据方法*/
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;

@end

@implementation WaterflowLayout

#pragma mark --------------------------
#pragma mark 懒加载
- (NSMutableArray *)attrsArray{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (NSMutableArray *)columnHeights{
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}


#pragma mark --------------------------
#pragma mark 数据处理
- (CGFloat)rowMargin{
    
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    }else{
        return DefaultRowMargin;
    }
}

- (CGFloat)columnMargin{
    
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    }else{
        return DefaultColumnMargin;
    }
}

- (NSInteger)columnCount{
    
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    }else{
        return DefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets{
    
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    }else{
        return DefaultEdgeInsets;
    }
}


#pragma mark --------------------------
#pragma mark 布局方法
/** 初始化*/
- (void)prepareLayout{
    [super prepareLayout];
    
    // 初始内容的高度
    self.contentHeight = 0;
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    // 初始所有列的高度为顶部间距
    for (int i = 0; i<self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    // 清除所有的布局属性
    [self.attrsArray removeAllObjects];
    
    // 开始创建每一个 cell 对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i<count; i++) {
        
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 获取 indexPath 对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArray addObject:attrs];
    }
}

/** 决定 cell 的排布*/
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    //NSLog(@"%s", __func__);
    
    return self.attrsArray;
}

/** 返回 indexPath 位置 cell 对应的布局属性*/
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%s", __func__);
    
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView 的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // 设置布局属性的 frame
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    
    //CGFloat h = 50 + arc4random_uniform(100);
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndexPath:indexPath andItemWidth:w];
    
    // 找出高度最短的那一列
    __block NSInteger destColumn = 0;
    __block CGFloat minColumnHeight = MAXFLOAT;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber *columnHeightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat columnHeight = columnHeightNumber.doubleValue;
        if (columnHeight < minColumnHeight) {
            minColumnHeight = columnHeight;
            destColumn = idx;
        }
    }];
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        
        y += self.rowMargin;
    }
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最矮那一列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    // 更新内容的高度
    __block CGFloat maxColumnHeight = 0;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber *columnHeightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat columnHeight = columnHeightNumber.doubleValue;
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }];
    self.contentHeight = maxColumnHeight;
    
    return attrs;
}

/** 重新计算 collectionView 的大小*/
- (CGSize)collectionViewContentSize{
    
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}



@end
