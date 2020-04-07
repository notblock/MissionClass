//
//  MethodViewController.m
//  MissionClass
//
//  Created by null on 2020/4/7.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "MethodViewController.h"
#import "NSObject+GetException.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
