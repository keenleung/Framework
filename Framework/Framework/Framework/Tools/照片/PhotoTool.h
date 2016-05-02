//
//  PhotoTool.h
//  Framework
//
//  Created by Apple on 16/4/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTool : NSObject

#pragma mark ------------  保存图片到应用程序图片目录 --------------

/**
 *  保存图片到应用程序图片目录
 *
 *  @param image 要保存的图片
 */
+ (void) savePhotoToAppAlbum: (UIImage *)image;



#pragma mark ---------- 获取单张照片 ----------------

/**
 *  获取单张照片
 *
 *  @param completion 获取完毕后要执行的操作，参数是选取的照片
 */
+ (void)takePictureWithCompletion: (void (^)(UIImage *image))completion;


#pragma mark ----------- 获取多张照片 ---------------

/**
 *  获取多张照片，不限制选取图片的数量和不显示选取的顺序
 *
 *  @param completion 选取完毕后执行的操作
 */
+(void) takePicturesWithCompletion:(void (^)(NSArray<UIImage *> *images))completion;


/**
 *  获取多张照片
 *
 *  @param maxCount            照片数量选取的额度,0表示无限制
 *  @param showsSelectionIndex 是否显示选取顺序
 *  @param completion          选取完毕后执行的操作
 */
+ (void) takePicturesWithMaxCount:(NSInteger)maxCount showsSelectionIndex:(BOOL)showsSelectionIndex  completion:(void (^)(NSArray<UIImage *> *images))completion;

@end
