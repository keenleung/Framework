//
//  BubbleMenu.h
//  Framework
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BubbleMenuItem.h"

typedef void(^BubbleMenuSelectedItem)(NSInteger index, BubbleMenuItem *item);

typedef enum {
    BubbleMenuBackgrounColorEffectSolid      = 0, //!<背景显示效果.纯色
    BubbleMenuBackgrounColorEffectGradient   = 1, //!<背景显示效果.渐变叠加
} BubbleMenuBackgrounColorEffect;

@interface BubbleMenu : NSObject

+ (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect menuItems:(NSArray *)menuItems selected:(BubbleMenuSelectedItem)selectedItem;

+ (void)dismissMenu;
+ (BOOL)isShow;

// 主题色
+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

// 标题字体
+ (UIFont *)titleFont;
+ (void)setTitleFont:(UIFont *)titleFont;

// 背景效果
+ (BubbleMenuBackgrounColorEffect)backgrounColorEffect;
+ (void)setBackgrounColorEffect:(BubbleMenuBackgrounColorEffect)effect;

// 是否显示阴影
+ (BOOL)hasShadow;
+ (void)setHasShadow:(BOOL)flag;


@end

