//
//  TestBlock.m
//  MissionClass
//
//  Created by null on 2020/4/9.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "TestBlock.h"

@interface TestBlock()

@end

@implementation TestBlock


- (void)test {
    Block1 b1 = ^(TestBlock *obj){
        printf("this is a b1 block inner test\n");
        [self dosomething];
//        [self print:self.b1];
    };
    
    b1(self);
    
    self.b1 = [b1 copy];
    self.b1 = ^(id  _Nonnull obj) {
        printf("self b1 copy\n");
        
    };
    self.b1(self);
    b1(self);
}

- (void)test2 {
//    self.b1(self);
}



- (void)dosomething {
    
}

- (void)print:(Block1)b {
//    b(self);
}

- (void)dealloc {
    NSLog(@"~dealloc");
}

@end
