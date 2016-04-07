//
//  UIBarButtonItem+Extension.m
//  Tools
//
//  Created by Magic_Unique on 15/8/21.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype) barButtonItemInButtonTypeWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action{
    
    return [self barButtonItemWithImage:image otherStateImage:selectedImage state:UIControlStateSelected target:target action:action];
    
}

+ (instancetype) barButtonItemInButtonTypeWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action{
    
    return [self barButtonItemWithImage:image otherStateImage:highlightedImage state:UIControlStateHighlighted target:target action:action];
    
}

+ (instancetype) barButtonItemInButtonTypeWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action{
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    return [self barButtonItemInButtonTypeWithImage:image selectedImage:selectedImage target:target action:action];
}

+ (instancetype) barButtonItemInButtonTypeWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action{
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *highlightedImage = [UIImage imageNamed:highlightedImageName];
    
    return [self barButtonItemInButtonTypeWithImage:image highlightedImage:highlightedImage target:target action:action];
}

/** 自定义 抽取*/
+ (instancetype)barButtonItemWithImage:(UIImage *)image otherStateImage:(UIImage *)otherStateImage state:(UIControlState)otherImageState target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:otherStateImage forState:otherImageState];
    
    [button sizeToFit];
    
    // 只有按钮范围才能够点击
    UIView *buttonView = [[UIView alloc] initWithFrame:button.bounds];
    [buttonView addSubview:button];
    
    
    // 按钮点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:buttonView];
}
@end
