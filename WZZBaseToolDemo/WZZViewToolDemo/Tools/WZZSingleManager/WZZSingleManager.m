//
//  WZZSingleManager.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZSingleManager.h"
#import "WZZTabbarVC.h"
#import "WZZUserInfoObject.h"
#import "tmpViewController.h"

typedef enum : NSUInteger {
    WZZSingleManager_ChangeWindowAnimation_Present,
    WZZSingleManager_ChangeWindowAnimation_Tab,
} WZZSingleManager_ChangeWindowAnimation;

static WZZSingleManager * singleManager;

@interface WZZSingleManager ()

@property (assign, nonatomic) WZZSingleManager_ChangeWindowAnimation changeAnim;
@property (strong, nonatomic) tmpViewController * loginVC;

@end

@implementation WZZSingleManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleManager = [[WZZSingleManager alloc] init];
        singleManager.changeAnim = WZZSingleManager_ChangeWindowAnimation_Tab;
    });
    return singleManager;
}

//初始化tabbar
- (void)setupTabbar {
    //tabbar
    WZZTabbarVC * tabbarVC = [[WZZTabbarVC alloc] init];
    
    //添加vc
    tmpViewController * homeVC = [[tmpViewController alloc] init];
    homeVC.basevc_tabbarPlace = YES;
    homeVC.basevc_navigationBarHidden = NO;
    [tabbarVC addVC:homeVC selectImage:[UIImage imageNamed:@"首页_hover"] normalImage:[UIImage imageNamed:@"首页_normal"]];
    
    //添加vc
    tmpViewController * starLetterVC = [[tmpViewController alloc] init];
    starLetterVC.basevc_tabbarPlace = YES;
    starLetterVC.basevc_navigationBarHidden = NO;
    [tabbarVC addVC:starLetterVC selectImage:[UIImage imageNamed:@"星信_hover"] normalImage:[UIImage imageNamed:@"星信_normal"]];
    
    //添加vc
    tmpViewController * ba3 = [[tmpViewController alloc] init];
    ba3.basevc_tabbarPlace = YES;
    ba3.basevc_navigationBarHidden = NO;
    [tabbarVC addVC:ba3 selectImage:[UIImage imageNamed:@"星语_hover"] normalImage:[UIImage imageNamed:@"星语_normal"]];
    
    //添加vc
    tmpViewController * myVC = [[tmpViewController alloc] init];
    myVC.basevc_tabbarPlace = YES;
    myVC.basevc_navigationBarHidden = NO;
    [tabbarVC addVC:myVC selectImage:[UIImage imageNamed:@"我的_hover"] normalImage:[UIImage imageNamed:@"我的_normal"]];
    
    self.appDelegate.window.rootViewController = tabbarVC;
}

//修改window
- (void)changeWindowRoot:(WZZSingleManager_ChangeWindowRoot)changeType {
    if (!_appDelegate) {
        return;
    }
    switch (changeType) {
        case WZZSingleManager_ChangeWindowRoot_Login:
        {
            [self _changeToLogin];
        }
            break;
        case WZZSingleManager_ChangeWindowRoot_Tabbar:
        {
            [self _changeToTabbar];
        }
            break;
            
        default:
            break;
    }
    [WZZLogTool registerShowLog:WZZLogTool_ShowAction_PointView];
}

//变到tabbar
- (void)_changeToTabbar {
    switch (_changeAnim) {
        case WZZSingleManager_ChangeWindowAnimation_Tab:
        {
            [self setupTabbar];
        }
            break;
            
        case WZZSingleManager_ChangeWindowAnimation_Present:
        {
            [_loginVC.navigationController dismissViewControllerAnimated:YES
                                                              completion:nil];
        }
            break;
            
        default:
            break;
    }
}

//变到登录
- (void)_changeToLogin {
    switch (_changeAnim) {
        case WZZSingleManager_ChangeWindowAnimation_Tab:
        {
            //window
            _loginVC = [[tmpViewController alloc] init];
            self.appDelegate.window.rootViewController = [[WZZBaseNVC alloc] initWithRootViewController:_loginVC];
        }
            break;
        case WZZSingleManager_ChangeWindowAnimation_Present:
        {
            _loginVC = [[tmpViewController alloc] init];
            [_loginVC.basevc_leftButton removeFromSuperview];
            WZZBaseNVC * nvc = [[WZZBaseNVC alloc] initWithRootViewController:_loginVC];
            [self.appDelegate.window.rootViewController presentViewController:nvc animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

//MARK:自动判断登录
+ (void)autoLoginBlock:(void (^)(void))loginBlock {
    if ([self isLogin]) {
        if (loginBlock) {
            loginBlock();
        }
    } else {
        [[WZZSingleManager shareInstance] changeWindowRoot:WZZSingleManager_ChangeWindowRoot_Login];
    }
}

//MARK:是否登录
+ (BOOL)isLogin {
    return ([WZZUserInfoObject shareInstance].userId && ![[WZZUserInfoObject shareInstance].userId isEqualToString:@""]);
}

//MARK:是不是第一次
- (BOOL)isFirst:(NSString *)key {
    return ![[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@_WZZSingleManager_First", key]];
}

//MARK:标记第一次
- (void)markFirst:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@_WZZSingleManager_First", key]];
}

@end

