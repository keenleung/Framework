//
//  StatusBarHub.m
//  StatusBarHub
//
//  Created by Apple on 16/5/26.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//

#import "StatusBarHub.h"

#pragma mark --------------------------
#pragma mark 宏
/** 屏幕宽度*/
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
/** 屏幕高度*/
#define ScreenH ([UIScreen mainScreen].bounds.size.height)
/** 指示器的背景色*/
#define BackGroundColor [UIColor blackColor]
/** 指示器文字的颜色*/
#define TitleColor [UIColor whiteColor]

#pragma mark --------------------------
#pragma mark 指示器配置
/** 状态指示器的高度*/
static CGFloat const WindowH = 40;
/** 指示器的等待的时间*/
static CGFloat const TimerInterval = 2.0;
/** 指示器显示的动画时间*/
static CGFloat const AnimationInterval = 0.25;
/** 提示文字的文字大小*/
static CGFloat const TitleFontSize = 13;
/** 图片和文字之间的间隔*/
static CGFloat const TitleMargin = 5.0;
/** 菊花和文字之间的间隔*/
static CGFloat const LoadingMargin = 15.0;


/** 状态指示器*/
static UIWindow *window_;
/** 操作动画的定时器*/
static NSTimer *timer_;

@implementation StatusBarHub

#pragma mark --------------------------
#pragma mark 创建
/** 创建指示器*/
+ (void)setWindow{
    
    // 移除定时器
    [timer_ invalidate];
    timer_ = nil;
    window_.hidden = YES;
    
    // 指示器的 frame
    // 到哪里
    CGRect toFrame = [UIApplication sharedApplication].statusBarFrame;
    toFrame.size.height = WindowH;
    // 从哪来
    CGRect frFrame = toFrame;
    frFrame.origin.y -= WindowH;
    
    // 创建指示器
    window_ = [[UIWindow alloc] init];
    window_.frame = frFrame;
    window_.windowLevel = UIWindowLevelAlert;
    // 设置指示器的背景颜色
    window_.backgroundColor = BackGroundColor;
    // 显示指示器
    window_.hidden = NO;
}

/** 执行指示器显示的动画*/
+ (void)showWindow{
    
    // 显示动画
    [UIView animateWithDuration:AnimationInterval animations:^{
        CGRect frame = window_.frame;
        frame.origin.y += WindowH;
        window_.frame = frame;
    }];
}


#pragma mark --------------------------
#pragma mark 操作
+ (void)showText:(NSString *)text withImage:(UIImage *)image{
    
    [self setWindow];
    
    // 设置指示器上显示的文字和图片
    UIButton *button = [[UIButton alloc] initWithFrame:window_.bounds];
    [window_ addSubview:button];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:TitleFontSize];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, TitleMargin);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, TitleMargin, 0, 0);
    }
    
    [self showWindow];
    
    // 设置定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:TimerInterval target:self selector:@selector(hide) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer_ forMode:NSRunLoopCommonModes];
}

+ (void)showSuccess:(NSString *)text{
    
    UIImage *image = [UIImage imageNamed:@"StatusBarHub.bundle/success.png"];
    [self showText:text withImage:image];
}

+ (void)showError:(NSString *)text{
    
    UIImage *image = [UIImage imageNamed:@"StatusBarHub.bundle/error.png"];
    [self showText:text withImage:image];
}

+ (void)showLoading:(NSString *)text{
    
    [self setWindow];
    
    UIButton *button = [[UIButton alloc] initWithFrame:window_.bounds];
    [window_ addSubview:button];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:TitleFontSize];
    
    // 菊花
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    [window_ addSubview:loadingView];
    
    // 计算菊花的位置
    CGFloat centerX = 0;
    if (text) {
        [button.titleLabel sizeToFit];
        NSString *buttonText =  button.titleLabel.text;
        CGSize maxSize = CGSizeMake(ScreenW, WindowH);
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:TitleFontSize]};
        CGSize buttonTextSize = [buttonText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        centerX = (ScreenW - buttonTextSize.width) * 0.5;
        loadingView.center = CGPointMake(centerX - LoadingMargin, WindowH * 0.5);
    }else{
        centerX = ScreenW * 0.5;
        loadingView.center = CGPointMake(centerX, WindowH * 0.5);
    }
    
    [self showWindow];
}

+ (void)hide{
    
    // 移除定时器
    [timer_ invalidate];
    timer_ = nil;
    
    // 隐藏window
    [UIView animateWithDuration:AnimationInterval animations:^{
        
        CGRect frame = window_.frame;
        frame.origin.y -= WindowH;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        
        window_ = nil;
    }];
}

@end
