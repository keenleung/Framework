//
//  UIScrollView+Extension.m
//  Framework
//
//  Created by Apple on 16/5/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)

- (Direction)scrollDirection{
    
    CGPoint translation = [self.panGestureRecognizer translationInView:self.superview];
    
    if (self.contentSize.width <= self.bounds.size.width) {
        
        if (translation.y>0) {
            return kDirectionTop;
        }
        
        if(translation.y<0){
            return kDirectionBottom;
        }
        
    }else if (self.contentSize.height <= self.bounds.size.height) {
        
        if (translation.x > 0) {
            return kDirectionLeft;
        }
        
        if (translation.x < 0) {
            return kDirectionRight;
        }
    }
    
    return kDirectionNone;
}

@end
