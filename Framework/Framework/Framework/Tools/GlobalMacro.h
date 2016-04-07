//
//  GlobalMacro.h
//  Framework
//
//  Created by Apple on 16/4/5.
//  Copyright © 2016年 Apple. All rights reserved.
//  常用宏 收集

#pragma mark --------------------------
#pragma mark 常用宏 收集

#pragma mark --------------------------
#pragma mark 屏幕宽度和高度
/** 屏幕宽度和高度*/
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

#pragma mark --------------------------
#pragma mark 手机类型 iphone4,iphone5,iphone6,iphone6Plus
/** 手机类型*/
#define iphone6P (ScreenH == 736)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)


