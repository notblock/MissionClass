//
//  ViewController.m
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "ViewController.h"
#import "MissionClass_Dispatch.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_table;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.table setDelegate:self];
    [self.table setDataSource:self];
}

- (UITableView *)table {
    if (!_table) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.view addSubview:tableView];
        _table = tableView;
    }
    return _table;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        MissionClass_Dispatch *control = [[MissionClass_Dispatch alloc] init];
        [self.navigationController pushViewController:control animated:YES];
    }
}



@end
