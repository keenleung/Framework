//
//  BubbleMenuVC.m
//  Framework
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "BubbleMenuVC.h"

@interface BubbleMenuVC ()

@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation BubbleMenuVC

-(NSMutableArray *)items {
    if(!_items) {
        _items = [NSMutableArray array];
        _items = [@[
                    [BubbleMenuItem menuItem:@" 扫一扫"
                                       image:[UIImage imageNamed:@"BubbleMenu.bundle/iconfont-saoyisao"]
                                         tag:100
                                    userInfo:@{@"title":@"Menu"}],
                    [BubbleMenuItem menuItem:@" 最近订单"
                                       image:[UIImage imageNamed:@"BubbleMenu.bundle/iconfont-dingdan01"]
                                         tag:101
                                    userInfo:@{@"title":@"Menu"}],
                    [BubbleMenuItem menuItem:@" 收藏快递员"
                                       image:[UIImage imageNamed:@"BubbleMenu.bundle/iconfont-shoucang-(1)"]
                                         tag:102
                                    userInfo:@{@"title":@"Menu"}]
                    
                    ] mutableCopy];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BubbleMenuDemo";
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self initNavigationBar];
}

- (void)initNavigationBar{
    
    UIButton *rightItemButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 20, 40)];
    [rightItemButton setImage:[UIImage imageNamed:@"BubbleMenu.bundle/home_navigation_right"] forState:UIControlStateNormal];
    [rightItemButton addTarget:self action:@selector(rightBarButtonItemAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightItemButton];
}

- (void)rightBarButtonItemAction{
    
    [BubbleMenu setTintColor:[UIColor whiteColor]];
    [BubbleMenu setBackgrounColorEffect:BubbleMenuBackgrounColorEffectGradient];
    if ([BubbleMenu isShow]){
        [BubbleMenu dismissMenu];
    } else {

        [BubbleMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 30, 64, 0, 0) menuItems:self.items selected:^(NSInteger index, BubbleMenuItem *item) {

            UIViewController *vc = [[UIViewController alloc] init];

            if (item.tag == 100) {
                vc.view.backgroundColor = [UIColor yellowColor];
                vc.title = @"扫一扫";

            } else if(item.tag == 101) {
                vc.view.backgroundColor = [UIColor blueColor];
                vc.title = @"最近订单";

            } else if (item.tag == 102) {
                vc.view.backgroundColor = [UIColor darkGrayColor];
                vc.title = @"最近收藏";
            }

            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
}

@end
