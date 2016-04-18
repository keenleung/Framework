//
//  UIApplication+Function.m
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIApplication+Function.h"

@implementation UIApplication (Function)

+ (void) openUrl: (NSString *)urlStr{
    
    UIApplication *application = [self sharedApplication];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    if ([application canOpenURL:url]) {
        
        [application openURL:url];
    }
}

@end
