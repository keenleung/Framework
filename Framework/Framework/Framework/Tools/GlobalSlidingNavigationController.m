//
//  GlobalSlidingNavigationController.m
//  Framework
//
//  Created by Apple on 16/4/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GlobalSlidingNavigationController.h"

@interface GlobalSlidingNavigationController()<UIGestureRecognizerDelegate>

@end

@implementation GlobalSlidingNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    NSLog(@"viewDidLoad --- %@", self);
    
    // 设置全局滑动
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    pan.delegate = self;
    
    self.interactivePopGestureRecognizer.enabled = NO;
}

/** 设置全局返回按钮*/
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 重写这个方法, 系统的侧滑就无效了, 需要手动设置侧滑
    
    // 根控制器不需要返回按钮
    if (self.childViewControllers.count > 0) {
        
        // 设置返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState: UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn.png"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick.png"] forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        [backButton sizeToFit];
        
        // 设置边距
        [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
        
        // 设置
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void) back{
    
    [self popViewControllerAnimated:YES];
}

#pragma mark --------------------------
#pragma mark UIGestureRecognizerDelegate
// 恢复系统侧滑
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    // 非根控制器才有侧滑
    return self.childViewControllers.count > 1;
}

@end
