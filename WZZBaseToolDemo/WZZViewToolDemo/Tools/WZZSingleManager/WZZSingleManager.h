//
//  WZZSingleManager.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

typedef enum : NSUInteger {
    WZZSingleManager_ChangeWindowRoot_Login,
    WZZSingleManager_ChangeWindowRoot_Tabbar,
} WZZSingleManager_ChangeWindowRoot;

@interface WZZSingleManager : NSObject

@property (nonatomic, weak) AppDelegate * appDelegate;

/**
 单例
 
 @return 单例
 */
+ (instancetype)shareInstance;

/**
 初始化tabbar
 */
- (void)setupTabbar;

/**
 修改window主vc
 
 @param changeType 修改类型
 */
- (void)changeWindowRoot:(WZZSingleManager_ChangeWindowRoot)changeType;

/**
 是否登录
 
 @return 状态
 */
+ (BOOL)isLogin;

/**
 自动判断登录
 
 @param loginBlock 回调
 */
+ (void)autoLoginBlock:(void(^)(void))loginBlock;

/**
 判断是不是第一次
 
 @return 第一次打开
 */
- (BOOL)isFirst:(NSString *)key;

/**
 标记已经打开过了
 */
- (void)markFirst:(NSString *)key;

@end

