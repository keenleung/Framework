//
//  TableViewController.m
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TableViewController.h"
#import "UIColor+Hex.h"
#import "UITableView+Section.h"
#import "UIColor+Extension.h"

@implementation TableViewController

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //self.tableView.backgroundColor = HexColor(215, 215, 215);
    self.tableView.backgroundColor = [UIColor redColor];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.tableView.backgroundColor = self.tableView.backgroundColor.alphaValue_Bock(0.75);
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    
//    [self.tableView setSectionMarginHeight:20];
//    [self.tableView reloadData];
//}

@end
