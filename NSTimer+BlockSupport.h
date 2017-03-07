//
//  NSTimer+BlockSupport.h
//  OCTools
//
//  Created by 黄嘉伟 on 2017/3/7.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BlockSupport)
+ (NSTimer *)jw_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;
@end
