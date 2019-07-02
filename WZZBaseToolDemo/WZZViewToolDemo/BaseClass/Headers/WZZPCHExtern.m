//
//  WZZPCHExtern.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZPCHExtern.h"

static BOOL WZZPCHExternIsIphoneX;//是不是iphonex

@implementation WZZPCHExtern

//MARK:是不是iphonex
+ (BOOL)isIphoneX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WZZPCHExternIsIphoneX = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
    });
    return WZZPCHExternIsIphoneX;
}

@end
