//
//  WZZLogTool.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/8/30.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZLogTool.h"
#import "WZZLogView.h"

static WZZLogTool * wzzLogTool;

@interface WZZLogTool () {
    
}

@property (strong, nonatomic) UILabel * logPointView;
@property (strong, nonatomic) WZZLogView * logBackView;

@end

@implementation WZZLogTool

+ (instancetype)shareInstance {
#if WZZLogTool_Is_log_def_open
    if (!wzzLogTool) {
        wzzLogTool = [[WZZLogTool alloc] init];
        wzzLogTool.logStr = [NSMutableString string];
    }
#endif
    return wzzLogTool;
}

+ (void)markLog:(NSString *)log {
    NSString * addLog = [NSString stringWithFormat:@"%@\n", log];
    [[WZZLogTool shareInstance].logStr appendString:addLog];
    if (![WZZLogTool shareInstance].logBackView.hidden) {
        [[WZZLogTool shareInstance].logBackView updateLog:addLog];
    }
}

+ (void)registerShowLog:(WZZLogTool_ShowAction)action {
    [self registerShowLog:action window:[UIApplication sharedApplication].keyWindow];
}

+ (void)registerShowLog:(WZZLogTool_ShowAction)action
                 window:(UIWindow *)window {
#if WZZLogTool_Is_log_def_open
#else
    return;
#endif
    action = WZZLogTool_ShowAction_PointView;
    switch (action) {
        case WZZLogTool_ShowAction_DoubleVoiceUpDoubleVoiceDown:
        {
            
        }
            break;
        case WZZLogTool_ShowAction_PointView:
        {
            if (![WZZLogTool shareInstance].logPointView) {
                [WZZLogTool shareInstance].logPointView = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2.0f, 50, 50)];
                [WZZLogTool shareInstance].logPointView.text = @"日志";
                [WZZLogTool shareInstance].logPointView.textColor = [UIColor whiteColor];
                [WZZLogTool shareInstance].logPointView.textAlignment = NSTextAlignmentCenter;
                [WZZLogTool shareInstance].logPointView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
                [WZZLogTool shareInstance].logPointView.userInteractionEnabled = YES;
                UIPanGestureRecognizer * panGes = [[UIPanGestureRecognizer alloc] initWithTarget:[WZZLogTool shareInstance] action:@selector(panGes:)];
                [[WZZLogTool shareInstance].logPointView addGestureRecognizer:panGes];
                UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:[WZZLogTool shareInstance] action:@selector(logTap:)];
                [[WZZLogTool shareInstance].logPointView addGestureRecognizer:tapGes];
            }
        }
            break;
            
        default:
            break;
    }
    
    if (![WZZLogTool shareInstance].logBackView) {
        [WZZLogTool shareInstance].logBackView = [[[NSBundle mainBundle] loadNibNamed:@"WZZLogView" owner:nil options:nil] firstObject];
        [WZZLogTool shareInstance].logBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-200, [UIScreen mainScreen].bounds.size.width, 200);
        [WZZLogTool shareInstance].logBackView.hidden = YES;
        [WZZLogTool shareInstance].logBackView.clearClick = ^{
            [WZZLogTool shareInstance].logStr = [NSMutableString string];
        };
        [WZZLogTool shareInstance].logBackView.closeClick = ^{
            [WZZLogTool shareInstance].logPointView.hidden = NO;
            [WZZLogTool shareInstance].logBackView.hidden = YES;
        };
    }
    
    [window addSubview:[WZZLogTool shareInstance].logPointView];
    [window addSubview:[WZZLogTool shareInstance].logBackView];
}

//MARK:点击手势
- (void)logTap:(UITapGestureRecognizer *)tap {
    self.logPointView.hidden = YES;
    self.logBackView.hidden = NO;
    [self.logBackView updateAllLog:self.logStr];
}

//MARK:平移手势
- (void)panGes:(UIPanGestureRecognizer*)pan {
    CGPoint point = [pan translationInView:pan.view];
    pan.view.center = CGPointMake(pan.view.center.x+point.x, pan.view.center.y+point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:pan.view];
}

@end
