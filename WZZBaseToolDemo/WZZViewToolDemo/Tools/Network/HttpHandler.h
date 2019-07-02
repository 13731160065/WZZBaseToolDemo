//
//  HttpHandler.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/23.
//  Copyright © 2018年 王泽众. All rights reserved.
//  网络请求处理中间层

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HttpHandler_Code_Success = 200,//成功
    HttpHandler_Code_500 = 500,//服务器内部错误
    HttpHandler_Code_400 = 400,//请求错误
    HttpHandler_Code_TokenOut = 999999//token失效
} HttpHandler_Code;

@interface HttpHandler : NSObject

#pragma mark - 请求基础方法

/**
 基础url
 
 @return 基础url
 */
+ (NSString *)baseUrl;

/**
 GET请求
 GET            url地址
 urlParamDic    参数
 successBlock   成功回调
 failedBlock    失败回调
 */
+ (void)GET:(NSString *)url
urlParamDic:(NSDictionary *)urlParamDic
successBlock:(void(^)(id httpResponse))successBlock
failedBlock:(void(^)(NSError * httpError))failedBlock;

/**
 POST请求
 POST           url地址
 httpBody       请求体
 successBlock   成功回调
 failedBlock    失败回调
 */
+ (void)POST:(NSString *)url
    httpBody:(NSDictionary *)bodyDic
successBlock:(void(^)(id httpResponse))successBlock
 failedBlock:(void(^)(NSError * httpError))failedBlock;

/**
 POST请求带文件
 POST           url地址
 formDataBlock  表单数据
 httpBody       请求体
 successBlock   成功回调
 failedBlock    失败回调
 */
+ (void)POST:(NSString *)url
 addFormData:(void(^)(id))formDataBlock
    httpBody:(NSDictionary *)bodyDic
successBlock:(void(^)(id httpResponse))successBlock
 failedBlock:(void(^)(NSError * httpError))failedBlock;

@end
