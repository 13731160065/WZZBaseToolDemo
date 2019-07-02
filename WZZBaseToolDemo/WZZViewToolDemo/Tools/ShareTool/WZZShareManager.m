//
//  WZZShareManager.m
//  SiNanQingSu
//
//  Created by 王泽众 on 2018/6/19.
//  Copyright © 2018年 王泽众. All rights reserved.
//

//开关，用之前先打开
#define WZZShareManager_Open 0

#import "WZZShareManager.h"

#if WZZShareManager_Open
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#endif

static WZZShareManager * wzzSharemanager;

@interface WZZShareManager ()

@end

@implementation WZZShareManager

#if WZZShareManager_Open
+ (void)loginWithPlatform:(WZZShareManager_Platform)platform
             successBlock:(void (^)(NSDictionary *))successBlock
              failedBlock:(void (^)(NSError *))failedBlock {
    UMSocialPlatformType type;
    switch (platform) {
        case WZZShareManager_Platform_QQ:
        {
            type = UMSocialPlatformType_QQ;
        }
            break;
        case WZZShareManager_Platform_WX:
        {
            type = UMSocialPlatformType_WechatSession;
        }
            break;
            
        default:
        {
            return;
        }
            break;
    }
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
        
        if (error) {
            if (failedBlock) {
                failedBlock(error);
            }
        } else {
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            dic[@"openid"] = resp.uid;
            if (successBlock) {
                successBlock(dic);
            }
        }
    }];
}

//快速分享
+ (void)shareWithTitle:(NSString *)title
                  desc:(NSString *)desc
                 image:(id)image
              shareUrl:(NSString *)shareUrl
                    vc:(UIViewController *)vc {
    //平台
    [UMSocialUIManager setPreDefinePlatforms:@[
                                               @(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_WechatFavorite),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_Qzone)]];
    
    //ui
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareWithPlatform:platformType Title:title desc:desc image:image shareUrl:shareUrl vc:vc];
    }];
}

//分享到平台
+ (void)shareWithPlatform:(WZZShareManager_Platform)platform
                    Title:(NSString *)title
                     desc:(NSString *)desc
                    image:(id)image
                 shareUrl:(NSString *)shareUrl
                       vc:(UIViewController *)vc {
    //分享内容
    UMSocialMessageObject * obj = [UMSocialMessageObject messageObject];
    obj.shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:image];
    UMShareWebpageObject * shareObj = obj.shareObject;
    shareObj.webpageUrl = shareUrl;
    
    [[UMSocialManager defaultManager] shareToPlatform:platform messageObject:obj currentViewController:vc completion:nil];
}
#endif

@end
