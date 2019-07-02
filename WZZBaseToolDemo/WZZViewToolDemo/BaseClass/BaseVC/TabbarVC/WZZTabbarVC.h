//
//  WZZTabbarVC.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZZTabbarVC : UITabBarController

/**
 选项被点击

 @param selectClick 点击回调
 */
- (void)itemDidSelected:(BOOL(^)(NSInteger index))selectClick;

/**
 添加视图控制器

 @param vc 视图控制器
 @param selectImage 选中图
 @param normalImage 未选中图
 */
- (void)addVC:(WZZBaseVC *)vc
  selectImage:(UIImage *)selectImage
  normalImage:(UIImage *)normalImage;

@end
