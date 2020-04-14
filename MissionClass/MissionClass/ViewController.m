//
//  ViewController.m
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "ViewController.h"
#import "MissionClassDispatch.h"
#import "MissionClass-Swift.h"
#import "MissionClassDispatchBug.h"
#import "MethodViewController.h"
//#import "ClientViewController.h"
#import "ClientListViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_table;
    NSArray *tableData;
}
@end

@implementation ViewController
-(void)testHttp
{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];//此处修改为自己公司的服务器地址
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@",dict);
        }
    }];
    
    [dataTask resume];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testHttp];
    [self.table setDelegate:self];
    [self.table setDataSource:self];
    tableData = @[
                  @{@"head":@"iOS的线程操作集合",
                    @"data":@[
                              @"iOS oc dispatch 系列",
                              @"iOS swift dispatch 系列",
                              @"iOS dispatch系列 bug"
                                ]
                    },
                  @{@"head":@"iOS runtime截流系列",
                    @"data":@[
                            @"方法若不存在，也不会闪退"
                            ]
                    },
                  @{@"head":@"iOS Socket",
                    @"data":@[
                            @"Client"
                            ]
                    },
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
    }
    else if (indexPath.section == 0 && indexPath.row == 1)  {
        SWMCDispatch *control = [[SWMCDispatch alloc] init];
        control.title = ((NSArray *)((NSDictionary *)tableData[indexPath.section])[@"data"])[indexPath.row];
        [self.navigationController pushViewController:control animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 2)  {
        MissionClassDispatchBug *control = [[MissionClassDispatchBug alloc] init];
        control.title = ((NSArray *)((NSDictionary *)tableData[indexPath.section])[@"data"])[indexPath.row];
        [self.navigationController pushViewController:control animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0)  {
        MethodViewController *control = [[MethodViewController alloc] init];
        control.title = ((NSArray *)((NSDictionary *)tableData[indexPath.section])[@"data"])[indexPath.row];
        [self.navigationController pushViewController:control animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0)  {
        ClientListViewController *control = [[ClientListViewController alloc] init];
        control.title = ((NSArray *)((NSDictionary *)tableData[indexPath.section])[@"data"])[indexPath.row];
        [self.navigationController pushViewController:control animated:YES];
    }
}



@end
