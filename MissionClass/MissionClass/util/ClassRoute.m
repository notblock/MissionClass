//
//  ClassRoute.m
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "ClassRoute.h"

#define LogInfo NSLog

@implementation ClassRoute
{
    dispatch_queue_t controlQueue;
}

- (void)begin:(NSInteger)index {
    if (index == 0) {    
        [self dispatchsync:index];
    }
}


- (void)dispatchsync:(NSInteger)index {
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"dispatch" ofType:@"plist"];
    
    NSArray *tableData  = [NSArray arrayWithContentsOfFile:dataPath];
    dispatch_queue_t queue = dispatch_queue_create("queue", nil);
    
    NSArray *textArr = ((NSDictionary *)tableData[index])[@"data"];
    __block int c = 0;
    dispatch_async(controlQueue, ^{
        for (NSString *str in textArr) {
            LogInfo(@"%@ 开始", str);
            if (c < textArr.count) {
                [self nextTableRow:c];
            }
            NSLog(@"开始循环 %@", str);
            NSTimeInterval timesBegin = [[NSDate new]timeIntervalSince1970];
            dispatch_sync(queue, ^{
                for (int i = 0; i < 100000000; i ++) {}
                NSTimeInterval timesEnd = [[NSDate new]timeIntervalSince1970];
                LogInfo(@"%@ 耗时\t  %f", str, timesEnd - timesBegin);
                c++;
                
                sleep(3);
            });
        }
    });
}



- (void)nextTableRow:(NSInteger)index {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger row = index;
        [self begin:row++];
    });
}

@end
