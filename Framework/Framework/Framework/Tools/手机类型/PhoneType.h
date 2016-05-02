//
//  PhoneType.h
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//  判断手机类型

#pragma mark --------------------------
#pragma mark 说明: 判断手机类型

#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>
//#import <CoreGraphics/CoreGraphics.h>

typedef NS_OPTIONS(NSUInteger, iPhoneType) {
    none     = 0, // 没有匹配得到
    iphone6P = 1,
    iphone6  = 2,
    iphone5  = 3,
    iphone4  = 4,
};

@interface PhoneType : NSObject

/**
 *  获取手机类型
 *
 *  @return iphone6P, iphone6, iphone5, iphone4, none(没有匹配得到)
 */
+ (iPhoneType)getPhoneType;

@end
