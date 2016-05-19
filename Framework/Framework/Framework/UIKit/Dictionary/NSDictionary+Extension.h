//
//  NSDictionary+Extension.h
//  08-掌握-多值参数和中文输出
//
//  Created by Apple on 16/3/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

/**
 *  控制字典的输出(重写系统输出的方式)
 *
 *  @param locale An object that specifies options used for formatting each of the dictionary’s keys and values; pass nil if you don’t want them formatted.
 *  @param level  Specifies a level of indentation, to make the output more readable: the indentation is (4 spaces) * level.
 *
 *  @return NSString
 */
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level;

@end


@interface NSDictionary(PropertyCode)

/**
 *  生成属性代码
 */
- (void)createPropetyCode;

@end
