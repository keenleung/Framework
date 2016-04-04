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
 */
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level;

@end
