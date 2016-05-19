//
//  TestPlayerVC.m
//  Framework
//
//  Created by Apple on 16/5/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TestPlayerVC.h"
#import "PlayerView.h"
#import "UIDevice+Extension.h"

@interface TestPlayerVC ()<PlayerViewDelegate>

@property (nonatomic, weak) PlayerView *playerView;

@end

@implementation TestPlayerVC

#pragma mark --------------------------
#pragma mark 懒加载
/** 建议使用懒加载的方式*/
- (PlayerView *)playerView{
    
    if (_playerView == nil) {
        
        PlayerView *playerView = [PlayerView playerView];
        
        //playerView.frame = CGRectMake(5, 300, 300, 200);
        
        NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/57de8272-38a2-4cae-b734-ac55ab528aa8/L.mp4"];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        playerView.playerItem = item;
        
        playerView.delegate = self;
        
        _playerView = playerView;
    }
    return _playerView;
}



#pragma mark --------------------------
#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.playerView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.playerView.frame = self.view.bounds;
}


#pragma mark --------------------------
#pragma mark PlayerViewDelegate
- (void)playerViewDidClickFullScreen:(BOOL)isFull{
    
    if (isFull) {
        //[[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
        //self.playerView.frame = self.view.bounds;

        [UIDevice setLandscapeWithCompletion:^{
            NSLog(@"横屏播放");
        }];

    }else{
        //[[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
        
        //self.playerView.frame = CGRectMake(5, 100, 300, 200);

        [UIDevice setPortraitWithCompletion:^{

            NSLog(@"竖屏播放");
        }];
    }
}



@end
