//
//  UITextField+Placeholder.m
//  BaiSiBuDeJie
//
//  Created by Apple on 16/4/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    if (self.placeholder == nil) {
        self.placeholder = @" ";
    }
    
    // 获取占位文字控件
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    
    // 设置占位文字控件的颜色
    label.textColor = placeholderColor;
}

- (UIColor *)placeholderColor{
    return nil;
}

@end
