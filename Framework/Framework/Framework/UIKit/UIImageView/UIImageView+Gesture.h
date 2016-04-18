//
//  UIImageView+Gesture.h
//  Framework
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Gesture)

/**
 *  添加 点按 手势
 *
 *  @param target An object that is the recipient of action messages sent by the receiver when it recognizes a gesture. nil is not a valid value.
 *  @param action A selector that identifies the method implemented by the target to handle the gesture recognized by the receiver. The action selector must conform to the signature described in the class overview. NULL is not a valid value.
 */
- (void) addTapGestureWithTarger:(nullable id)target action:(nullable SEL)action;

@end
