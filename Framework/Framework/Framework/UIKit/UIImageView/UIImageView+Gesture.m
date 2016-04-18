//
//  UIImageView+Gesture.m
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIImageView+Gesture.h"

@implementation UIImageView (Gesture)

- (void) addTapGestureWithTarger:(nullable id)target action:(nullable SEL)action{
    
    // 可交互
    self.userInteractionEnabled = YES;
    
    // 添加点按手势, 点击广告图片 跳转到广告界面 用safari打开
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tapGesture];
}

@end
