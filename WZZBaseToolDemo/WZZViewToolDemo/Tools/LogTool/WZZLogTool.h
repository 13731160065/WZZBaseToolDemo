//
//  WZZLogTool.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/8/30.
//  Copyright © 2018年 王泽众. All rights reserved.
//  该工具类需要在pch全局引用以替换所有NSLog函数
//  使用Is_log_def_open可以控制该工具替换log是否起作用，默认情况下关闭
//  如果切换了rootviewcontroller，需要重新调用register方法注册

#import <Foundation/Foundation.h>

//使用以下代码启用NSLog替换宏，并确保没有使用其他NSLog的宏替换方案
//------------------------------------
//日志工具是否启用
//#define WZZLogTool_Is_log_def_open 1
//------------------------------------

#if WZZLogTool_Is_log_def_open

#define NSLog(xxx, ...); \
{NSLog((@"%s [%d行] " xxx), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}\
{[WZZLogTool markLog:[NSString stringWithFormat:(@"%s [%d行] >" xxx), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__]];}

#endif

typedef enum : NSUInteger {
    WZZLogTool_ShowAction_DoubleVoiceUpDoubleVoiceDown,//两下音量加，两下音量减，暂时没有
    WZZLogTool_ShowAction_PointView//小圆点
} WZZLogTool_ShowAction;

@interface WZZLogTool : NSObject

@property (nonatomic, strong) NSMutableString * logStr;

/**
 注册显示log监听
 
 @param action 显示log
 */
+ (void)registerShowLog:(WZZLogTool_ShowAction)action;

/**
 注册显示log监听

 @param action 显示log
 @param window 窗体
 */
+ (void)registerShowLog:(WZZLogTool_ShowAction)action
                 window:(UIWindow *)window;

/**
 记录log

 @param log 日志
 */
+ (void)markLog:(NSString *)log;

@end
