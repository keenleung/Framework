//
//  UIColor+Hex.h
//  Framework
//
//  Created by Apple on 16/3/31.
//  Copyright © 2016年 Apple. All rights reserved.
//

#pragma mark --------------------------
#pragma mark 十六进制-获取颜色

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha;


/**
 *  从十六进制字符串获取颜色(默认alpha位1)
 *
 *  @param color color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;


/**
 *  从十六进制字符串获取颜色
 *
 *  @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
