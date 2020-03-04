//
//  ViewController.m
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "ViewController.h"
#import "MissionClassDispatch.h"
#import "MissionClassDispatchBug.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_table;
    NSArray *tableData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.table setDelegate:self];
    [self.table setDataSource:self];
    tableData = @[
                  @{@"head":@"iOS的线程操作集合",
                    @"data":@[
                              @"iOS dispatch系列",
                              @"iOS dispatch系列 bug"
                                ]
                    }
                  ];
}

- (UITableView *)table {
    if (!_table) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.view addSubview:tableView];
        _table = tableView;
    }
    return _table;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)((NSDictionary *)tableData[section])[@"data"]).count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((NSDictionary *)tableData[section])[@"head"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell.textLabel setText:((NSArray *)((NSDictionary *)tableData[indexPath.section])[@"data"])[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        MissionClassDispatch *control = [[MissionClassDispatch alloc] init];
        control.title = ((NSArray *)((NSDictionary *)tableData[indexPath.section])[@"data"])[indexPath.row];
        [self.navigationController pushViewController:control animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 1)  {
        MissionClassDispatchBug *control = [[MissionClassDispatchBug alloc] init];
        control.title = ((NSArray *)((NSDictionary *)tableData[indexPath.section])[@"data"])[indexPath.row];
        [self.navigationController pushViewController:control animated:YES];
    }
}



@end
