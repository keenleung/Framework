//
//  StatusBarHubTestVC.m
//  Framework
//
//  Created by Apple on 16/5/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "StatusBarHubTestVC.h"
#import "StatusBarHub.h"

@interface StatusBarHubTestVC ()

@end

@implementation StatusBarHubTestVC

- (IBAction)successClicked:(id)sender {
    [StatusBarHub showSuccess:@"success"];
}

- (IBAction)errorClicked:(id)sender {
    [StatusBarHub showError:@"error"];
}

- (IBAction)loadingClicked:(id)sender {
    [StatusBarHub showLoading:@"正努力加载..."];
}

- (IBAction)hideClicked:(id)sender {
    [StatusBarHub hide];
}


@end
