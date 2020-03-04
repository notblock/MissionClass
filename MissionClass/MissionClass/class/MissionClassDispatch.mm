//
//  MissionClass_Dispatch.m
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "MissionClassDispatch.h"
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


#define CLASSMATES 15   //全班同学


@interface MissionClassDispatch()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MissionClassDispatch
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
    if (section == 2 || section == 3) {
        return 1;
    }
    return CLASSMATES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableData.count;
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
        [self dispatchAsync:indexPath];
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        [self dispatchSync:indexPath];
    } else if (indexPath.row == 0 && indexPath.section == 2) {
        [self dispatchSemaphore:indexPath];
        return;
    } else if (indexPath.row == 0 && indexPath.section == 3) {
        [self dispatchAsyncToSync];
        return;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.textLabel setTextColor:[UIColor purpleColor]];
}


- (void)dispatchAsyncToSync {
    
    dispatch_queue_t readQueue = dispatch_queue_create("com.notblock.readqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t authQueue = dispatch_queue_create("com.notblock.authqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group = dispatch_group_create();
    LogInfo(@"老师布置背诵任务，全班开始哇哇背诵");
    for (int i = 0; i < CLASSMATES; i ++) {
        dispatch_group_enter(group);
        dispatch_async(readQueue, ^{
            NSTimeInterval timesBegin = [[NSDate new] timeIntervalSince1970];
            sleep(3);//在努力记忆
            NSTimeInterval timesEnd = [[NSDate new] timeIntervalSince1970];
            LogInfo(@"%@", [NSString stringWithFormat:@"同学 %c 开始排队准备背诵 耗时:%f", charAdd(i), timesEnd - timesBegin]);
            dispatch_async(authQueue, ^{
                NSTimeInterval tb = [[NSDate new] timeIntervalSince1970];
                 for (int j = 0; j < 1000000000; j ++) {}//在背诵
                NSTimeInterval te = [[NSDate new] timeIntervalSince1970];
                LogInfo(@"%@", [NSString stringWithFormat:@"同学 %c 背诵完成 耗时:%f", charAdd(i), te - tb]);
                dispatch_group_leave(group);
            });
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        LogInfo(@"老师宣布，所有同学背诵完成");
    });
}



- (void)dispatchSemaphore:(NSIndexPath *)indexPath {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0) ;
    NSString *str = ((NSDictionary *)tableData[indexPath.section])[@"head"];
    dispatch_queue_t queue = dispatch_queue_create("com.notblock.async", DISPATCH_QUEUE_CONCURRENT);
    LogInfo(@"%@ 开始", str);
    dispatch_async(queue, ^{
        LogInfo(@"%@", [NSString stringWithFormat:@"同学 %c 在上体育课", charAdd(0)]);
        NSTimeInterval timesBegin = [[NSDate new] timeIntervalSince1970];
        LogInfo(@"被叫去改作业");
        [self dispatchSync:[NSIndexPath indexPathForRow:0 inSection:1] WithComplate:^{
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSTimeInterval timesEnd = [[NSDate new] timeIntervalSince1970];
        LogInfo(@"%@ 耗时\t  %f", [NSString stringWithFormat:@"同学 %c 改完作业，接着上体育课", charAdd(0)], timesEnd - timesBegin);
        sleep(2.5);
    });
}



- (void)dispatchSync:(NSIndexPath *)indexPath WithComplate:(void(^)(void))block{
    NSTimeInterval tb = [[NSDate new] timeIntervalSince1970];
    NSString *str = ((NSDictionary *)tableData[indexPath.section])[@"head"];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.notblock.async", DISPATCH_QUEUE_SERIAL);
    LogInfo(@"%@ 开始", str);
    for (int i = 0; i < CLASSMATES; i ++) {
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            
            LogInfo(@"%@", [NSString stringWithFormat:@"同学 %c 开始写作业", charAdd(i)]);
            if (i != 0) {
                [self asyncNextTableRow:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
            }
            NSTimeInterval timesBegin = [[NSDate new] timeIntervalSince1970];
            for (int j = 0; j < 1000000000; j ++) {}
            NSTimeInterval timesEnd = [[NSDate new] timeIntervalSince1970];
            LogInfo(@"%@ 耗时\t  %f", [NSString stringWithFormat:@"同学 %c 提交作业", charAdd(i)], timesEnd - timesBegin);
            sleep(2.5);
            dispatch_group_leave(group);
        });
        
    }
    dispatch_group_notify(group, dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
        NSTimeInterval te = [[NSDate new] timeIntervalSince1970];
        LogInfo(@"%@ 结束 耗时\t  %f", str, te - tb);
        if (block) {
            block();
        }
    });
}


- (void)dispatchSync:(NSIndexPath *)indexPath {
    [self dispatchSync:indexPath WithComplate:nil];
}

- (void)dispatchAsync:(NSIndexPath *)indexPath {
    NSTimeInterval tb = [[NSDate new] timeIntervalSince1970];
    NSString *str = ((NSDictionary *)tableData[indexPath.section])[@"head"];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.notblock.async", DISPATCH_QUEUE_CONCURRENT);
    LogInfo(@"%@ 开始", str);
    for (int i = 0; i < CLASSMATES; i ++) {
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            
            LogInfo(@"%@", [NSString stringWithFormat:@"开始批改同学 %c 作业", charAdd(i)]);
            if (i != 0) {
                [self asyncNextTableRow:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
            }
            NSTimeInterval timesBegin = [[NSDate new] timeIntervalSince1970];
            for (int j = 0; j < 1000000000; j ++) {}
            NSTimeInterval timesEnd = [[NSDate new] timeIntervalSince1970];
            LogInfo(@"%@ 耗时\t  %f", [NSString stringWithFormat:@"批改同学 %c 作业", charAdd(i)], timesEnd - timesBegin);
            sleep(2.5);
            dispatch_group_leave(group);
        });
        
    }
    dispatch_group_notify(group, dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
        NSTimeInterval te = [[NSDate new] timeIntervalSince1970];
        LogInfo(@"%@ 结束 耗时\t  %f", str, te - tb);
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


@end
