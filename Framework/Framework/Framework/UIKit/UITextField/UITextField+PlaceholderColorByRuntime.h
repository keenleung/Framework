//
//  UITextField+PlaceholderColorByRuntime.h
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//  通过 runtime 设置 UITextField 控件的 placeholder 的字体颜色
//  考虑: 不管是先设置 placeholder 的文字, 再设置颜色, 或者先设置颜色,再设置字体, 都保证没问题
//  使用: runtime 中的交换方法的使用

#import <UIKit/UIKit.h>

@interface UITextField (PlaceholderColorByRuntime)

@property (nonatomic, strong) UIColor *placeholderColor;

@end
