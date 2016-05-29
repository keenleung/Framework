//
//  UIViewController+Transition.h
//  TowVCTest
//
//  Created by Apple on 16/5/29.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//  控制器衔接切换

#import <UIKit/UIKit.h>

@interface UIViewController (Transition)
#pragma mark --------------------------
#pragma mark push 操作

/**
 *  push 一个控制器(默认动作是从右边 push 进来)
 *
 *  @param vc 要显示的控制器
 */
- (void)pushVC:(UIViewController *)vc;

/**
 *  从左边 push 一个控制器
 *
 *  @param vc 要显示的控制器
 */
- (void)pushVCFromLeft:(UIViewController *)vc;

/**
 *  从右边 push 一个控制器
 *
 *  @param vc 要显示的控制器
 */
- (void)pushVCFromRight:(UIViewController *)vc;

/**
 *  从顶部 push 一个控制器
 *
 *  @param vc 要显示的控制器
 */
- (void)pushVCFromTop:(UIViewController *)vc;

/**
 *  从底部 push 一个控制器
 *
 *  @param vc 要显示的控制器
 */
- (void)pushVCFromBotton:(UIViewController *)vc;

/**
 *  push 一个控制器, 指定时间
 *
 *  @param vc       要显示的控制器
 *  @param duration 执行时间
 */
- (void)pushVC:(UIViewController *)vc withDuration:(NSTimeInterval)duration;

/**
 *  从左边 push 一个控制器, 指定时间
 *
 *  @param vc       要显示的控制器
 *  @param duration 执行时间
 */
- (void)pushVCFromLeft:(UIViewController *)vc withDuration:(NSTimeInterval)duration;

/**
 *  从左边 push 一个控制器, 指定时间
 *
 *  @param vc       要显示的控制器
 *  @param duration 执行时间
 */
- (void)pushVCFromRight:(UIViewController *)vc withDuration:(NSTimeInterval)duration;

/**
 *  从顶部 push 一个控制器, 指定时间
 *
 *  @param vc       要显示的控制器
 *  @param duration 执行时间
 */
- (void)pushVCFromTop:(UIViewController *)vc withDuration:(NSTimeInterval)duration;

/**
 *  从底部 push 一个控制器, 指定时间
 *
 *  @param vc       要显示的控制器
 *  @param duration 执行时间
 */
- (void)pushVCFromBotton:(UIViewController *)vc withDuration:(NSTimeInterval)duration;


#pragma mark --------------------------
#pragma mark pop 操作

/**
 *  执行 pop 操作(默认动作是从左边 pop)
 */
- (void)popVC;

/**
 *  从顶部执行 pop 操作
 */
- (void)popVCFromTop;

/**
 *  从左边执行 pop 操作
 */
- (void)popVCFromLeft;

/**
 *  从右边执行 pop 操作
 */
- (void)popVCFromRight;

/**
 *  从底部执行 pop 操作
 */
- (void)popVCFromBottom;

/**
 *  指定时间,执行 pop 操作
 *
 *  @param duration 执行时间
 */
- (void)popVCWithDudation:(NSTimeInterval)duration;

/**
 *  指定时间,从顶部执行 pop 操作
 *
 *  @param duration 执行时间
 */
- (void)popVCFromTopWithDuration:(NSTimeInterval)duration;

/**
 *  指定时间,从底部执行 pop 操作
 *
 *  @param duration 执行时间
 */
- (void)popVCFromBottomWithDuration:(NSTimeInterval)duration;

/**
 *  指定时间,从左边执行 pop 操作
 *
 *  @param duration 执行时间
 */
- (void)popVCFromLeftWithDuration:(NSTimeInterval)duration;

/**
 *  执行时间,从右边执行 pop 操作
 *
 *  @param duration 执行时间
 */
- (void)popVCFromRightWithDuration:(NSTimeInterval)duration;

@end
