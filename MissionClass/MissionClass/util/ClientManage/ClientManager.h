//
//  ClientManager.h
//  MissionClass
//
//  Created by null on 2020/4/11.
//  Copyright © 2020 notblock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClientManager : NSObject

- (void)client:(void(^)(int server_handle, NSString *revStr))block;
- (void)sendMsg:(int)server_handle Withmsg:(NSString *)msg;
- (void)stop:(int)server_handle;
@end

NS_ASSUME_NONNULL_END
