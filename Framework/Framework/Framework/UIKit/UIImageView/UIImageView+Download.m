//
//  UIImageView+Download.m
//  Framework
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIImageView+Download.h"

/** 
 用户的偏好Key：在3G\4G环境是否仍然下载原图
 */
static NSString * const alwaysDownloadOriginalImagekey = @"alwaysDownloadOriginalImage";

@implementation UIImageView (Download)

#pragma mark ---------- 有 progress ----------------

-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL placehloderImage:(UIImage *)placehloderImage options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock{
    
    // 从内存/沙盒缓存中获取原图
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageUrl];
    
    if (originalImage) { // 如果内存/沙盒缓存中有原图，则直接显示原图，不管现在是什么网络状态
        
        [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placehloderImage options:options progress:progressBlock completed:completedBlock];
        
    }else{ // 内存/沙盒缓存中没有原图，则根据网络状态获取图片
        
        AFNetworkReachabilityManager *netMgr = [AFNetworkReachabilityManager sharedManager];
        
        if (netMgr.isReachableViaWiFi) { // wifi下，直接下载原图
            
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placehloderImage options:options progress:progressBlock completed:completedBlock];
            
        }else if(netMgr.isReachableViaWWAN){ // 手机自带网络（3G/4G）
            
            // 获取用户配置，判断是否在手机自带网络下都下载原图
#warning 从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:alwaysDownloadOriginalImagekey];
            
            if (alwaysDownloadOriginalImage) {
                
                // 下载原图
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placehloderImage options:options progress:progressBlock completed:completedBlock];
            }else{
                
                // 下载小图
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placehloderImage options:options progress:progressBlock completed:completedBlock];
            }
            
        }else{ // 没有网络
            
            // 从内存/沙盒缓存中获取小图，如果有小图，则显示小图；没有小图，则显示占位图
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            
            if (thumbnailImage) { // 有小图
                
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placehloderImage options:options progress:progressBlock completed:completedBlock];
                
            }else{ // 没有小图
                
                [self sd_setImageWithURL:nil placeholderImage:placehloderImage options:options progress:progressBlock completed:completedBlock];
            }
        }
    }
}

-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL placehloderImage:(UIImage *)placehloderImage progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock{
    
    [self setImageWithOriginalImageUrl:originalImageUrl thumbnailImageURL:thumbnailImageURL placehloderImage:placehloderImage options:0 progress:progressBlock completed:completedBlock];
}

-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL  options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock{
    
    [self setImageWithOriginalImageUrl:originalImageUrl thumbnailImageURL:thumbnailImageURL placehloderImage:nil options:options progress:progressBlock completed:completedBlock];
}


-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL  progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock{
    
    [self setImageWithOriginalImageUrl:originalImageUrl thumbnailImageURL:thumbnailImageURL placehloderImage:nil options:0 progress:progressBlock completed:completedBlock];
}



#pragma mark ----------- 不包含 进度---------------

-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL placehloderImage:(UIImage *)placehloderImage completed:(SDWebImageCompletionBlock)completedBlock{
    
    // 从内存/沙盒缓存中获取原图
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageUrl];
    
    if (originalImage) { // 如果内存/沙盒缓存中有原图，则直接显示原图，不管现在是什么网络状态
        
        [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placehloderImage completed:completedBlock];
        
    }else{ // 内存/沙盒缓存中没有原图，则根据网络状态获取图片
        
        AFNetworkReachabilityManager *netMgr = [AFNetworkReachabilityManager sharedManager];
        
        if (netMgr.isReachableViaWiFi) { // wifi下，直接下载原图
            
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placehloderImage completed:completedBlock];
            
        }else if(netMgr.isReachableViaWWAN){ // 手机自带网络（3G/4G）
            
            // 获取用户配置，判断是否在手机自带网络下都下载原图
#warning 从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:alwaysDownloadOriginalImagekey];
            
            if (alwaysDownloadOriginalImage) {
                
                // 下载原图
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placehloderImage completed:completedBlock];
            }else{
                
                // 下载小图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placehloderImage completed:completedBlock];
            }
            
        }else{ // 没有网络
            
            // 从内存/沙盒缓存中获取小图，如果有小图，则显示小图；没有小图，则显示占位图
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            
            if (thumbnailImage) { // 有小图
                
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placehloderImage completed:completedBlock];
                
            }else{ // 没有小图
                
                [self sd_setImageWithURL:nil placeholderImage:placehloderImage completed:completedBlock];
            }
        }
    }
}

-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL{
    
    [self setImageWithOriginalImageUrl:originalImageUrl thumbnailImageURL:thumbnailImageURL placehloderImage:nil completed:nil];
}

-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL placehloderImage:(UIImage *)placehloderImage{
    
    [self setImageWithOriginalImageUrl:originalImageUrl thumbnailImageURL:thumbnailImageURL placehloderImage:placehloderImage completed:nil];
}

-(void) setImageWithOriginalImageUrl: (NSString *)originalImageUrl thumbnailImageURL:(NSString *)thumbnailImageURL completed:(SDWebImageCompletionBlock)completedBlock{
    
    [self setImageWithOriginalImageUrl:originalImageUrl thumbnailImageURL:thumbnailImageURL placehloderImage:nil completed:completedBlock];
}


@end
