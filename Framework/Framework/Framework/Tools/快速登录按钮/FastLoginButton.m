//
//  FastLoginButton.m
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "FastLoginButton.h"
#import "UIView+Extension.h"

@implementation FastLoginButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = 0;
    
    // 根据文字内容重新计算 titleLabel 的宽度
    [self.titleLabel sizeToFit];
    
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.y = self.height - self.titleLabel.height;
}

@end
