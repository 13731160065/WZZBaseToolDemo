//
//  HttpHandler.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/23.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "HttpHandler.h"

@implementation HttpHandler

#pragma mark - 请求接口

+ (NSString *)baseUrl {
    return @"";
}

#pragma mark - 请求基础方法
//get请求
+ (void)GET:(NSString *)url
urlParamDic:(NSDictionary *)urlParamDic
successBlock:(void (^)(id))successBlock
failedBlock:(void (^)(NSError *))failedBlock {
    
}

//post请求
+ (void)POST:(NSString *)url
    httpBody:(NSDictionary *)bodyDic
successBlock:(void (^)(id))successBlock
 failedBlock:(void (^)(NSError *))failedBlock {
    
}

//上传文件post请求
+ (void)POST:(NSString *)url
 addFormData:(void (^)(id))formDataBlock
    httpBody:(NSDictionary *)bodyDic successBlock:(void (^)(id))successBlock
 failedBlock:(void (^)(NSError *))failedBlock {
    
}

@end
