//
//  UserDefaults.h
//  Framework
//
//  Created by Apple on 16/5/22.
//  Copyright © 2016年 Apple. All rights reserved.
//  用户偏好设置

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

/**
 *  获取用户偏好
 *
 *  @param key 偏好键 key
 *
 *  @return id
 */
+ (nullable id)objectForKey:(NSString * _Nonnull)key;

/**
 *  设置用户偏好
 *
 *  @param value 编好值 value
 *  @param key   偏好键 key
 */
+ (void)setObject:(nullable id)value forKey:(NSString *_Nonnull)key;

@end
