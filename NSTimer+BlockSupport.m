//
//  NSTimer+BlockSupport.m
//  OCTools
//
//  Created by 黄嘉伟 on 2017/3/7.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import "NSTimer+BlockSupport.h"

@implementation NSTimer (BlockSupport)
+ (NSTimer *)jw_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats
{
  return [self scheduledTimerWithTimeInterval:interval
                                       target:self
                                     selector:@selector(jw_blockInvoke:)
                                     userInfo:block
                                      repeats:repeats];
}

+ (void)jw_blockInvoke:(NSTimer *)timer
{
  void (^block)() = timer.userInfo;
  if (block) {
    block();
  }
}
@end
