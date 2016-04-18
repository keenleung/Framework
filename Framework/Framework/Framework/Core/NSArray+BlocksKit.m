//
//  NSArray+BlocksKit.m
//  Framework
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSArray+BlocksKit.h"

@implementation NSArray (BlocksKit)

- (void)each_:(void (^)(id _Nonnull obj))block{
    
    // 如果不满足条件: block != nil, 程序就会抛错
    NSParameterAssert(block != nil);
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 执行 block
        block(obj);
    }];
}

- (void)apply_:(void (^)(id obj))block{
    
    // 如果不满足条件: block != nil, 程序就会抛错
    NSParameterAssert(block != nil);
    
    [self enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        block(obj);
    }];
}

- (id)match_:(BOOL (^)(id obj))block{
    
    // 如果不满足条件: block != nil, 程序就会抛错
    NSParameterAssert(block != nil);
    
    NSInteger index = [self indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        return block(obj);
    }];
    
    if (index == NSNotFound)
        return nil;
    else
        return self[index];
}

-(NSArray *)select_:(BOOL (^)(id obj))block{
    
    NSParameterAssert(block != nil);
    
    return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        return block(obj);
    }]];
}

- (NSArray *)reject_:(BOOL (^)(id obj))block{
    
    NSParameterAssert(block != nil);
    
    return [self select_:^BOOL(id obj) {
        
        return !block(obj);
    }];
}

- (NSArray *)map_:(id (^)(id obj))block{
    
    NSParameterAssert(block != nil);
    
    NSMutableArray *result= [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id value = block(obj) ?: [NSNull null];
        [result addObject:value];
    }];
    
    return result;
}

- (NSArray *)compact_:(id (^)(id obj))block{
    
    NSParameterAssert(block != nil);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id value = block(obj);
        if (value) {
            [result addObject:value];
        }
    }];
    
    return result;
}

@end
