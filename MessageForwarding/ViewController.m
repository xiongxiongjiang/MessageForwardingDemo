//
//  ViewController.m
//  MessageForwarding
//
//  Created by 徐荣 on 2020/5/13.
//  Copyright © 2020 xurong. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1. 首先检查这个selector是不是要忽略。比如Mac OS X开发，有了垃圾回收就不会理会retain，release这些函数。
    
    Test *obj = [[Test alloc] init];
    
    //2. 检测这个selector的target是不是nil，OC允许我们对一个nil对象执行任何方法不会Crash，因为运行时会被忽略掉。
    //obj = nil;
    
    //3. 如果上面两步都通过了，就开始查找这个类的实现IMP，先从cache里查找，如果找到了就运行对应的函数去执行相应的代码。
    //4. 如果cache中没有找到就找类的方法列表中是否有对应的方法。
    //5. 如果类的方法列表中找不到就到父类的方法列表中查找，一直找到NSObject类为止。
    
    //测试动态方法解析
    obj.name = @"Tom";
    NSLog(@"%@", obj.name);
    
    //测试快速转发
    [obj printNum];
    
    //测试普通转发，完整的转发要先走快速转发
    [obj printStr];
}


@end
