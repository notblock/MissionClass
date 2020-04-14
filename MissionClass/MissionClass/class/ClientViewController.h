//
//  ClientViewController.h
//  MissionClass
//
//  Created by null on 2020/4/11.
//  Copyright © 2020 notblock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClientViewController : UIViewController

@property (nonatomic, strong) NSString *sendIp;

@property (nonatomic, copy) void(^result)(id);

- (id)init;



@end

NS_ASSUME_NONNULL_END
