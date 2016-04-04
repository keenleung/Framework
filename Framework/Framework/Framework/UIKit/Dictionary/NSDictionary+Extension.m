//
//  NSDictionary+Extension.m
//  08-掌握-多值参数和中文输出
//
//  Created by Apple on 16/3/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

// 控制字典的输出
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:@"{\n"];
    
    // 拼接键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [string appendFormat:@"\t%@:", key];
        [string appendFormat:@"%@,\n", obj];
        
    }];
    
    [string appendString:@"}"];

    // 去除最后一个 , 号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    return string;
}
@end
