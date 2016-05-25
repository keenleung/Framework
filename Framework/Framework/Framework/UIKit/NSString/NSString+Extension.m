//
//  NSString+Extension.m
//  Framework
//
//  Created by Apple on 16/5/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *) encodeURL {
    /*
     NSString* escapedUrlString= (NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)self, NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
     escapedUrlString = [escapedUrlString stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
     return escapedUrlString;
     */
    
    //return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLHostAllowedCharacterSet];
}

- (NSString *)decodeURL{

    return [self stringByRemovingPercentEncoding];
}


@end
