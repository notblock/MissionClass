//
//  MissionClass_Dispatch.m
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "MissionClassDispatchBug.h"
#import "DebugView.h"

#define LogInfo(frm,...) \
dispatch_async(dispatch_get_main_queue(), ^{\
[self.debugText logInfo:[NSString stringWithFormat:@"%@\n", [NSString stringWithFormat:(frm),##__VA_ARGS__]]];\
});

#define LogError(frm,...)  \
dispatch_async(dispatch_get_main_queue(), ^{\
[self.debugText logError:[NSString stringWithFormat:@"%@\n", [NSString stringWithFormat:(frm),##__VA_ARGS__]]];\
});

#if defined(__cplusplus)
extern "C" {
#endif
    static char charAdd(int64_t a) {
        return (char)('A' + a);
    }
#if defined(__cplusplus)
}
#endif


#define CLASSMATES 3   //全班同学


@interface MissionClassDispatchBug()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MissionClassDispatchBug
{
    UITableView *_table;
    DebugView *_debugText;
    
    NSArray *tableData;
    
    dispatch_queue_t controlQueue;
}
static NSString *cellName = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"dispatch" ofType:@"plist"];
    tableData  = [NSArray arrayWithContentsOfFile:dataPath];
    [self.table setDelegate:self];
    [self.table setDataSource:self];
    controlQueue = dispatch_queue_create("mainqueue", nil);
}

- (UITableView *)table {
    if (!_table) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(self.view.frame) / 2) style:UITableViewStyleGrouped];
        [self.view addSubview:tableView];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:cellName];
        _table = tableView;
    }
    return _table;
}

- (DebugView *)debugText {
    if (!_debugText) {
        DebugView *debugText = [[DebugView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.table.frame), CGRectGetWidth([UIScreen mainScreen].bounds),  CGRectGetHeight(self.view.frame)  - CGRectGetMaxY(self.table.frame))];
        [self.view addSubview:debugText];
        _debugText = debugText;
    }
    return _debugText;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return ((NSArray *)((NSDictionary *)tableData[section])[@"data"]).count;
    return CLASSMATES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((NSDictionary *)tableData[section])[@"head"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if (indexPath.section == 2 ||indexPath.section == 3) {
        [cell.textLabel setText:[NSString stringWithFormat:@"开始"]];
    } else {
        [cell.textLabel setText:[NSString stringWithFormat:@"同学 %c", charAdd(indexPath.row)]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 && indexPath.section == 0) {
        [self dispatchsync:indexPath];
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.textLabel setTextColor:[UIColor purpleColor]];
}

- (void)dispatchsync:(NSIndexPath *)indexPath {
    dispatch_queue_t queue = dispatch_queue_create("queue", nil);
    __block int c = 0;
    dispatch_async(controlQueue, ^{
        for (int i = 0; i < CLASSMATES; i ++) {
            LogInfo(@"%c 开始", charAdd(i));
            if (c < CLASSMATES ) {
#warning 这里存在问题，这里会重新把任务加入队列，controlQueue是串联队列，所以会导致无限循环调用，判断条件需要 c != 0
                [self asyncNextTableRow:[NSIndexPath indexPathForRow:c inSection:indexPath.section]];
            }
            NSLog(@"开始循环 %c", charAdd(i));
            NSTimeInterval timesBegin = [[NSDate new]timeIntervalSince1970];
            dispatch_sync(queue, ^{
                for (int i = 0; i < 100000000; i ++) {}
                NSTimeInterval timesEnd = [[NSDate new]timeIntervalSince1970];
                LogInfo(@"%c 耗时\t  %f", charAdd(i), timesEnd - timesBegin);
                c++;
                sleep(0.5);
            });
        }
    });
}

- (void)asyncNextTableRow:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger row = indexPath.row;
        NSIndexPath *curIndexPath = [NSIndexPath indexPathForRow:row ++ inSection:indexPath.section];
        [self.table selectRowAtIndexPath:curIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [self tableView:self.table didSelectRowAtIndexPath:curIndexPath];
    });
}

- (void)dealloc {
    
}
@end
