//
//  NSDate+Utils.m
//  Created by Jiawei Huang on 2017/2/28.
//

#import "NSDate+Utils.h"

static NSString *const kDefaultDateFormatter = @"yyyy / M / d HH:mm";
static NSString *const kDefaultTodayDateFormatter = @"HH:mm";
static NSString *const kMonthDayFormatter = @"M/d";

@implementation NSDate (Utils)
- (NSString *)dateString
{
  if([[NSCalendar currentCalendar] isDateInToday:self]){
    return [self dateStringWithFormat:kDefaultTodayDateFormatter];
  } else {
    return [self dateStringWithFormat:kDefaultDateFormatter];
  }
}
- (NSString *)dateStringWithFormat:(NSString *)format
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = format;
  return [formatter stringFromDate:self];
}
- (NSString *)monthDayString
{
  if([[NSCalendar currentCalendar] isDateInToday:self]){
    return NSLocalizedString(@"Today", nil);
  } else {
    return [self dateStringWithFormat:kMonthDayFormatter];
  }
}
- (NSInteger)weekDay
{
  return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:self];
}
@end
