//
//  InfiniteScrollView.h
//  Framework
//
//  Created by Apple on 16/5/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InfiniteScrollView;

@class InfiniteScrollView;

typedef void (^IndexBlock)(NSInteger index);

#pragma mark --------------------------
#pragma mark InfiniteScrollViewDelegate

@protocol InfiniteScrollViewDelegate <NSObject>
@optional
/**
 *  点击了下标为 index 的图片
 *
 *  @param infiniteScrollView 轮播器
 *  @param index              下标
 */
- (void)infiniteScrollView:(InfiniteScrollView *)infiniteScrollView didClickImageAtIndex:(NSInteger)index;
@end

#pragma mark --------------------------
#pragma mark InfiniteScrollView

@interface InfiniteScrollView : UIView

/** 每张图片轮播的时间, 默认是1.5s*/
@property (nonatomic, assign) NSTimeInterval interval;

/** 需要显示的图片数据(要求里面存放UIImage\NSURL对象) */
@property (nonatomic, strong) NSArray *images;

/** 下载远程图片时的占位图片 */
@property (nonatomic, strong) UIImage *placeholderImage;

/** 用来监听框架内部事件的代理 */
@property (nonatomic, weak) id delegate;

#pragma mark --------------------------
#pragma mark block
/** 获取轮播器当前的图片下标*/
@property (nonatomic, strong) IndexBlock currentIndexBlock;

@end
