//
//  FPSLabel.h
//  Framework
//
//  Created by Apple on 16/4/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

// 在主窗口中显示帧率

#import <UIKit/UIKit.h>

@interface FPSLabel : UILabel

/**
 *  获取 FPSLabel
 *
 *  @return FPSLabel 对象
 */
+(instancetype)shareFPS;

/**
 *  指定显示在主窗口中哪个位置上
 *
 *  @param point 显示的位置
 */
+ (void) showAtPoint: (CGPoint)point;

/**
 *  从主窗口中移除
 */
+ (void) dismiss;

@end
