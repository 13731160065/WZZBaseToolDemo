//
//  WZZBaseNVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseNVC.h"

@interface WZZBaseNVC ()

@end

@implementation WZZBaseNVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏原始navigationbar
    [self.navigationBar setHidden:YES];
    
    [self createUI];
}

- (void)createUI {
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 系统方法
//- (BOOL)prefersStatusBarHidden {
//    return [self.visibleViewController prefersStatusBarHidden];
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.visibleViewController preferredStatusBarStyle];
}

- (BOOL)shouldAutorotate {
    return [self.visibleViewController shouldAutorotate];
}

@end
