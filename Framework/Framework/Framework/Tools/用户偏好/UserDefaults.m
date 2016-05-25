//
//  UserDefaults.m
//  Framework
//
//  Created by Apple on 16/5/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+ (nullable id)objectForKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+ (void)setObject:(nullable id)value forKey:(NSString *)key{
    
    if (key) {
        
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
