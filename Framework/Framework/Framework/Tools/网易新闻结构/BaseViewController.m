//
//  BaseViewController.m
//  Framework
//
//  Created by Apple on 16/5/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "BaseViewController.h"

#define BaseVCScreenW [UIScreen mainScreen].bounds.size.width
#define BaseVCScreenH [UIScreen mainScreen].bounds.size.height

@interface BaseViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic ,strong) NSMutableArray *titleButtons;
@property (nonatomic, assign) BOOL isInitial;

@end

@implementation BaseViewController


- (NSMutableArray *)titleButtons
{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

// 每一个功能,都抽出来
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加标题滚动视图
    [self setupTitleScrollView];
    
    // 2.添加内容滚动视图
    [self setupContentScrollView];
    
    
    // iOS7之后,导航控制器中的scrollView默认顶部会添加额外滚动区域64
    // 1.内容无缘无故往下面走64 -> 有没有导航控制器
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInitial == NO) {
        
        // 4.设置所有标题
        [self setupAllTitleButton];
        
        _isInitial = YES;
    }
    
}

#pragma mark - 点击标题就会调用
- (void)titleClick:(UIButton *)button
{
    /*
     1.让标题颜色变成红色
     2.把对应子控制器的View添加上去
     3.让scrollView滚动对应位置
     */
    
    // 选中按钮
    [self selectButton:button];
    
    NSInteger i = button.tag;
    
    // 添加对应子控制器的view
    [self setupOneChildViewController:i];
    
    // 让scrollView滚动对应位置
    CGFloat x = i * BaseVCScreenW;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
}

#pragma mark -UIScrollViewDelegate
// 监听scrollView滚动完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取角标
    NSInteger i = scrollView.contentOffset.x / BaseVCScreenW;
    
    // 获取选中标题按钮
    UIButton *selectButton = self.titleButtons[i];
    // 1.选中标题
    [self selectButton:selectButton];
    
    // 2.把对应子控制器的view添加上去
    [self setupOneChildViewController:i];
}

// 滚动scrollView就会调用 标题缩放
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger leftI = scrollView.contentOffset.x / BaseVCScreenW;
    // 获取左边按钮
    UIButton *leftButton = self.titleButtons[leftI];
    
    // 获取右边按钮 6
    NSInteger rightI = leftI + 1;
    UIButton *rightButton;
    if (rightI < self.titleButtons.count) {
        rightButton = self.titleButtons[rightI];
    }
    
    // 获取缩放比例
    // 0 ~ 1 => 1 ~ 1.3
    CGFloat rightScale = scrollView.contentOffset.x / BaseVCScreenW - leftI;
    
    CGFloat leftScale = 1 - rightScale;
    
    // 对标题按钮进行缩放 1 ~ 2
    leftButton.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3 + 1);
    rightButton.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3 + 1);
    
    // 颜色渐变 -> 怎么渐变
    // 右边颜色
    UIColor *rightColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
    UIColor *leftColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
}


#pragma mark -把子控制器的view添加
- (void)setupOneChildViewController:(NSInteger)i
{
    UIViewController *vc = self.childViewControllers[i];
    
    // 判断下有没有父控件
    if (vc.view.superview) return;
    
    CGFloat x = i * BaseVCScreenW;
    // 设置vc的view的位置
    vc.view.frame = CGRectMake(x, 0, BaseVCScreenW, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
    
}

// 选中按钮
- (void)selectButton:(UIButton *)button
{
    // 恢复上一个按钮选中标题
    [_selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedButton.transform = CGAffineTransformIdentity;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    // 标题居中显示:本质就是设置偏移量
    CGFloat offsetX = button.center.x - BaseVCScreenW * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 处理最大偏移量
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - BaseVCScreenW;
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    // 标题缩放 -> 如何让标题缩放 改形变
    button.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    _selectedButton = button;
    
}

#pragma mark - 设置所有标题
- (void)setupAllTitleButton
{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 100;
    CGFloat btnH = 35;
    
    for (int i = 0; i < count; i++) {
        // 创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
        
        if (i == 0) {
            [self titleClick:btn];
        }
        
        [self.titleButtons addObject:btn];
        
    }
    
    // 设置titleScrollView滚动范围
    CGFloat contentW = count * btnW;
    self.titleScrollView.contentSize = CGSizeMake(contentW, 0);
    // 清空水平指示条
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    self.contentScrollView.contentSize = CGSizeMake(count * BaseVCScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 添加标题滚动视图
- (void)setupTitleScrollView
{
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    
    CGFloat y = self.navigationController.navigationBarHidden? 20 : 64;
    
    titleScrollView.frame = CGRectMake(0, y, BaseVCScreenW, 35);
    
    [self.view addSubview:titleScrollView];
    
    _titleScrollView = titleScrollView;
}

#pragma mark - 添加内容滚动视图
- (void)setupContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    
    CGFloat y = CGRectGetMaxY(_titleScrollView.frame);
    
    contentScrollView.frame = CGRectMake(0, y, BaseVCScreenW, BaseVCScreenH - y);
    
    [self.view addSubview:contentScrollView];
    
    _contentScrollView = contentScrollView;
    
    // 设置代理
    contentScrollView.delegate = self;
}

@end
