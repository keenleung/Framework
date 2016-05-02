//
//  UIView+Animation.m
//  Framework
//
//  Created by Apple on 16/4/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void) addShakeAnimation {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.values = @[@(-3), @(0), @(3)];
    anim.repeatCount = 3;
    anim.duration = 0.2;
    
    [self.layer addAnimation:anim forKey:nil];
}

@end
