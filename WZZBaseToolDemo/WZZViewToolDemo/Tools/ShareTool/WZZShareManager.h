//
//  WZZShareManager.h
//  SiNanQingSu
//
//  Created by 王泽众 on 2018/6/19.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WZZShareManager_UmengKey @"5695e74067e58e537d000f61"
#define WZZShareManager_WXKey @"wx675c84583728cf8c"
#define WZZShareManager_WXSec @"dabca95c6a03cbe5c6b544529e3469be"
#define WZZShareManager_QQId @"1104904679"
#define WZZShareManager_QQKey @"GVWoxF8VY5OHLy0g"

typedef enum : NSUInteger {
    WZZShareManager_Platform_QQ,
    WZZShareManager_Platform_WX,
    WZZShareManager_Platform_WB,
} WZZShareManager_Platform;

@interface WZZShareManager : NSObject

/**
 三方登录
 
 @param platform 平台
 @param successBlock 成功
 @param failedBlock 失败
 */
+ (void)loginWithPlatform:(WZZShareManager_Platform)platform
             successBlock:(void(^)(NSDictionary * infoDic))successBlock
              failedBlock:(void(^)(NSError * error))failedBlock;

/**
 快速分享

 @param title 标题
 @param desc 内容
 @param image 图片
 @param shareUrl 链接
 @param vc 控制器
 */
+ (void)shareWithTitle:(NSString *)title
                  desc:(NSString *)desc
                 image:(id)image
              shareUrl:(NSString *)shareUrl
                    vc:(UIViewController *)vc;

/**
 分享到某平台

 @param platform 平台
 @param title 标题
 @param desc 内容
 @param image 图片
 @param shareUrl 链接
 @param vc 控制器
 */
+ (void)shareWithPlatform:(WZZShareManager_Platform)platform
                    Title:(NSString *)title
                     desc:(NSString *)desc
                    image:(id)image
                 shareUrl:(NSString *)shareUrl
                       vc:(UIViewController *)vc;

@end
