//
//  WZZBaseNVCItemView.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/29.
//  Copyright © 2018年 王泽众. All rights reserved.
//  弃用

#import <UIKit/UIKit.h>

@interface WZZBaseNVCItemView : UIView

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * rightImageView;
@property (nonatomic, strong) void(^clickBlock)(void);

/**
 初始化
 
 @param frame 坐标
 @param text 文字，nil则无文字
 @param textColor 文字颜色，nil默认黑色
 @param font 文字字体，nil默认15
 @param leftImage 左图片，nil则无左图
 @param rightImage 右图片，nil则无右图
 @param clickBlock 点击事件
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                    leftImage:(id)leftImage
                   rightImage:(id)rightImage
                   clickBlock:(void (^)(void))clickBlock;

/**
 初始化
 
 @param frame 坐标
 @param text 文字，nil则无文字
 @param textColor 文字颜色，nil默认黑色
 @param font 文字字体，nil默认15
 @param leftImage 左图片，nil则无左图
 @param leftImageWidth 左图宽，nil则默认frame高度
 @param rightImage 右图片，nil则无右图
 @param rightImageWidth 右图宽，nil则默认frame高度
 @param space 中间间隔
 @param clickBlock 点击事件
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                    leftImage:(id)leftImage
               leftImageWidth:(CGFloat)leftImageWidth
                   rightImage:(id)rightImage
              rightImageWidth:(CGFloat)rightImageWidth
                        space:(CGFloat)space
                   clickBlock:(void (^)(void))clickBlock;

/**
 居中
 */
- (void)makeCenter;

@end
