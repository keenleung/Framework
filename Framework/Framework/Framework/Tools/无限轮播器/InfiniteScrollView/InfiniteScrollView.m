//
//  InfiniteScrollView.m
//  Framework
//
//  Created by Apple on 16/5/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "InfiniteScrollView.h"
#import "UIImageView+WebCache.h"

/************** ImageCell **************/
#pragma mark - ImageCell begin
@interface ImageCell : UICollectionViewCell
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation ImageCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}
@end

/************** InfiniteScrollView **************/
#pragma mark - InfiniteScrollView begin
@interface InfiniteScrollView()  <UICollectionViewDataSource, UICollectionViewDelegate>
/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;
/** 用来显示图片的collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation InfiniteScrollView

static NSInteger ImgItemCount = 20;
static NSString * const ImageCellId = @"ImageCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        
        // UICollectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        collectionView.delegate = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        [collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:ImageCellId];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        // 默认属性值
        self.interval = 1.5;
        self.placeholderImage = [UIImage imageNamed:@"InfiniteScrollView.bundle/placeholderImage"];
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    // 设置默认显示最中间的图片
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(ImgItemCount * images.count) / 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    });
    
    // 开启定时器
    [self startTimer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // collectionView
    self.collectionView.frame = self.bounds;
    
    // layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = self.bounds.size;
}



- (void)setInterval:(NSTimeInterval)interval{
    _interval = interval;
    
    if (self.timer) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self stopTimer];
            [self startTimer];
        });
    }
}

#pragma mark - 定时器
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    CGPoint offset = self.collectionView.contentOffset;
    offset.x += self.collectionView.frame.size.width;
    [self.collectionView setContentOffset:offset animated:YES];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ImgItemCount * self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCellId forIndexPath:indexPath];
    
    id data = self.images[indexPath.item % self.images.count];
    if ([data isKindOfClass:[UIImage class]]) {
        cell.imageView.image = data;
    } else if ([data isKindOfClass:[NSURL class]]) {
        [cell.imageView sd_setImageWithURL:data placeholderImage:self.placeholderImage];
    }else if ([data isKindOfClass:[NSString class]]) {
        if ([data hasPrefix:@"http"]) {
            NSURL *imgUrl = [NSURL URLWithString:data];
            if ([[UIApplication sharedApplication] canOpenURL:imgUrl]) {
                [cell.imageView sd_setImageWithURL:imgUrl placeholderImage:self.placeholderImage];
            }
        }
    }
    
    return cell;
}

#pragma mark - 其他
/**
 *  重置cell的位置到中间
 */
- (void)resetPosition
{
    // 滚动完毕时，自动显示最中间的cell
    NSInteger oldItem = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    NSInteger newItem = (ImgItemCount * self.images.count / 2) + (oldItem % self.images.count);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:newItem inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didClickImageAtIndex:)]) {
        [self.delegate infiniteScrollView:self didClickImageAtIndex:indexPath.item % self.images.count];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开启定时器
    [self startTimer];
}

/**
 *  scrollView滚动完毕的时候调用（通过setContentOffset:animated:滚动）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self resetPosition];
}

/**
 *  scrollView滚动完毕的时候调用（人为拖拽滚动）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resetPosition];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.currentIndexBlock) {
        NSInteger index = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
        index = index % self.images.count;
        self.currentIndexBlock(index);
    }
}

/************** InfiniteScrollView end **************/
@end

