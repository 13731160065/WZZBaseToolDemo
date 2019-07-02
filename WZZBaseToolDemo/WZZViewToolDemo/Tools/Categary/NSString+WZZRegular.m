//
//  NSString+WZZRegular.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/8/30.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "NSString+WZZRegular.h"

@implementation NSString (WZZRegular)

- (NSRange)wzz_firstRangeOfRegularStr:(NSString *)ruleStr {
    NSError * err;
    //正则
    NSRegularExpression * reg = [[NSRegularExpression alloc] initWithPattern:ruleStr options:NSRegularExpressionCaseInsensitive error:&err];
    if (err) {
        return NSMakeRange(0, 0);
    }
    //正则检索第一个
    NSTextCheckingResult * res = [reg firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return res.range;
}

- (NSArray <NSValue *>*)wzz_rangeOfRegularStr:(NSString *)ruleStr {
    NSError * err;
    //正则
    NSRegularExpression * reg = [[NSRegularExpression alloc] initWithPattern:ruleStr options:NSRegularExpressionCaseInsensitive error:&err];
    if (err) {
        return nil;
    }
    //正则检索
    NSArray <NSTextCheckingResult *>* arr = [reg matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableArray * marr = [NSMutableArray array];
    for (NSTextCheckingResult * res in arr) {
        [marr addObject:[NSValue valueWithRange:res.range]];
    }
    
    return marr;
}

@end
