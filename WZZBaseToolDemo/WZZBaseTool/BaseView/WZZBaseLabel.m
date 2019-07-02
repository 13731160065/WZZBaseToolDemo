//
//  WZZBaseLabel.m
//  SiNanQingSu
//
//  Created by 王泽众 on 2018/6/23.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseLabel.h"

@implementation WZZBaseLabel

#pragma mark - WZZBaseView
- (void)setClip:(BOOL)clip {
    self.clipsToBounds = clip;
}

- (void)setCornerRadio:(CGFloat)cornerRadio {
    self.layer.cornerRadius = cornerRadio;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (void)setShadowAlpha:(CGFloat)shadowAlpha {
    self.layer.shadowOpacity = shadowAlpha;
}

#pragma mark - 特有

@end
