//
//  ClientListViewController.m
//  MissionClass
//
//  Created by null on 2020/4/14.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "ClientListViewController.h"
#import "ClientManager.h"
#import "ClientViewController.h"

@interface ClientListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *tabledata;
@property (nonatomic, copy) id(^revBlock)(void);
@property (nonatomic, strong) ClientViewController *con;
@end

@implementation ClientListViewController

- (void)dealloc {
    [[ClientManager shareInstance] stop:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.table setDelegate:self];
    [self.table setDataSource:self];
    [self.view addSubview:self.table];
   
}

- (void)reload {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.table reloadData];
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakself = self;
    [[ClientManager shareInstance] client:^(int server_handle, id _Nonnull revDic) {
        if ([revDic isKindOfClass:[NSArray class]]) {
            weakself.tabledata = revDic;
            [weakself reload];
        } else {
            [weakself revData:revDic];
        }
    }];
}


- (void)revData:(id)revDic {
    self.con.result(revDic);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tabledata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    [cell.textLabel setText:self.tabledata[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.con = [[ClientViewController alloc] init];
    self.con.sendIp = self.tabledata[indexPath.row];
    [self.navigationController pushViewController:self.con animated:YES];
}
@end
