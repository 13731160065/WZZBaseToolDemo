//
//  WZZTabbarVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZTabbarVC.h"
#import "WZZBaseVC.h"
#import "WZZBaseNVC.h"
#import "tmpViewController.h"

@interface WZZTabbarVC ()<UITabBarControllerDelegate>
{
    BOOL (^_tabbarItemDidSelected)(NSInteger);
}

@end

@implementation WZZTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

//MARK:添加控制器
- (void)addVC:(WZZBaseVC *)vc
  selectImage:(UIImage *)selectImage
  normalImage:(UIImage *)normalImage {
    vc.tabBarItem.title = nil;
    vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGFloat offset = 6;
    
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
    
    WZZBaseNVC * nvc = [[WZZBaseNVC alloc] initWithRootViewController:vc];
    NSMutableArray * vcArr = [NSMutableArray arrayWithArray:self.viewControllers];
    [vcArr addObject:nvc];
    self.viewControllers = vcArr;
}

//MARK:tabbar点击回调
- (void)itemDidSelected:(BOOL (^)(NSInteger))selectClick {
    _tabbarItemDidSelected = selectClick;
}

#pragma mark - tabbarController代理
- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    if (_tabbarItemDidSelected) {
        return _tabbarItemDidSelected([self.viewControllers indexOfObject:viewController]);
    }
    return YES;
}

@end
