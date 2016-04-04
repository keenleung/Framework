//
//  UIViewController+Alert.h
//  KuBer
//
//  Created by 吴双 on 16/2/26.
//  Copyright © 2016年 huaxu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AlertResponse)(NSUInteger clickIndex);


@interface UIViewController (Alert)

- (void)alertWithTitle:(NSString *)title
			   message:(NSString *)message
		  buttonTitles:(NSArray *)buttonTitles
			  response:(AlertResponse)response;

@end
