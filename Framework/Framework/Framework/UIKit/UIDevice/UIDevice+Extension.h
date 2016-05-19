//
//  UIDevice+Extension.h
//  Framework
//
//  Created by Apple on 16/5/19.
//  Copyright © 2016年 Apple. All rights reserved.
//  手机设备常规操作

#import <UIKit/UIKit.h>

@interface UIDevice (Extension)

/**
 *  设置横屏
 */
+ (void)setLandscape;

/**
 *  设置竖屏
 */
+ (void)setPortrait;

/**
 *  设置横屏
 *
 *  @param completion 完毕后要进行的操作
 */
+ (void)setLandscapeWithCompletion:(void (^)())completion;

/**
 *  设置竖屏
 *
 *  @param completion 完毕后要进行的操作
 */
+ (void)setPortraitWithCompletion:(void (^)())completion;

@end
