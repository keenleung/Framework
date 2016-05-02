//
//  FileManager.m
//  Framework
//
//  Created by Apple on 16/4/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

#pragma mark --------------------------
#pragma mark 文件夹操作

+ (BOOL) directoryExistsAtPath: (NSString *)directoryPath{
    
    // 文件管理器
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 判断 directoryPath 是否有效
    BOOL isDirectory = YES;
    BOOL isExist = YES;
    
    isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory){
        
        return false;
    }
    
    return true;
}

+ (NSInteger) getDirectorySizeAtPath: (NSString *)directoryPath{
    
    // 思路: 文件夹的尺寸 = 获取这个文件夹中所有文件路径,然后累加
    
    // 文件管理器
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 判断 directoryPath 是否有效
    if (![self directoryExistsAtPath:directoryPath]) {
        
        // 报错
        NSException *error = [NSException exceptionWithName:@"Directory Path Error" reason:@"文件夹路径不存在或该路径不是文件夹路径" userInfo:nil];
        
        // 抛出错误
        [error raise];
    }
    
    // 获取指定路径下的所有子文件
    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
    __block NSInteger totalSize= 0;
    
    // 遍历
    [subPaths enumerateObjectsUsingBlock:^(NSString *subpath, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 拼接路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subpath];
        
        // 排除文件夹和隐藏的文件
        BOOL isDirectory = YES;
        BOOL fileExist = YES;
        
        fileExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if (fileExist && !isDirectory && ![filePath containsString:@".DS"]) {
            
            //NSLog(@"%@", filePath);
            
            // 获取文件属性
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            unsigned long long size = [attr fileSize];
            
            totalSize += size;
        }
    }];
    
    return totalSize;
}

+ (NSString *)getDirectorySizeStringAtPath :(NSString *)directoryPath{
    
    NSInteger size = [self getDirectorySizeAtPath:directoryPath];
    
    NSString *str = @"";
    CGFloat totalSizeF = 0;
    
    if (size > 1000.0 * 1000.0 * 1000.0) { // GB
        
        totalSizeF = size / 1000.0 / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%.1lfGB",totalSizeF];
        
    }else if (size > 1000.0 * 1000.0) { // MB
        
        totalSizeF = size / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%.1lfMB",totalSizeF];
        
    }else if(size > 1000.0){ // KB
        
        totalSizeF = size / 1000.0;
        str = [NSString stringWithFormat:@"%.1lfKB",totalSizeF];
        
    }else{
        
        totalSizeF = size;
        str = [NSString stringWithFormat:@"%.1lfb",totalSizeF];
    }
    
    return str;
}

+ (void) removeDirectoryAtPath: (NSString *)directoryPath{
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 判断 directoryPath 是否有效
    // 判断 directoryPath 是否有效
    if (![self directoryExistsAtPath:directoryPath]) {
        
        // 报错
        NSException *error = [NSException exceptionWithName:@"Directory Path Error" reason:@"文件夹路径不存在或该路径不是文件夹路径" userInfo:nil];
        
        // 抛出错误
        [error raise];
    }
    
    // 获取文件夹下一级目录
    NSArray *subpaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    // 拼接文件夹路径, 清除
    [subpaths enumerateObjectsUsingBlock:^(NSString *subpath, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
        
        [mgr removeItemAtPath:path error:nil];
    }];
}



#pragma mark --------------------------
#pragma mark 缓存操作
+ (NSString *)getCacheSizeString{
    
    return [self getDirectorySizeStringAtPath:cachesDirectory];
}

+ (void) clearCache{
    
    return [self removeDirectoryAtPath:cachesDirectory];
}


@end
