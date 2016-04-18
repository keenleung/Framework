//
//  NSArray+BlocksKit.h
//  Framework
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "Defines.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h> // for CGFloat

#define Type ObjectType

NS_ASSUME_NONNULL_BEGIN

@interface __GENERICS(NSArray, ObjectType) (BlocksKit)

/**
 *  遍历数组中每个元素, 执行 block 中的操作
 *
 *  @param block:执行的操作(不能为 nil). block参数:数组的元素
 */
- (void)each_:(void (^)(Type obj))block;

/**
 *  同步遍历数组中的每个元素, 执行 block
 *
 *  @param block:执行的操作(不能为nil). block参数:数组的元素
 */
- (void)apply_: (void (^)(Type obj))block;

/**
 *  遍历、匹配每个元素,直到条件满足为止
 *
 *  @param block 判断的条件. block参数:数组的元素
 *
 *  @return 匹配得到的元素.没有匹配得到,为nil
 */
- (nullable id)match_: (BOOL (^)(Type obj))block;

/**
 *  遍历、获取满足条件的元素集合
 *
 *  @param block 判断的条件. block参数:数组的元素
 *
 *  @return 满足条件的元素数组
 */
- (NSArray *)select_: (BOOL (^)(Type obj))block;

/**
 *  遍历、获取不满足条件的元素集合
 *
 *  @param block 判断的条件. block参数:数组的元素
 *
 *  @return 不满足条件的元素数组
 */
- (NSArray *)reject_: (BOOL (^)(Type obj))block;

/**
 *  遍历所有元素，对元素进行操作，返回一个新的数组
 *
 *  @param block 元素操作，需返回新的元素. block参数:数组的元素
 *
 *  @return 新的元素数组
 */
- (NSArray *)map_: (Type (^)(Type obj))block;

/**
 *  行为和map_一样，只不过不添加nil
 *
 *  @param block 元素操作，需返回新的元素. block参数:数组的元素
 *
 *  @return 新的元素数组
 */
- (NSArray *)compact_: (Type (^)(Type obj))block;


NS_ASSUME_NONNULL_END

@end
