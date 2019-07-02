//
//  WZZLogView.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/8/30.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZLogView.h"
#import "WZZLogTool.h"

@implementation WZZLogView

- (void)awakeFromNib {
    [super awakeFromNib];
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    [self.moveView addGestureRecognizer:pan];
}

//MARK:平移手势
- (void)panGes:(UIPanGestureRecognizer*)pan{
    CGPoint point = [pan translationInView:pan.view];
    self.center = CGPointMake(self.center.x, self.center.y+point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:pan.view];
}

//MARK:更新所有日志
- (void)updateAllLog:(NSString *)str {
    NSAttributedString * strAtt = [[NSAttributedString alloc] initWithString:str];
    self.logTV.attributedText = strAtt;
}

//MARK:更新日志
- (void)updateLog:(NSString *)str {
    NSAttributedString * strAtt = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc] initWithAttributedString:self.logTV.attributedText];
    [att appendAttributedString:strAtt];
    self.logTV.attributedText = att;
}

- (IBAction)closeClick:(id)sender {
    if (self.closeClick) {
        self.closeClick();
    }
}

- (void)searchClick {
    NSString * ruleStr = [NSString stringWithFormat:@"(%@)", self.searchTF.text];
    NSString * searchStr = self.logTV.text;
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:searchStr];
    
    //正则
    NSError * err;
    NSRegularExpression * reg = [[NSRegularExpression alloc] initWithPattern:ruleStr options:NSRegularExpressionCaseInsensitive error:&err];
    if (err) {
        return;
    }
    //正则检索
    NSArray <NSTextCheckingResult *>* arr = [reg matchesInString:searchStr options:0 range:NSMakeRange(0, searchStr.length)];
    for (NSTextCheckingResult * res in arr) {
        [attStr addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:res.range];
    }
    
    self.logTV.attributedText = attStr;
}

- (IBAction)tfEditChange:(UITextField *)sender {
    if (!sender.text.length) {
        self.logTV.attributedText = [[NSAttributedString alloc] initWithString:self.logTV.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchClick];
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)clearClick:(id)sender {
    self.logTV.attributedText = [[NSAttributedString alloc] initWithString:@""];
    if (self.clearClick) {
        self.clearClick();
    }
}

@end
