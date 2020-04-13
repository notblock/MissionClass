//
//  TestObj.m
//  MissionClass
//
//  Created by null on 2020/4/8.
//  Copyright © 2020 notblock. All rights reserved.
//

#import "TestObj.h"

static constexpr inline float color_value(int hex, int at, int next=0) {
    return ((hex & at) >> next)/255.0f;
}

@implementation TestObj

- (void)getcolor {
    float constexpr r = color_value(0x123456, 0xff0000, 16);
    constexpr float g = color_value(0x123456, 0x00ff00, 8);
    constexpr float b = color_value(0x123456, 0x0000ff);
//    [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
