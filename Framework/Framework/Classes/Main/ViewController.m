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

#import "InfiniteScrollView.h"

#import "SQLTool.h"

#import "NSString+Extension.h"

#import "UIScrollView+Extension.h"


@interface ViewController ()<InfiniteScrollViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *blackView;

@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES).lastObject;
    //    NSString *dbName = [([NSBundle mainBundle].infoDictionary)[@"CFBundleName"] stringByAppendingString:@".sqlite"];
    //    NSString *dbPath = [path stringByAppendingPathComponent:dbName];
    //
    //    NSLog(@"%@", dbPath);
    
    //    NSString *sql = @"select * from t_test where name = 'keen'";
    
    //    [SQLTool executeQuery:sql resultBlock:^(FMResultSet *set) {
    //        
    //        NSLog(@"%@", [set stringForColumn:@"name"]);
    //        NSLog(@"%zd", [set intForColumn:@"age"]);
    //        NSLog(@"%lf", [set doubleForColumn:@"score"]);
    //    }];
    
    //[self createTB];
    
    /*
     NSString *str = @"梁继强 keenleung";
     NSString *encodeStr = [str encodeURL];
     NSString *decodeStr = [encodeStr decodeURL];
     NSLog(@"%@", encodeStr);
     NSLog(@"%@", decodeStr);
     */
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    //UIImage *image = [[UIImage imageNamed:@"300-4.jpeg"] roundedWithRadius:5];
    UIImage *image = [UIImage imageNamed:@"300-4.jpeg"];
    imageView.image = image;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(screenW, screenH + 100);
    self.scrollView = scrollView;
    scrollView.delegate = self;
    
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:imageView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    //CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    //NSLog(@"%lf == %lf", translation.x, translation.y);
    
    //    if (translation.y>0) { // 接近第一行
    //        
    //        NSLog(@"向上");
    //        
    //    }else if(translation.y<0){ // 远离第一行
    //        
    //        NSLog(@"向下");
    //    }
    //
    //    if (translation.x > 0) {
    //
    //        NSLog(@"靠左");
    //    }
    //
    //    if (translation.x < 0) {
    //        NSLog(@"靠右");
    //    }
    
    Direction direction = [scrollView scrollDirection];
    if (direction == kDirectionTop) {
        NSLog(@"向上");
    }else if(direction == kDirectionBottom){
        NSLog(@"向下");
    }else if(direction == kDirectionLeft){
        NSLog(@"靠左");
    }else if(direction == kDirectionRight){
        NSLog(@"靠右");
    }
    
    NSObject *obj;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)executeStatement{
    
    NSArray *sqls = @[
                      @"select name, age from t_test",
                      @"select * from t_test",
                      @"select count(*) from t_test"
                      ];
    [SQLTool executeInStatements:sqls resultBlock:^(NSDictionary *dict) {
        
        NSLog(@"%@", dict);
    }];
}

- (void)createTB{
    NSString *sql = @"create table if not exists t_test(id integer primary key  autoincrement, name text, age integer, score real default 60)";
    
    [SQLTool executeUpdate:sql success:^{
        
        NSLog(@"创建表成功");
    } fail:^{
        
        NSLog(@"创建表失败");
    }];
}

- (void) insertData{
    
    //    NSString *name = @"keen";
    //    int age = 24;
    //    double score = 78;
    //NSString *sql = [NSString stringWithFormat:@"insert into t_test(name,age,score) values('%@',%zd,%lf)", name, age, score];
    
    NSArray *sqls = @[
                      @"insert into t_test(name,age,score) values('keen',24,78)",
                      @"insert into t_test(name,age,score) values('andi', 26,78.9)",
                      @"insert into t_test_test(name,age,score) values('phoenix', 17,54.5)",
                      ];
    
    [SQLTool executeInTransaction:sqls success:^{
        
        NSLog(@"执行成功");
        
    } fail:^{
        
        NSLog(@"执行失败");
    }];
}

- (void)updateData{
    
    NSString *sql = @"update t_test_te set score = 90 where name = 'keen'";
    
    [SQLTool executeUpdate:sql success:^{
        
        NSLog(@"更新成功");
    } fail:^{
        
        NSLog(@"更新失败");
    }];
}


@end
