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

#import "Macro.h"

#import "Person.h"

#import "FPSLabel.h"

#import "SVProgressHUD.h"

#import "PhotoTool.h"

#import "UIView+Animation.h"

#import "PlaceholderTextView.h"

#define __PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wformat-extra-args\"")

#define Exception(condition, desc, ...)	\
do {				\
__PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
if (!(condition)) {		\
NSString *__assert_file__ = [NSString stringWithUTF8String:__FILE__]; \
__assert_file__ = __assert_file__ ? __assert_file__ : @"<Unknown File>"; \
[[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd \
object:self file:__assert_file__ \
lineNumber:__LINE__ description:(desc), ##__VA_ARGS__]; \
}				\
__PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
} while(0)


#define __PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wformat-extra-args\"")



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *blackView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.textField.placeholderColor = [UIColor redColor];
    //    self.textField.placeholder = @"请输入内容";
    //    
    //    [self.imageView addTapGestureWithTarger:self action:@selector(imageViewTap)];
    //    
    //    UIImage *image = [UIImage imageNamed:@"300-4.jpeg"];
    //    //UIImage *image = nil;
    //    self.imageView.image = [image circleImage];
    //    
    //    self.blackView.backgroundColor = self.blackView.backgroundColor.alphaValue_Bock(0.75);
    
    //[SVProgressHUD showWithStatus:@"dadad"];
    
    //NSObject *obj = NEW(NSObject);
    
    //    //NSObject *obj = [[NSObject alloc] init];
    //    Person *p = safe(OBJ(Person));
    //    p.name = @"keen";
    //NSLog(@"%@", p.name);
    
    //[FPSLabel showAtPoint:CGPointMake(100, 100)];
    
    //    void (^completedBlock)() = nil;
    //    
    //    NSString *str = nil;
    
    //Exception(str != nil, @"字符串为空");
    
    PlaceholderTextView *textView = [[PlaceholderTextView alloc] init];
    textView.frame = CGRectMake(0, 200, 200, 200);
    textView.backgroundColor = [UIColor redColor];
    textView.placeholder = @"keenleung";
    [self.view addSubview:textView];
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //[FPSLabel showAtPoint:CGPointMake(100, 100)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //[self.blackView addShakeAnimation];
    [self.view addShakeAnimation];
    
    //[FPSLabel dismiss];
    
    //    UIViewController *vc = [[UIViewController alloc] init];
    //    [self.navigationController pushViewController:vc animated:YES];
    //    
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    //    view.backgroundColor = [UIColor redColor];
    //    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    
    
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
    
    //    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 30, 30)];
    //    leftView.backgroundColor = [UIColor redColor];
    //    
    //    self.blackView.leftView = leftView;
    //    //[self.view addSubview:leftView];
    //    
    //    NSArray *arr = @[@"1", @"22", @"333", @"4444", @"55555", @"666666"];
    //    
    //    NSArray *arr2 = [arr compact_:^NSString *(NSString *obj) {
    //        
    //        return [obj stringByAppendingString:@"@.jpg"];
    //    }];
    //    
    //    NSLog(@"%@", arr2);
    
    //[PhotoTool savePhotoToAppAlbum:[UIImage imageNamed:@"300-4.jpeg"]];
    
    //    [PhotoTool takePictureWithCompletion:^(UIImage *image) {
    //        
    //        NSLog(@"%lf", image.size.width);
    //        
    //        self.imageView.image = image;
    //    }];
    
    
    //    [PhotoTool takePicturesWithMaxCount:0 showsSelectionIndex:NO completion:^(NSArray<UIImage *> *images) {
    //        
    //        NSLog(@"%zd", images.count);
    //        
    //        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
    //            
    //            UIImageView *imageView = [[UIImageView alloc] init];
    //            imageView.image = obj;
    //            imageView.frame = CGRectMake((i % 3) * 110, (i / 3) * 110 + 100, 100, 100);
    //            [self.view addSubview:imageView];
    //            
    //        }];
    //    }];
}

- (void) imageViewTap{
    
    //NSLog(@"111");
}

@end
