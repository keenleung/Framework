//
//  StatusBarHub.h
//  StatusBarHub
//
//  Created by Apple on 16/5/26.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//  状态指示器

#import <UIKit/UIKit.h>

@interface StatusBarHub : NSObject

/**
 *  显示图片和文字
 *
 *  @param text  提示文字
 *  @param image 图片
 */
+ (void)showText:(NSString *)text withImage:(UIImage *)image;

/**
 *  成功
 *
 *  @param text 提示文字
 */
+ (void)showSuccess:(NSString *)text;

/**
 *  有误
 *
 *  @param text 提示文字
 */
+ (void)showError:(NSString *)text;

/**
 *  显示菊花
 *
 *  @param text 提示文字
 */
+ (void)showLoading:(NSString *)text;

/**
 *  隐藏状态指示器
 */
+ (void)hide;

@end
