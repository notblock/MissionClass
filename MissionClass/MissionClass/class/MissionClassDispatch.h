//
//  MissionClass_Dispatch.h
//  MissionClass
//
//  Created by notblock on 2020/3/2.
//  Copyright © 2020 notblock. All rights reserved.
//

#import <UIKit/UIKit.h>


#define CLASSMATES 15   //全班同学
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"

#if defined(__cplusplus)
extern "C" {
#endif
    static char charAdd1(int64_t a) {
        return (char)('A' + a);
    }
    
    static inline int classmates() {
        return CLASSMATES;
    }
    
#if defined(__cplusplus)
}
#endif

#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN



@interface MissionClassDispatch : UIViewController

@end

NS_ASSUME_NONNULL_END
