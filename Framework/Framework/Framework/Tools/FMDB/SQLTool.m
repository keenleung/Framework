//
//  SQLTool.m
//  Framework
//
//  Created by Apple on 16/5/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SQLTool.h"

@interface SQLTool()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation SQLTool

static SQLTool *_instance = nil;

+(instancetype)shareSQLTool{
    SQLTool *instance = [[SQLTool alloc] init];
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
        
        
        // 沙盒位置
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *dbName = [([NSBundle mainBundle].infoDictionary)[@"CFBundleName"] stringByAppendingString:@".sqlite"];
        NSString *dbPath = [path stringByAppendingPathComponent:dbName];
        
        // 创建队列对象
        // 只要创建数据库队列对象, FMDB内部就会自动给我们加载数据库对象
        //NSString *dbPath = @"/Users/apple/Desktop/dbTest/db_test.sqlite";
        _instance.queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];

        NSLog(@"%@", dbPath);
    });
    
    return _instance;
}




+ (void)executeUpdate:(NSString *)sql success:(void (^)(void))successBolck fail:(void (^)(void))failBolck{
    
    [[self shareSQLTool] executeUpdate:sql success:successBolck fail:failBolck];
}

- (void)executeUpdate:(NSString *)sql success:(void (^)(void))successBolck fail:(void (^)(void))failBolck{
    
    // 执行操作
    [self.queue inDatabase:^(FMDatabase *db) {
        
        BOOL result = [db executeUpdate:sql];
        
        if (result && successBolck) {
            successBolck();
            
        }else if(failBolck){
            failBolck();
        }
    }];
}





+ (void)executeQuery:(NSString *)sql resultBlock:(void (^)(FMResultSet *set))resultBlock {
    
    [[self shareSQLTool] executeQuery:sql resultBlock:resultBlock];
}

- (void)executeQuery:(NSString *)sql resultBlock:(void (^)(FMResultSet *set))resultBlock {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *set = [db executeQuery:sql];
        
        if (resultBlock) {
            
            while ([set next]) {
                resultBlock(set);
            }
        }
        
    }];
}





+ (void)executeInTransaction:(NSArray *)sqls success:(void (^)())successBlock fail:(void (^)())failBlock{
    
    [[self shareSQLTool] executeInTransaction:sqls success:successBlock fail:failBlock];
}

- (void)executeInTransaction:(NSArray *)sqls success:(void (^)())successBlock fail:(void (^)())failBlock{
    
    __block BOOL flag = true;
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [sqls enumerateObjectsUsingBlock:^(NSString *sql, NSUInteger index, BOOL * _Nonnull stop) {
            
            BOOL result = [db executeUpdate:sql];
            
            if (!result) {
                
                flag = false;
                
                *stop = YES;
            }
        }];
        
        if (!flag) {
            
            *rollback = true;
        }
        
    }];
    
    if (flag) {
        if (successBlock) {
            successBlock();
        }
    }else{
        
        if (failBlock) {
            failBlock();
        }
    }
}




+ (void)executeInStatements:(NSArray *)sqls resultBlock:(void(^)(NSDictionary *dict))resultBlock{
    
    [[self shareSQLTool] executeInStatements:sqls resultBlock:resultBlock];
}

- (void)executeInStatements:(NSArray *)sqls resultBlock:(void(^)(NSDictionary *dict))resultBlock{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        [sqls enumerateObjectsUsingBlock:^(NSString *sql, NSUInteger index, BOOL * _Nonnull stop) {
            
            [db executeStatements:sql withResultBlock:^int(NSDictionary *resultsDictionary) {
                
                if (resultBlock) {
                    resultBlock(resultsDictionary);
                }
                
                return 0;
            }];
            
        }];
        
        
    }];
}
@end
