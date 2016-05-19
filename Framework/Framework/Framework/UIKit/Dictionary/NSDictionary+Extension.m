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

@implementation NSDictionary(PropertyCode)

// 自动生成属性代码
- (void)createPropetyCode
{
    // 模型中属性根据字典的key
    // 有多少个key,生成多少个属性
    
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString *code = nil;
        
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        } else if ([value isKindOfClass:[NSArray class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }
        
        // 拼接字符串
        [codes appendFormat:@"\n%@\n",code];
        
    }];
    
    NSLog(@"%@",codes);
    
}

@end
