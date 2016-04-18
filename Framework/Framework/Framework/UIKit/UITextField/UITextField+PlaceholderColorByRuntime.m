//
//  UITextField+PlaceholderColorByRuntime.m
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UITextField+PlaceholderColorByRuntime.h"
#import <objc/message.h>

@implementation UITextField (PlaceholderColorByRuntime)

/** 交换方法*/
+ (void)load{
    
    Method placeholder_method = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method my_placeholder_method = class_getInstanceMethod(self, @selector(my_placeholder:));
    
    // 交换
    method_exchangeImplementations(placeholder_method, my_placeholder_method);
}

- (void) my_placeholder: (NSString *)placeholder{
    
    // 设置占位文字
    [self my_placeholder:placeholder];
    
    // 设置占位文字颜色
    [self setPlaceholderColor:self.placeholderColor];
}

/** 设置占位文字颜色*/
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    // 1.先把占位文字的颜色保存起来,等真正设置占位文字的时候,在去设置占位文字颜色
    // 动态添加成员属性
    objc_setAssociatedObject(self, @"rt_placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 2.获取占位文字控件
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    
    // 3.设置占位文字控件颜色
    [placeholderLabel setTextColor:placeholderColor];
}

/** 返回占位文字颜色*/
- (UIColor *)placeholderColor{
    
    return objc_getAssociatedObject(self, @"rt_placeholderColor");
}

@end
