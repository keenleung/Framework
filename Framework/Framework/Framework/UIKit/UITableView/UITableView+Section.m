//
//  UITableView+Section.m
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UITableView+Section.h"

@implementation UITableView (Section)

- (void) setSectionMarginHeight: (CGFloat)height{
    
    // 设置每组的间距
    self.sectionHeaderHeight = 0;
    self.sectionFooterHeight = height;
    
    // 设置顶部额外滚动区域
    // 获取第一组第一行的 cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        return;
    }
    NSLog(@"%@", NSStringFromCGRect(cell.frame));
    // cell 的 y 值是否大于指定的高度
    CGFloat offsetY = 0;
    if (cell.frame.origin.y != height) {
        
        offsetY = height - cell.frame.origin.y;
    }
    // 设置额外滚动区域
    self.contentInset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
}

@end
