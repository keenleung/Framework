//
//  ViewController.m
//  12-VCTransitionTest
//
//  Created by Apple on 16/5/29.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//

#import "TestTransitionMainVC.h"
#import "TestTransitionVC.h"
#import "UIViewController+Transition.h"

@interface TestTransitionMainVC ()

@end

@implementation TestTransitionMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.title = @"第一个控制器";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    TestTransitionVC *vc = [[TestTransitionVC alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.title = @"第二个控制器";
    

    //[self.navigationController pushVC:navVC];
    [self.navigationController pushVCFromTop:navVC withDuration:1.5];
}

@end
