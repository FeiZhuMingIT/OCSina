//
//  NSDate+Exsention.m
//  texte2
//
//  Created by pkxing on 15/11/10.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "NSDate+Exsention.h"

@implementation NSDate (Exsention)
// Mon Nov 09 22:30:22 +0800 2015
+ (NSString *)sinaDateDescrition:(NSString *)sinaData {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
    NSDate *date = [formatter dateFromString:sinaData];
    // 指定区域，真机调试一定要实现
    NSString *result = [NSDate caledarWithData:date];
    return result;
    
}
/*
 刚刚(一分钟内)
 X分钟前(一小时内)
 X小时前(当天)
 昨天 HH:mm(昨天)
 MM-dd HH:mm(一年内)
 yyyy-MM-dd HH:mm(更早期)
 */
+ (NSString *)caledarWithData:(NSDate *)date  {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL isTodate = [calendar isDateInToday:date];
     NSTimeInterval longtime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceDate:date];
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (isTodate) {
        if (longtime < 60)
        { // 如果是一分钟内，则返回刚刚
            return @"刚刚";
            
        }
        else if (longtime < 60 * 60)
        { // 小于3600秒
            return [NSString stringWithFormat:@"%d分钟前",(int)longtime / 60];
        }
        else if (longtime < 60 * 60 * 3600)
        { // 当天
            return [NSString stringWithFormat:@"%d小时前",(int)longtime / 60 / 60];
        }
    }
    else
    {
        BOOL isWeekend = [calendar isDateInWeekend:date];
        BOOL isTomorrow = [calendar isDateInTomorrow:date];
        if (isWeekend)
        { // 如果不是今年
            formatter.dateFormat = @" yyyy-MM-dd HH:mm";
            return [NSString stringWithFormat:@"早期 %@",[formatter stringFromDate:date]];
        } else
        { // 如果是今年
            if (isTomorrow)
            { // 如果是昨天
                formatter.dateFormat = @"HH:mm";
                NSString *tomorrowdate = [formatter stringFromDate:date];
                return [NSString stringWithFormat:@"昨天 %@",tomorrowdate];
            }
            else
            { // 今年内
                formatter.dateFormat = @" yyyy-MM-dd HH:mm";
                return [formatter stringFromDate:date];
            }
        }
    }
    return nil;
    
}
@end
