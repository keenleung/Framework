//
//  GlobalMacro.h
//  Framework
//
//  Created by Apple on 16/4/5.
//  Copyright © 2016年 Apple. All rights reserved.
//  常用宏 收集

#pragma mark --------------------------
#pragma mark 常用宏 收集

#pragma mark --------------------------
#pragma mark 屏幕宽度和高度
/** 屏幕宽度和高度*/
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

#pragma mark --------------------------
#pragma mark 手机类型 iphone4,iphone5,iphone6,iphone6Plus
/** 手机类型*/
#define iphone6P (ScreenH == 736)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)


/** From ConciseKitSpecs*/
#define eql(a,b)   [(a) isEqual:(b)]

#define $arr(...)   [NSArray arrayWithObjects:__VA_ARGS__, nil]
#define $marr(...)  [NSMutableArray arrayWithObjects:__VA_ARGS__, nil]
#define $marrnew    [NSMutableArray array]
#define $set(...)   [NSSet setWithObjects:__VA_ARGS__, nil]
#define $mset(...)  [NSMutableSet setWithObjects:__VA_ARGS__, nil]
#define $msetnew    [NSMutableSet set]
#define $dict(...)  [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define $mdict(...) [NSMutableDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define $mdictnew   [NSMutableDictionary dictionary]
#define str(...)   [NSString stringWithFormat:__VA_ARGS__]
#define mstr(...)  [NSMutableString stringWithFormat:__VA_ARGS__]
#define $mstrnew    [NSMutableString string]

#define $bool(val)      [NSNumber numberWithBool:(val)]
#define $char(val)      [NSNumber numberWithChar:(val)]
#define $double(val)    [NSNumber numberWithDouble:(val)]
#define $float(val)     [NSNumber numberWithFloat:(val)]
#define $int(val)       [NSNumber numberWithInt:(val)]
#define $integer(val)   [NSNumber numberWithInteger:(val)]
#define $long(val)      [NSNumber numberWithLong:(val)]
#define $longlong(val)  [NSNumber numberWithLongLong:(val)]
#define $short(val)     [NSNumber numberWithShort:(val)]
#define $uchar(val)     [NSNumber numberWithUnsignedChar:(val)]
#define $uint(val)      [NSNumber numberWithUnsignedInt:(val)]
#define $uinteger(val)  [NSNumber numberWithUnsignedInteger:(val)]
#define $ulong(val)     [NSNumber numberWithUnsignedLong:(val)]
#define $ulonglong(val) [NSNumber numberWithUnsignedLongLong:(val)]
#define $ushort(val)    [NSNumber numberWithUnsignedShort:(val)]

#define $nonretained(val) [NSValue valueWithNonretainedObject:(val)]
#define $pointer(val)     [NSValue valueWithPointer:(val)]
#define $point(val)       [NSValue valueWithPoint:(val)]
#define $range(val)       [NSValue valueWithRange:(val)]
#define $rect(val)        [NSValue valueWithRect:(val)]
#define $size(val)        [NSValue valueWithSize:(val)]

#define safe(obj)        ((NSNull *)(obj) == [NSNull null] ? nil : (obj))

#define OBJ(...) [[__VA_ARGS__ alloc] init]



