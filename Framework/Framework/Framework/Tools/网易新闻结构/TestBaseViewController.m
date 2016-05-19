//
//  TestBaseViewController.m
//  Framework
//
//  Created by Apple on 16/5/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TestBaseViewController.h"

@interface TestBaseViewController ()

@end

@implementation TestBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加所有子控制器
    [self setupAllChildViewController];
}


#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    // 头条
    UIViewController *toplVc = [[UIViewController alloc] init];
    toplVc.title = @"头条";
    [self addChildViewController:toplVc];
    
    // 热点
    UIViewController *hotVc = [[UIViewController alloc] init];
    hotVc.title = @"热点";
    [self addChildViewController:hotVc];
    
    // 视频
    UIViewController *videoVc = [[UIViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 社会
    UIViewController *scietyVc = [[UIViewController alloc] init];
    scietyVc.title = @"社会";
    [self addChildViewController:scietyVc];
    
    // 订阅
    UIViewController *readerVc = [[UIViewController alloc] init];
    readerVc.title = @"订阅";
    [self addChildViewController:readerVc];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.title = @"vc1";
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.title = @"vc2";
    [self addChildViewController:vc2];
    
    // 科技
    UIViewController *scienceVc = [[UIViewController alloc] init];
    scienceVc.title = @"科技";
    [self addChildViewController:scienceVc];
    
}

@end
