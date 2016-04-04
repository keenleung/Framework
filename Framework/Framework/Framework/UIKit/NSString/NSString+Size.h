//
//  NSString+Size.h
//  Framework
//
//  Created by Apple on 16/3/31.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 *   计算文字的大小
 *
 *  @param maxSize  设置最大宽度和高度
 *  @param fontSize 字体大小
 *
 *  @return <#return value description#>
 */
- (CGSize) sizeWithMaxSize: (CGSize)maxSize fontSize: (CGFloat)fontSize;

@end
