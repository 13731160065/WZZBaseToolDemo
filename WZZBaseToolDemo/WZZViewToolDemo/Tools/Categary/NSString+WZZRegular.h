//
//  NSString+WZZRegular.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/8/30.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WZZRegular)

/**
 正则表达式查找字符串
 
 @param ruleStr 正则
 @return 子字符串NSRange
 */
- (NSRange)wzz_firstRangeOfRegularStr:(NSString *)ruleStr;

/**
 正则表达式查找字符串
 
 @param ruleStr 正则
 @return 子字符串NSRange数组
 */
- (NSArray <NSValue *>*)wzz_rangeOfRegularStr:(NSString *)ruleStr;

@end
