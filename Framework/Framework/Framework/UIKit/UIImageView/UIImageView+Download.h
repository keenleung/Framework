//
//  UIImageView+Download.h
//  Framework
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Apple. All rights reserved.
//  根据网路状态，下载图片

/*
 if (缓存中有原图) {
 self.imageView.image = 原图;
 } else {
 if (Wifi环境) {
 下载显示原图
 } else if (手机自带网络) {
 if (3G\4G环境下仍然下载原图) {
 下载显示原图
 } else {
 下载显示小图
 }
 } else {
 if (缓存中有小图) {
 self.imageView.image = 小图;
 } else {
 self.imageView.image = 占位图片;
 }
 }
 }*/

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (Download)

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
