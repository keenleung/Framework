//
//  NSString+Extension.h
//  Framework
//
//  Created by Apple on 16/5/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  字符串编码
 *
 *  @return 编码后的字符串
 */
- (NSString *) encodeURL;

/**
 *  字符串解码
 *
 *  @return 解码后的字符串
 */
- (NSString *)decodeURL;

@end
