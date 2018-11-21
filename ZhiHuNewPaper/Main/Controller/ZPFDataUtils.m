//
//  ZPFDataUtils.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/19.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFDataUtils.h"

@implementation ZPFDataUtils

+(NSString *)todayDateString {
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    return [formatter stringFromDate:today];
}

+(NSString *)dateStringBeforeDays:(NSInteger)days {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *before = [NSDate dateWithTimeIntervalSinceNow:days*60*60*24];
    
    return [formatter stringFromDate:before];
}


+(NSString *)todayDateString1 {
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    return [formatter stringFromDate:today];
}

+(NSString *)dateStringBeforeDays1:(NSInteger)days {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *before = [NSDate dateWithTimeIntervalSinceNow:days*60*60*24];
    
    return [formatter stringFromDate:before];
}

@end
