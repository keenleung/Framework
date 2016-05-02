//
//  PhoneType.m
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "PhoneType.h"

@implementation PhoneType

+ (iPhoneType)getPhoneType{
    
    CGFloat screen_h = [UIScreen mainScreen].bounds.size.height;
    
    if (screen_h == 736) {
        return iphone6P;
    }else if(screen_h == 667)
        return iphone6;
    else if(screen_h == 568)
        return iphone5;
    else if(screen_h == 480)
        return iphone4;
    return none;
}

@end
