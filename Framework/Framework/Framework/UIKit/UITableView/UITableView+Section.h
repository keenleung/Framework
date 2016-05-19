//
//  UITableView+Section.h
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

// tableView 的一些常规操作

#import <UIKit/UIKit.h>

@interface UITableView (Section)

/**
 *  设置 tableView 每一组的 间距
 *
 *  @param height 组间距
 */
- (void) setSectionMarginHeight: (CGFloat)height;

@end
