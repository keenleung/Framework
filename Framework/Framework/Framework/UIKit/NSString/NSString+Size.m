//
//  NSString+Size.m
//  Framework
//
//  Created by Apple on 16/3/31.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize) sizeWithMaxSize: (CGSize)maxSize fontSize: (CGFloat)fontSize{
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
}

@end
