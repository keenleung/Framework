//
//  WaterflowLayout.h
//  01-瀑布流
//
//  Created by Apple on 16/5/25.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterflowLayout;

#pragma mark --------------------------
#pragma mark 协议
@protocol WaterflowLayoutDelegate <NSObject>

@required
/**
 *  计算当前 item 的高度
 *
 *  @param waterfloawLayout 布局对象
 *  @param indexPath        当前 item 所在的 indexPath
 *  @param itemWidth        当前 item 的宽度(已经计算好了)
 *
 *  @return item 的高度 CGFloat
 */
- (CGFloat)waterflowLayout:(WaterflowLayout *)waterfloawLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath andItemWidth:(CGFloat)itemWidth;

@optional

/**
 *  指定布局有多少列(默认是3列)
 *
 *  @param waterflowLayout 布局对象
 *
 *  @return 布局的列数
 */
- (NSInteger)columnCountInWaterflowLayout:(WaterflowLayout *)waterflowLayout;

/**
 *  指定每一列的间距(默认是10)
 *
 *  @param waterflowLayout 布局对象
 *
 *  @return 每一列的间距
 */
- (CGFloat)columnMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout;

/**
 *  指定每一行的间距(默认是10)
 *
 *  @param waterflowLayout 布局对象
 *
 *  @return 每一行的间距
 */
- (CGFloat)rowMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout;

/**
 *  指定 collectioinView 上、下、左和右的边距
 *
 *  @param waterflowLayout 布局对象
 *
 *  @return collectioinView 上、下、左和右的边距(UIEdgeInsets)
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterflowLayout *)waterflowLayout;

@end

#pragma mark --------------------------
#pragma mark WaterflowLayout
@interface WaterflowLayout : UICollectionViewLayout

/**
 *  代理
 */
@property (nonatomic, weak) id<WaterflowLayoutDelegate> delegate;

@end
