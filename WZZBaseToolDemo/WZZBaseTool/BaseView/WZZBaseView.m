//
//  WZZBaseView.m
//  SiNanQingSu
//
//  Created by 王泽众 on 2018/6/22.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseView.h"

@implementation WZZBaseView

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

@end
