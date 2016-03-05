//
//  UIViewController+Alert.m
//  KuBer
//
//  Created by 吴双 on 16/2/26.
//  Copyright © 2016年 huaxu. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles response:(AlertResponse)response {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	NSUInteger index = 0;
	for (NSString *buttonTitle in buttonTitles) {
		[alert addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			if (response) {
				response(index);
			}
		}]];
		index ++;
	}
	[self presentViewController:alert animated:YES completion:nil];
}

@end
