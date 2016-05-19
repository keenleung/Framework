//
//  UIDevice+Extension.m
//  Framework
//
//  Created by Apple on 16/5/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIDevice+Extension.h"

@implementation UIDevice (Extension)

/** 设置横屏*/
+ (void)setLandscape{
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
}

/** 设置竖屏*/
+ (void)setPortrait{
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
}

+ (void)setLandscapeWithCompletion:(void (^)())completion{
    
    [self setLandscape];
    completion();
}

+ (void)setPortraitWithCompletion:(void (^)())completion{
    
    [self setPortrait];
    completion();
}

@end
