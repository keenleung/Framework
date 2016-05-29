//
//  TestVC.m
//  12-VCTransitionTest
//
//  Created by Apple on 16/5/29.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//

#import "TestTransitionVC.h"
#import "UIViewController+Transition.h"

@interface TestTransitionVC ()

@end

@implementation TestTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //[self popVC];
    [self.navigationController popVC];
}
@end
