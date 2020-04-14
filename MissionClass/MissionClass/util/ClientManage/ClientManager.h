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

+ (ClientManager *)shareInstance;
- (void)client:(void(^)(int server_handle, id revDic))block;
- (void)sendMsg:(int)server_handle Withmsg:(id)msg;
- (void)stop:(int)server_handle;
@end

NS_ASSUME_NONNULL_END
