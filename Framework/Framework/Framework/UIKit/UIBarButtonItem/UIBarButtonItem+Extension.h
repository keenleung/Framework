//
//  UIBarButtonItem+Extension.h
//  Tools
//
//  Created by Magic_Unique on 15/8/21.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

#pragma mark --------------------------
#pragma mark 自定义 UIBarButtonItem
/**
 *  自定义barButtonItem, 类型为 button(选中状态)
 *
 *  @param image         正常状态的图片
 *  @param selectedImage 选中状态的图片
 *  @param target        谁处理按钮的点击事件
 *  @param action        点击按钮后的操作
 *
 *  @return UIBarButtonItem 实例
 */
+ (instancetype) barButtonItemInButtonTypeWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;

/**
 *  自定义barButtonItem, 类型为 button(高亮状态)
 *
 *  @param image         正常状态的图片
 *  @param highlightedImage 高亮状态的图片
 *  @param target        谁处理按钮的点击事件
 *  @param action        点击按钮后的操作
 *
 *  @return UIBarButtonItem 实例
 */
+ (instancetype) barButtonItemInButtonTypeWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action;

/**
 *  自定义barButtonItem, 类型为 button(选中状态,图片名称)
 *
 *  @param imageName         正常状态的图片名称
 *  @param selectedImageName 选中状态的图片名称
 *  @param target            谁处理按钮的点击事件
 *  @param action            点击按钮后的操作
 *
 *  @return UIBarButtonItem 实例
 */
+ (instancetype) barButtonItemInButtonTypeWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action;

/**
 *  自定义barButtonItem, 类型为 button(高亮状态,图片名称)
 *
 *  @param imageName            正常状态的图片名称
 *  @param highlightedImageName 高亮状态的图片名称
 *  @param target               谁处理按钮的点击事件
 *  @param action               点击按钮后的操作
 *
 *  @return UIBarButtonItem 实例
 */
+ (instancetype) barButtonItemInButtonTypeWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action;


@end
