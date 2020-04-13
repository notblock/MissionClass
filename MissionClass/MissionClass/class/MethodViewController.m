//
//  MethodViewController.m
//  MissionClass
//
//  Created by null on 2020/4/7.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "MethodViewController.h"
//#import "NSObject+GetException.h"
#import "TestObj.h"
#import "TestBlock.h"
#import <objc/message.h>

@interface MethodViewController ()


@end

@implementation MethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 88, 88, 44)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)test {
    TestBlock *obj = [TestBlock new];
    
    ((void(*)(id obj, SEL method))objc_msgSend)(obj, @selector(test));
//    ((void(*)(id obj, SEL method))objc_msgSend)(obj, @selector(test2));

}

@end
