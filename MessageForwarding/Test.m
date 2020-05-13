//
//  Test.m
//  MessageForwarding
//
//  Created by 徐荣 on 2020/5/13.
//  Copyright © 2020 xurong. All rights reserved.
//

#import "Test.h"
#import <objc/runtime.h>
#import "BackupClass.h"
#import "ForwardingTarget.h"

@implementation Test

//@dynamic 告诉编译器：属性的 setter 与 getter 方法由用户自己实现，不自动生成
@dynamic name;

//6. 动态方法解析(Method resolution)
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(setName:)) {
        //type: 输入一个字符数组，该数组描述方法的参数的类型。
        //因为函数必须至少接受两个参数—self和_cmd，所以第二个和第三个字符必须是“@:”(第一个字符是返回类型)。
        /**
         *  i(类型为int)
         *  v(类型为void)
         *  @(类型为id)
         *  :(类型为SEL)
         */
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    } else if (sel == @selector(name)) {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    } else if (sel == @selector(printNum)) {
        //让下面的printname进入快速转发
        return false;
    } else if (sel == @selector(printStr)) {
        return false;
    }
    return [super resolveInstanceMethod:sel];
}


void autoDictionarySetter(id self, SEL _cmd, id value) {
    NSLog(@"name的set方法==%@",value);
}

id autoDictionaryGetter(id self, SEL _cmd) {
    return @"name的get方法";
}

//7. 快速转发(Fast Rorwarding)
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(printNum)) {
        BackupClass *backup = [BackupClass new];
        return backup;
    } else if (aSelector == @selector(printStr)) {
        //8.1 进入消息转发流程重定向
        ForwardingTarget *obj = [ForwardingTarget new];
        return obj;
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end
