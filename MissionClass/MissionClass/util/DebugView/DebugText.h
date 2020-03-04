//
//  DebugText.h
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import <UIKit/UIKit.h>





NS_ASSUME_NONNULL_BEGIN

@interface DebugText : UITextView

- (void)clearText;

- (NSString *)copyText;

- (void)logInfo:(NSString *)logstr;

- (void)logError:(NSString *)logstr;

@end

NS_ASSUME_NONNULL_END
