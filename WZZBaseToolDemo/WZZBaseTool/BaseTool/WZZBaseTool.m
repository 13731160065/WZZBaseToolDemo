//
//  WZZBaseTool.m
//  WZZViewToolDemo
//
//  Created by wyq_iMac on 2019/7/2.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import "WZZBaseTool.h"

static BOOL WZZBaseToolIsIphoneX;//是不是iphonex

@implementation WZZBaseTool

+ (BOOL)wzz_isIphoneX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            WZZBaseToolIsIphoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;
        } else {
            WZZBaseToolIsIphoneX = NO;
        }
    });
    return WZZBaseToolIsIphoneX;
}

@end
