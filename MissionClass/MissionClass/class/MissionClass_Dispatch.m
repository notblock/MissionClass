//
//  MissionClass_Dispatch.m
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "MissionClass_Dispatch.h"
#import "DebugText.h"

#define LogInfo(frm,...) [self.debugText logInfo:[NSString stringWithFormat:@"%@\n", [NSString stringWithFormat:(frm),##__VA_ARGS__]]]

#define LogError(frm,...) [self.debugText logError:[NSString stringWithFormat:@"%@\n", [NSString stringWithFormat:(frm),##__VA_ARGS__]]]

@interface MissionClass_Dispatch()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MissionClass_Dispatch
{
    UITableView *_table;
    DebugText *_debugText;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.table setDelegate:self];
    [self.table setDataSource:self];
}

- (UITableView *)table {
    if (!_table) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(self.view.frame) / 2) style:UITableViewStyleGrouped];
        [self.view addSubview:tableView];
        _table = tableView;
    }
    return _table;
}

- (DebugText *)debugText {
    if (!_debugText) {
        DebugText *debugText = [[DebugText alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.table.frame), CGRectGetWidth([UIScreen mainScreen].bounds),  CGRectGetHeight(self.view.frame)  - CGRectGetMaxY(self.table.frame))];
        [self.view addSubview:debugText];
        _debugText = debugText;
    }
    return _debugText;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld", indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (int i = 0; i < 100; i++) {
        LogError(@"%d", i);
    }
}

@end
