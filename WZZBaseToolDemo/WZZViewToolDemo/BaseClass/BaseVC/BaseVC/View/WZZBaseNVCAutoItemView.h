//
//  WZZBaseNVCAutoItemView.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/9/7.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseNVCItemView.h"

@interface WZZBaseNVCAutoItemView : UIView

@property (nonatomic, strong, readonly) NSArray * autoItemArr;
@property (nonatomic, strong) void(^itemClickBlock)(void);

/**
 初始化item

 @param itemArr item数组
 @return 点击事件
 */
+ (instancetype)itemWithItemArr:(NSArray *)itemArr;

/**
 初始化item

 @param itemArr item内容数组
 @param clickBlock 点击事件
 @return item
 */
+ (instancetype)itemWithItemArr:(NSArray *)itemArr
                     clickBlock:(void(^)(void))clickBlock;

@end

#pragma mark - 图片
@interface WZZBaseNVCAutoItemImage : UIImageView

@property (nonatomic, assign, readonly) CGFloat imgWidth;
@property (nonatomic, assign, readonly) CGFloat imgHeight;

+ (instancetype)imageWithWidth:(CGFloat)width;
+ (instancetype)imageWithHeight:(CGFloat)height;

@end

#pragma mark - 空间
@interface WZZBaseNVCAutoItemSpace : UIView

@property (nonatomic, assign, readonly) CGFloat spaceWidth;

+ (instancetype)spaceWithWidth:(CGFloat)width;

@end

#pragma mark - 文字
@interface WZZBaseNVCAutoItemLabel : UILabel

@property (nonatomic, assign, readonly) CGFloat maxWidth;
@property (nonatomic, assign, readonly) CGFloat minWidth;
@property (nonatomic, assign, readonly) NSInteger line;

+ (instancetype)labelWithMaxWidth:(CGFloat)maxWidth
                         minWidth:(CGFloat)minWidth
                             line:(NSInteger)line;

@end
