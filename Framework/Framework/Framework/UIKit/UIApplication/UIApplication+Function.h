//
//  UIApplication+Function.h
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

// UIApplication 的常用功能

#import <UIKit/UIKit.h>

@interface UIApplication (Function)

/**
 *  打开指定的 URL
 *
 *  @param urlStr url字符串
 */
+ (void) openUrl: (NSString *)urlStr;

@end
