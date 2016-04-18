//
//  ViewController.m
//  Framework
//
//  Created by Apple on 16/3/31.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+PlaceholderColorByRuntime.h"

#import "UIImageView+Gesture.h"

#import "UIImage+Extension.h"

#import "UIColor+Extension.h"

#import "UIView+Extension.h"

#import "NSArray+BlocksKit.h"

#import "GlobalMacro.h"

#import "Person.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *blackView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.placeholderColor = [UIColor redColor];
    self.textField.placeholder = @"请输入内容";
    
    [self.imageView addTapGestureWithTarger:self action:@selector(imageViewTap)];
    
    UIImage *image = [UIImage imageNamed:@"300-4.jpeg"];
    //UIImage *image = nil;
    self.imageView.image = [image circleImage];
    
    self.blackView.backgroundColor = self.blackView.backgroundColor.alphaValue_Bock(0.75);
    
    //NSObject *obj = NEW(NSObject);
    
    //NSObject *obj = [[NSObject alloc] init];
    Person *p = safe( OBJ(Person));
    p.name = @"keen";
    NSLog(@"%@", p.name);
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //    self.blackView.x(self.blackView.frame.origin.x + 10);
    //    self.blackView.width(self.blackView.frame.size.width + 10);
    //    self.blackView.height(self.blackView.frame.size.height + 10);
    
    /*
     CGFloat x = self.blackView.frame.origin.x;
     CGFloat width = self.blackView.frame.size.width;
     CGFloat height = self.blackView.frame.size.height;
     
     self.blackView.x(x + 10).width(width + 10).height(height + 10);
     
     */
    
    //self.blackView.x_(self.blackView.x + 10).height_(self.blackView.height + 10).width_(self.blackView.width + 10);
    
    //self.blackView.width_(self.blackView.width + 10);
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 30, 30)];
    leftView.backgroundColor = [UIColor redColor];
    
    self.blackView.leftView = leftView;
    //[self.view addSubview:leftView];
    
    NSArray *arr = @[@"1", @"22", @"333", @"4444", @"55555", @"666666"];
    
    NSArray *arr2 = [arr compact_:^NSString *(NSString *obj) {
        
        return [obj stringByAppendingString:@"@.jpg"];
    }];
    
    NSLog(@"%@", arr2);
}

- (void) imageViewTap{
    
    NSLog(@"111");
}

@end
