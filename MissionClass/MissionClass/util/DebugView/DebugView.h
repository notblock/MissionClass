//
//  DebugView.h
//  MissionClass
//
//  Created by null on 2020/3/3.
//  Copyright © 2020 notblock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DebugView : UIView

- (void)logInfo:(NSString *)logstr;

- (void)logError:(NSString *)logstr;

@end

NS_ASSUME_NONNULL_END
