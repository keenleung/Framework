//
//  UIImageView+Download.h
//  Framework
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

// 根据网路状态，下载图片
// 使用 AFN 框架

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (Download)

#pragma mark ----------- 包含 进度---------------

/**
 *  根据网路状态,设置imageView显示的图片(有进度提示)
 *
 *  @param originalImageUrl  原图URL
 *  @param thumbnailImageURL 缩略图URL
 *  @param placehloderImage  占位图片
 *  @param options           图片下载模式
 *  @param progressBlock     进度
 *  @param completedBlock    获取图片完毕之后会调用的block
 */
-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL placehloderImage:(UIImage *)placehloderImage options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;


/**
 *  根据网路状态,设置imageView显示的图片(有进度提示)
 *
 *  @param originalImageUrl  原图URL
 *  @param thumbnailImageURL 缩略图URL
 *  @param placehloderImage  占位图片
 *  @param progressBlock     进度
 *  @param completedBlock    获取图片完毕之后会调用的block
 */
-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL placehloderImage:(UIImage *)placehloderImage progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;

/**
 *  根据网路状态,设置imageView显示的图片(有进度提示)
 *
 *  @param originalImageUrl  原图URL
 *  @param thumbnailImageURL 缩略图URL
 *  @param options           图片下载模式
 *  @param progressBlock     进度
 *  @param completedBlock    获取图片完毕之后会调用的block
 */
-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL  options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;

/**
 *  根据网路状态,设置imageView显示的图片(有进度提示)
 *
 *  @param originalImageUrl  原图URL
 *  @param thumbnailImageURL 缩略图URL
 *  @param progressBlock     进度
 *  @param completedBlock    获取图片完毕之后会调用的block
 */
-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL  progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;




#pragma mark ----------- 不包含 进度---------------

/**
 *  根据网路状态,设置imageView显示的图片
 *
 *  @param originalImageUrl  原图URL
 *  @param thumbnailImageURL 缩略图URL
 *  @param placehloderImage  占位图片
 *  @param completedBlock    获取图片完毕之后会调用的block
 */
-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL placehloderImage:(UIImage *)placehloderImage completed:(SDWebImageCompletionBlock)completedBlock;

/**
 *  根据网路状态,设置imageView显示的图片
 *
 *  @param originalImageUrl  原图URL
 *  @param thumbnailImageURL 缩略图URL
 */
-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL;

/**
 *  根据网路状态,设置imageView显示的图片
 *
 *  @param originalImageUrl  原图URL
 *  @param thumbnailImageURL 缩略图URL
 *  @param placehloderImage  占位图片
 */
-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL placehloderImage:(UIImage *)placehloderImage;

/**
 *  根据网路状态,设置imageView显示的图片
 *
 *  @param originalImageUrl  原图URL
 *  @param thumbnailImageURL 缩略图URL
 *  @param completedBlock    获取图片完毕之后会调用的block
 */
-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL completed:(SDWebImageCompletionBlock)completedBlock;

@end
