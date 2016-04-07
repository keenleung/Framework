//
//  GlobalConst.h
//  Framework
//
//  Created by Apple on 16/4/5.
//  Copyright © 2016年 Apple. All rights reserved.
//  全局常量

#pragma mark --------------------------
#pragma mark 全局常量

// 全局变量的声明 统一放在.h中
/********************* 首页 *****************/

// 从 UIKIT_EXTERN 获取设置全局变量的定义方式
KeenKit_EXTERN NSString *name;
KeenKit_EXTERN NSString *name2;
KeenKit_EXTERN NSString *name3;
KeenKit_EXTERN NSString *name1;









#ifdef __cplusplus
#define KeenKit_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define KeenKit_EXTERN	        extern __attribute__((visibility ("default")))
#endif