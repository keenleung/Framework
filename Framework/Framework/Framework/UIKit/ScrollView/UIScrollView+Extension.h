//
//  UIScrollView+Extension.h
//  Framework
//
//  Created by Apple on 16/5/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  滚动方向
 */
typedef NS_OPTIONS(NSUInteger, Direction) {
    /**
     *  靠顶部
     */
    kDirectionTop = 1 << 0,
    /**
     *  靠底部
     */
    kDirectionBottom = 1 << 1,
    /**
     *  靠左边
     */
    kDirectionLeft = 1 << 2,
    /**
     *  靠右边
     */
    kDirectionRight = 1 << 3,
    /**
     *  无效
     */
    kDirectionNone = 1 << 4,
};

@interface UIScrollView (Extension)

/**
 *  判断滚动方向(只能判断单个方向)
 *
 *  @return 方向 Direction
 */
- (Direction)scrollDirection;

@end
