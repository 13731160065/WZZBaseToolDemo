//
//  WZZUserInfoObject.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZUserInfoObject.h"
#import <objc/runtime.h>

static WZZUserInfoObject * wzzUserInfoObject;

@implementation WZZUserInfoObject

#pragma mark - 用户信息

- (void)setUserId:(NSString *)userId {
    _userId = userId;
    [self saveData];
}

- (void)setToken:(NSString *)token {
    _token = token;
    [self saveData];
}

#pragma mark - 方法

//是不是我自己
- (BOOL)isMe:(NSString *)otherId {
    return [_userId isEqualToString:otherId];
}

//mj模型
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"userId":@"",
             @"token":@""
             };
}

/**
 单例
 
 @return 实例
 */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [self unarchiveMySelf];
        if (obj) {
            wzzUserInfoObject = obj;
        } else {
            wzzUserInfoObject = [[WZZUserInfoObject alloc] init];
        }
    });
    return wzzUserInfoObject;
}

/**
 重置单例
 */
+ (void)resetInstance {
    wzzUserInfoObject = [[WZZUserInfoObject alloc] init];
}

//MARK:保存数据
- (void)saveData {
    [self archiveMySelf];
}

//MARK:退出登录
+ (void)logout {
    [self resetInstance];
    [[self shareInstance] saveData];
}

#pragma mark - 快速归档
//coder初始化
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int outCount;//变量数
        Ivar * ivars = class_copyIvarList([self class], &outCount);//获取变量列表ivars是一个Ivar数组
        for (int i = 0; i < outCount; i ++) {
            Ivar ivar = ivars[i];//取出第i个Ivar
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];//根据Ivar得到变量名字的字符串
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];//利用kvc给变量设置值
        }
    }
    return self;
}

//coder打包
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount;//变量数
    Ivar * ivars = class_copyIvarList([self class], &outCount);//获取变量列表ivars是一个Ivar数组
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];//取出第i个Ivar
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];//根据Ivar得到变量名字的字符串
        [aCoder encodeObject:[self valueForKey:key] forKey:key];//利用kvc取出变量的值
    }
}

//归档自己
- (void)archiveMySelf {
    NSString * archiveKey = [[NSString stringWithUTF8String:object_getClassName(self)] stringByAppendingString:@"_archiveKey"];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:archiveKey];
}

//解归档自己
+ (instancetype)unarchiveMySelf {
    NSString * archiveKey = [[NSString stringWithUTF8String:object_getClassName(self)] stringByAppendingString:@"_archiveKey"];
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:archiveKey];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end

