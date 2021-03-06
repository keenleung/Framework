//
//  FileManager.h
//  Framework
//
//  Created by Apple on 16/4/7.
//  Copyright © 2016年 Apple. All rights reserved.
//  文件操作

#pragma mark --------------------------
#pragma mark 说明: 文件 和 文件夹 操作

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/**
 *  缓存路径 CachesDirectory
 */
#define cachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface FileManager : NSObject

#pragma mark --------------------------
#pragma mark 文件夹操作

/**
 *  判断 文件夹 是否存在
 *
 *  @param directoryPath 文件夹 全路径
 *
 *  @return  BOOL
 */
+ (BOOL) directoryExistsAtPath: (NSString *)directoryPath;

/**
 *   获取指定 文件夹 的大小(字节 b)
 *
 *  @param directoryPath 文件夹 全路径
 *
 *  @return 文件夹的大小(字节 b)
 */
+ (NSInteger) getDirectorySizeAtPath: (NSString *)directoryPath;

/**
 *  获取指定 文件夹 的大小, 以字符串的形式展示
 *
 *  @param directoryPath 文件夹 全路径
 *
 *  @return 文件夹的大小(字符串)
 */
+ (NSString *)getDirectorySizeStringAtPath :(NSString *)directoryPath;

/**
 *  清除指定 文件夹 下的所有文件
 *
 *  @param directoryPath 文件夹全路径
 */
+ (void) removeDirectoryAtPath: (NSString *)directoryPath;

#pragma mark --------------------------
#pragma mark 缓存操作
/**
 *  获取缓存大小
 *
 *  @return 缓存文件夹的大小(字符串)
 */
+ (NSString *)getCacheSizeString;

/**
 *  清除缓存
 */
+ (void) clearCache;

@end
