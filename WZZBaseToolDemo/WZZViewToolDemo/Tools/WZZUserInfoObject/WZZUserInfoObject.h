//
//  WZZUserInfoObject.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZZUserInfoObject : NSObject

#pragma mark - 用户信息

/**
 用户id
 */
@property (nonatomic, strong) NSString * userId;

/**
 用户token
 */
@property (nonatomic, strong) NSString * token;

#pragma mark - 操作方法

/*单例
 
 @return 实例
 */
+ (instancetype)shareInstance;

/**
 是不是我自己
 
 @param otherId 其他人的id
 @return 是不是
 */
- (BOOL)isMe:(NSString *)otherId;

/**
 保存数据
 ，用户数据有变动时需要调用该方法更新保存用户数据
 */
- (void)saveData;

/**
 退出登录清空用户信息
 */
+ (void)logout;

#pragma mark - 辅助方法

/**
 重置单例
 ，一般不需要调用，退出登录调用logout
 */
+ (void)resetInstance;
@end
