//
//  NSObject+GetException.m
//  debug-objc
//
//  Created by null on 2020/4/7.
//

#import "NSObject+GetException.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

#define CCLOG 

static void getException(id self, SEL _cmd) {
#if DEBUG
    
    NSString *msgStr = [NSString stringWithFormat:@"%@中，方法%@并未实现",NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    UIAlertController *control = [UIAlertController alertControllerWithTitle:@"Error" message:msgStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [control addAction:action];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:control animated:YES completion:nil];
    
    NSLog(@"this method is not find!");
#endif
}

@implementation NSObject (GetException)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    CCLOG
    if (![[self class] resolveClassMethod:aSelector]) {
        class_addMethod([self class], aSelector, (IMP)getException, "v@:");
    }
    NSMethodSignature *methodSign = [[self class]     instanceMethodSignatureForSelector:aSelector];
    if (methodSign == nil) {
        methodSign = [[self class]     instanceMethodSignatureForSelector:aSelector];
        return methodSign;
    }
    return methodSign;
}


//
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    CCLOG
    
    [anInvocation setTarget:self];
    NSString *methodName = NSStringFromSelector(anInvocation.selector);
//    [anInvocation setArgument:&methodName atIndex:1];
    NSLog(@"methodName=%@", methodName);
    NSString *className = NSStringFromClass([self class]);
//    [anInvocation setArgument:&className atIndex:0];
//    [anInvocation setArgument:&methodName atIndex:1];
    [anInvocation invoke];
}

@end
