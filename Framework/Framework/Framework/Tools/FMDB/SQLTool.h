//
//  SQLTool.h
//  Framework
//
//  Created by Apple on 16/5/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

// 使用 FMDB 操作 sqlite
// 需要导入 libsqlite3.0.tbd 框架

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface SQLTool : NSObject

#pragma mark --------------------------
#pragma mark 单例

/**
 *  获取单例对象
 *
 *  @return SQLTool的单例对象
 */
+(instancetype)shareSQLTool;

#pragma mark --------------------------
#pragma mark 对象方法

/**
 *  执行 增加/删除/修改/创建/销毁 等操作
 *
 *  @param sql          sql 语句
 *  @param successBolck 成功执行的 block
 *  @param failBolck    失败执行的 block
 */
- (void)executeUpdate:(NSString *)sql success:(void (^)(void))successBolck fail:(void (^)(void))failBolck;

/**
 *  执行 查询 操作
 *
 *  @param sql         sql 语句
 *  @param resultBlock 每条记录,使用[set stringForColumn:@"columnName"]等方式获取值
 */
- (void)executeQuery:(NSString *)sql resultBlock:(void (^)(FMResultSet *set))resultBlock;

/**
 *  执行 事务
 *
 *  @param sqls         sql 语句集合
 *  @param successBlock 成功执行的 block
 *  @param failBlock    失败执行的 block
 */
- (void)executeInTransaction:(NSArray *)sqls success:(void (^)())successBlock fail:(void (^)())failBlock;

/**
 *  执行 statements, 即一条 sql 语句中可以包括多个操作, 每个操作用分号;分隔
 *
 *  @param sqls        sql 语句集合
 *  @param resultBlock 结果
 */
- (void)executeInStatements:(NSArray *)sqls resultBlock:(void(^)(NSDictionary *dict))resultBlock;


#pragma mark --------------------------
#pragma mark 类方法

/**
 *  执行 增加/删除/修改/创建/销毁 等操作
 *
 *  @param sql          sql 语句
 *  @param successBolck 成功执行的 block
 *  @param failBolck    失败执行的 block
 */
+ (void)executeUpdate:(NSString *)sql success:(void (^)(void))successBolck fail:(void (^)(void))failBolck;

/**
 *  执行 查询 操作
 *
 *  @param sql         sql 语句
 *  @param resultBlock 每条记录,使用[set stringForColumn:@"columnName"]等方式获取值
 */
+ (void)executeQuery:(NSString *)sql resultBlock:(void (^)(FMResultSet *set))resultBlock;

/**
 *  执行 事务
 *
 *  @param sqls         sql 语句集合
 *  @param successBlock 成功执行的 block
 *  @param failBlock    失败执行的 block
 */
+ (void)executeInTransaction:(NSArray<NSString *> *)sqls success:(void (^)())successBlock fail:(void (^)())failBlock;

/**
 *  执行 statements, 即一条 sql 语句中可以包括多个操作, 每个操作用分号;分隔
 *
 *  @param sqls        sql 语句集合
 *  @param resultBlock 结果
 */
+ (void)executeInStatements:(NSArray<NSString *> *)sqls resultBlock:(void(^)(NSDictionary *dict))resultBlock;


@end
