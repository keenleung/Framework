//
//  PlayerView.h
//  02-播放远程视频-封装播放器
//
//  Created by keen on 16/5/10.
//  Copyright © 2016年 keenleung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#pragma mark --------------------------
#pragma mark 协议
@protocol PlayerViewDelegate <NSObject>

@optional

/**
 *  点击了全屏按钮后要做的操作
 *
 *  @param isFull  YES:表示全屏, NO:不是全屏
 */
- (void)playerViewDidClickFullScreen:(BOOL)isFull;

@end


#pragma mark --------------------------
#pragma mark PlayerView

@interface PlayerView : UIView

+ (instancetype)playerView;

/** 代理*/
@property (weak, nonatomic) id<PlayerViewDelegate> delegate;

/** 播放的视频*/
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end
