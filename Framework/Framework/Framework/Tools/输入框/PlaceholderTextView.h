//
//  PlaceholderTextView.h
//  Framework
//
//  Created by Apple on 16/5/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
