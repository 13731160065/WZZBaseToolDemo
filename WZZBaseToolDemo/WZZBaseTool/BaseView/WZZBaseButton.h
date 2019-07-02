//
//  WZZBaseButton.h
//  SiNanQingSu
//
//  Created by 王泽众 on 2018/6/22.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WZZBaseButton : UIButton

#pragma mark - 继承WZZBaseView

@property (nonatomic, assign) IBInspectable BOOL clip;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadio;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor * borderColor;
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;
@property (nonatomic, assign) IBInspectable UIColor * shadowColor;
@property (nonatomic, assign) IBInspectable CGFloat shadowAlpha;

#pragma mark - 特有

@end
