//
//  UIViewController+Transition.m
//  TowVCTest
//
//  Created by Apple on 16/5/29.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//

#import "UIViewController+Transition.h"
#import <objc/message.h>

static const NSTimeInterval timeInterval = 0.5;

@interface UIViewController ()

/** 记录上一个控制器*/
@property UIViewController *previousVC;

@end

@implementation UIViewController (Transition)

#pragma mark --------------------------
#pragma mark push 操作

- (void)pushVC:(UIViewController *)vc withDuraction:(NSTimeInterval)duration block1:(void (^)())block1 block2:(void (^)())block2{
    
    // 添加子控制器
    [self addChildViewController:vc];
    
    // 设置子控制器的 frame
    vc.view.frame = self.view.bounds;
    
    // 子控制器的 view 位于屏幕的外面
    block1();
    
    // 添加子控制器的 view
    [self.view addSubview:vc.view];
    
    // 记录当前控制器的frame
    CGRect nav_originalFrame = self.view.frame;
    
    if (duration == NSNotFound || duration <0) {
        
        duration = timeInterval;
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        // 移动当前控制器的 view
        block2();
        
    } completion:^(BOOL finished) {
        
        // 把当前控制器的 view 恢复至原始位置
        self.view.frame = nav_originalFrame;
        
        // 修改子控制器 view 的位置, 让子控制器的 view 显示在当前控制器的最上面
        vc.view.frame = nav_originalFrame;
    }];
    
    vc.previousVC = self;
    
}

- (void)pushVC:(UIViewController *)vc withDuration:(NSTimeInterval)duration{
    
    [self pushVC:vc withDuraction:duration block1:^{
        
        CGRect frame = vc.view.frame;
        frame.origin.x = self.view.bounds.size.width;
        vc.view.frame = frame;
        
    } block2:^{
        
        CGRect frame = self.view.frame;
        frame.origin.x = - self.view.bounds.size.width;
        self.view.frame = frame;
    }];
}

- (void)pushVC:(UIViewController *)vc{
    
    [self pushVC:vc withDuration:timeInterval];
}

- (void)pushVCFromLeft:(UIViewController *)vc{
    
    [self pushVCFromLeft:vc withDuration:timeInterval];
}

- (void)pushVCFromLeft:(UIViewController *)vc withDuration:(NSTimeInterval)duration{
    
    [self pushVC:vc withDuraction:duration block1:^{
        
        CGRect frame = vc.view.frame;
        frame.origin.x = -self.view.bounds.size.width;
        vc.view.frame = frame;
        
    } block2:^{
        
        CGRect frame = self.view.frame;
        frame.origin.x = self.view.bounds.size.width;
        self.view.frame = frame;
        
    }];
}

- (void)pushVCFromRight:(UIViewController *)vc{
    
    [self pushVC:vc];
}

- (void)pushVCFromRight:(UIViewController *)vc withDuration:(NSTimeInterval)duration{
    
    [self pushVC:vc withDuration:duration];
}

- (void)pushVCFromTop:(UIViewController *)vc{
    
    [self pushVCFromTop:vc withDuration:timeInterval];
}

- (void)pushVCFromTop:(UIViewController *)vc withDuration:(NSTimeInterval)duration{
    
    [self pushVC:vc withDuraction:duration block1:^{
        
        CGRect frame = vc.view.frame;
        frame.origin.y = -self.view.bounds.size.height;
        vc.view.frame = frame;
        
    } block2:^{
        
        CGRect frame = self.view.frame;
        frame.origin.y = self.view.bounds.size.height;
        self.view.frame = frame;
        
    }];
}

- (void)pushVCFromBotton:(UIViewController *)vc{
    
    [self pushVCFromBotton:vc withDuration:timeInterval];
}

- (void)pushVCFromBotton:(UIViewController *)vc withDuration:(NSTimeInterval)duration{
    
    
    [self pushVC:vc withDuraction:duration block1:^{
        
        CGRect frame = vc.view.frame;
        frame.origin.y = self.view.bounds.size.height;
        vc.view.frame = frame;
        
    } block2:^{
        
        CGRect frame = self.view.frame;
        frame.origin.y = -self.view.bounds.size.height;
        self.view.frame = frame;
    }];
}



#pragma mark --------------------------
#pragma mark pop 操作

- (void)popVCWithBlock:(void (^)(CGRect nav_originalFrame))block andDuration:(NSTimeInterval)duration{
    
    // 记录上一个控制器的 frame
    CGRect nav_originalFrame = self.previousVC.view.frame;
    
    block(nav_originalFrame);
    
    if (duration == NSNotFound || duration<0) {
        duration = timeInterval;
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        // 恢复上一个控制器的 frame
        self.previousVC.view.frame = nav_originalFrame;
        
    } completion:^(BOOL finished) {
        
        // 清理子控制器以及它的 view
        [self clear];
    }];
}

- (void)popVCWithDudation:(NSTimeInterval)duration{
    
    [self popVCWithBlock:^(CGRect nav_originalFrame) {
        
        // 修改上一个控制器的 frame
        CGRect frame = nav_originalFrame;
        frame.origin.y = -self.previousVC.view.frame.size.height;
        self.previousVC.view.frame = frame;
        
        // 修改当前 view 的 frame, 使得在屏幕上可以看得到
        frame.origin.y = self.previousVC.view.frame.size.height;
        self.view.frame = frame;
        
    } andDuration:duration];
    
    
}

- (void)popVC{
    
    [self popVCFromLeftWithDuration:timeInterval];
}

- (void)popVCFromTopWithDuration:(NSTimeInterval)duration{
    
    [self popVCWithDudation:duration];
}

- (void)popVCFromTop{
    
    [self popVCFromTopWithDuration:timeInterval];
}

- (void)popVCFromBottomWithDuration:(NSTimeInterval)duration{
    
    [self popVCWithBlock:^(CGRect nav_originalFrame) {
        
        CGRect frame = nav_originalFrame;
        frame.origin.y = self.previousVC.view.frame.size.height;
        self.previousVC.view.frame = frame;
        
        frame.origin.y = -self.previousVC.view.frame.size.height;
        self.view.frame = frame;
        
    } andDuration:duration];
}

- (void)popVCFromBottom{
    
    [self popVCFromBottomWithDuration:timeInterval];
}

- (void)popVCFromLeftWithDuration:(NSTimeInterval)duration{
    
    [self popVCWithBlock:^(CGRect nav_originalFrame) {
        
        CGRect frame = nav_originalFrame;
        frame.origin.x = -self.previousVC.view.frame.size.width;
        self.previousVC.view.frame = frame;
        
        frame.origin.x = self.previousVC.view.frame.size.width;
        self.view.frame = frame;
        
    } andDuration:duration];
}

- (void)popVCFromLeft{
    
    [self popVCFromLeftWithDuration:timeInterval];
}

- (void)popVCFromRightWithDuration:(NSTimeInterval)duration{
    
    [self popVCWithBlock:^(CGRect nav_originalFrame) {
        
        CGRect frame = nav_originalFrame;
        frame.origin.x = self.previousVC.view.frame.size.width;
        self.previousVC.view.frame = frame;
        
        frame.origin.x = -self.previousVC.view.frame.size.width;
        self.view.frame = frame;
        
    } andDuration:duration];
}

- (void)popVCFromRight{
    
    [self popVCFromRightWithDuration:timeInterval];
}

#pragma mark --------------------------
#pragma mark 清理

/** 清理工作*/
- (void)clear{
    
    self.view = nil;
    
    NSMutableArray *childVCs = [NSMutableArray arrayWithArray:self.previousVC.childViewControllers];
    [childVCs enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull childVC, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([childVC isKindOfClass:[self class]]) {
            [childVCs removeObject:childVC];
        }
    }];
}

#pragma mark --------------------------
#pragma mark rumtime 动态加载属性
- (void)setPreviousVC:(UIViewController *)previousVC{
    
    objc_setAssociatedObject(self, "previousVC", previousVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)previousVC{
    
    return objc_getAssociatedObject(self, "previousVC");
}


@end
