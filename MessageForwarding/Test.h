//
//  Test.h
//  MessageForwarding
//
//  Created by 徐荣 on 2020/5/13.
//  Copyright © 2020 xurong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject

@property (nonatomic, copy) NSString *name;

- (void)printNum;

- (void)printStr;

@end

NS_ASSUME_NONNULL_END
