//
//  PlaceholderTextView.m
//  Framework
//
//  Created by Apple on 16/5/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

// 带占位文字的输入框

#import "PlaceholderTextView.h"

@implementation PlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 默认字体大小
        self.font = [UIFont systemFontOfSize:15];
        
        // 默认颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange:(NSNotification *)notification {
    
    [self setNeedsDisplay];
}

- (void)dealloc{
    
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 重绘*/
- (void)drawRect:(CGRect)rect{
    
    // 如果有文字, 则不需要画占位文字
    if (self.hasText)
        return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    rect.origin.x = 5;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

// 如果调动了 setFrame 方法,就会调动
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}

#pragma mark --------------------------
#pragma mark 重写 set 方法
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font{
    
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text{
    
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

@end
