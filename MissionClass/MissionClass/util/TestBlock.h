//
//  TestBlock.h
//  MissionClass
//
//  Created by null on 2020/4/9.
//  Copyright © 2020 notblock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//&_NSConcreteStackBlock
typedef void(^Block1)(id obj);
typedef void(^Block2)(void);
@interface TestBlock : NSObject
@property (copy) Block1 b1;
@end

NS_ASSUME_NONNULL_END
