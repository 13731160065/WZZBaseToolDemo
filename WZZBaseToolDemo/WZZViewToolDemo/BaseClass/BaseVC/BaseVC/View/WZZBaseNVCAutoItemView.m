//
//  WZZBaseNVCAutoItemView.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/9/7.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseNVCAutoItemView.h"

@implementation WZZBaseNVCAutoItemView

+ (instancetype)itemWithItemArr:(NSArray *)itemArr {
    return [self itemWithItemArr:itemArr clickBlock:nil];
}

+ (instancetype)itemWithItemArr:(NSArray *)itemArr
                     clickBlock:(void (^)(void))clickBlock {
    WZZBaseNVCAutoItemView * view = [[WZZBaseNVCAutoItemView alloc] init];
    view->_autoItemArr = [NSArray arrayWithArray:itemArr];
    view->_itemClickBlock = clickBlock;
    
    //左视图
    UIView * leftView = [[UIView alloc] init];
    [view addSubview:leftView];
    leftView.translatesAutoresizingMaskIntoConstraints = NO;
    //上左下宽
    [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0].active = YES;
    
    for (UIView * aView in view.autoItemArr) {
        if ([aView isKindOfClass:[WZZBaseNVCAutoItemLabel class]]) {
            WZZBaseNVCAutoItemLabel * aa = (WZZBaseNVCAutoItemLabel *)aView;
            [view addSubview:aa];
            //上左下宽最大最小
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:aa.maxWidth].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:aa.minWidth].active = YES;
            leftView = aView;
        } else if ([aView isKindOfClass:[WZZBaseNVCAutoItemSpace class]]) {
            WZZBaseNVCAutoItemSpace * aa = (WZZBaseNVCAutoItemSpace *)aView;
            [view addSubview:aa];
            //上坐下宽
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:aa.spaceWidth].active = YES;
            leftView = aView;
        } else if ([aView isKindOfClass:[WZZBaseNVCAutoItemImage class]]) {
            WZZBaseNVCAutoItemImage * aa = (WZZBaseNVCAutoItemImage *)aView;
            [view addSubview:aa];
            //上坐下宽或高
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
            if (aa.imgWidth > 0.001) {
                [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:aa.imgWidth].active = YES;
            } else if (aa.imgHeight > 0.001) {
                [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:aa.imgHeight].active = YES;
            }
            leftView = aView;
        } else if ([aView isKindOfClass:[WZZBaseNVCAutoItemView class]])  {
            WZZBaseNVCAutoItemView * aa = (WZZBaseNVCAutoItemView *)aView;
            [view addSubview:aa];
            //上左下
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
            [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
            leftView = aView;
        }
        aView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    
    if (clickBlock) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:button];
        [button addTarget:view action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        //上下左右
        [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    }
    
    return view;
}

- (void)buttonClick {
    if (self.itemClickBlock) {
        self.itemClickBlock();
    }
}

@end

#pragma mark - 图片
@implementation WZZBaseNVCAutoItemImage : UIImageView

+ (instancetype)imageWithWidth:(CGFloat)width {
    WZZBaseNVCAutoItemImage * item = [[WZZBaseNVCAutoItemImage alloc] init];
    item->_imgWidth = width;
    item->_imgHeight = 0;
    item.contentMode = UIViewContentModeScaleAspectFit;
    return item;
}

+ (instancetype)imageWithHeight:(CGFloat)height {
    WZZBaseNVCAutoItemImage * item = [[WZZBaseNVCAutoItemImage alloc] init];
    item->_imgHeight = height;
    item->_imgWidth = 0;
    item.contentMode = UIViewContentModeScaleAspectFit;
    return item;
}

//- (void)setImage:(UIImage *)image {
//    //计算宽高
//    [super setImage:image];
//}

@end

#pragma mark - 空间
@implementation WZZBaseNVCAutoItemSpace : UIView

+ (instancetype)spaceWithWidth:(CGFloat)width {
    WZZBaseNVCAutoItemSpace * item = [[WZZBaseNVCAutoItemSpace alloc] init];
    item->_spaceWidth = width;
    return item;
}

@end

#pragma mark - 文字
@implementation WZZBaseNVCAutoItemLabel : UILabel

+ (instancetype)labelWithMaxWidth:(CGFloat)maxWidth
                         minWidth:(CGFloat)minWidth
                             line:(NSInteger)line {
    WZZBaseNVCAutoItemLabel * item = [[WZZBaseNVCAutoItemLabel alloc] init];
    item->_maxWidth = maxWidth;
    item->_minWidth = minWidth;
    item->_line = line;
    return item;
}

@end
