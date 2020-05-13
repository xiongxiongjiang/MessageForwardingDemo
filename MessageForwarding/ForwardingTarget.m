//
//  ForwardingTarget.m
//  MessageForwarding
//
//  Created by 徐荣 on 2020/5/13.
//  Copyright © 2020 xurong. All rights reserved.
//

#import "ForwardingTarget.h"
#import "Person.h"

@implementation ForwardingTarget

//8.2 生成方法签名，然后系统用这个方法签名生成NSInvocation对象
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *selStr = NSStringFromSelector(aSelector);
    if ([selStr isEqualToString: @"printStr"]) {
        NSMethodSignature *sign = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        return sign;
    }
    return [super methodSignatureForSelector:aSelector];
}

//8.3
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    Person *man = [Person new];
    if ([man respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:man];
    }
}

@end
