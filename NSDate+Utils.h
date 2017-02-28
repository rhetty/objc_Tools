//
//  NSDate+Utils.h
//  Created by Jiawei Huang on 2017/2/28.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)
/**
 * Generates a string with default formatter.
 */
- (NSString *)dateString;
/**
 * Generates a string with given formatter.
 */
- (NSString *)dateStringWithFormat:(NSString *)format;
/**
 * Generates a string with month and day.
 */
- (NSString *)monthDayString;
/**
 * Return a NSInteger value(1-7) which represents weekday and 1 is Sunday.
 */
- (NSInteger)weekDay;
@end
