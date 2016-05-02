//
//  FPSLabel.m
//  Framework
//
//  Created by Apple on 16/4/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "FPSLabel.h"

@interface FPSLabel()

@property (nonatomic, strong) CADisplayLink     *link;

@property (nonatomic, assign) NSUInteger        count;

@property (nonatomic, assign) NSTimeInterval    lastTime;

@end

@implementation FPSLabel

static FPSLabel *_instance = nil;

+(instancetype)shareFPS{
    
    FPSLabel *instance = [[FPSLabel alloc] init];
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size = CGSizeMake(55, 20);
    if (self = [super initWithFrame: frame])
    {
        // 显示属性
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = false;
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithWhite: 0 alpha: 0.7];
        self.font = [UIFont fontWithName: @"Menlo" size: 14];
        
        // 监听帧变化
        __weak typeof(self) weakSelf = self;
        self.link = [CADisplayLink displayLinkWithTarget: weakSelf selector: @selector(tick:)];
        [self.link addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
        
        // 初始值
        self.text = @"0FPS";
    }
    return self;
}

- (void)tick:(CADisplayLink *)link {
    if (self.lastTime == 0)
    {
        self.lastTime = link.timestamp;
        return;
    }
    
    self.count++;
    NSTimeInterval delta = link.timestamp - self.lastTime;
    if (delta < 1)
        return;
    self.lastTime = link.timestamp;
    double fps = self.count / delta;
    _count = 0;
    
    double progress = fps / 60.0;
    self.textColor = [UIColor colorWithHue: 0.27 * (progress - 0.2) saturation: 1 brightness: 0.9 alpha: 1];
    self.text = [NSString stringWithFormat: @"%dFPS", (int)(fps + 0.5)];
}

+ (void) showAtPoint: (CGPoint)point{
    
    FPSLabel *instance = [self shareFPS];
    instance.center = point;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication].keyWindow addSubview:instance];
        
    });
    
}

+ (void) dismiss{
    
    [[self shareFPS] removeFromSuperview];
}

@end
