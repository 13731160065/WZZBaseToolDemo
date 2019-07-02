//
//  tmpViewController.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/14.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "tmpViewController.h"
#import "SafeAreaDemoVC.h"
#import "UIView+WZZAnimation.h"

@interface tmpViewController ()
{
    NSInteger number;
}
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@end

@implementation tmpViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"标题";
        number = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WZZBaseView * view2 = [[WZZBaseView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH-50, DEF_SCREEN_HEIGHT-DEF_TABBAR_HEIGHT-50, 50, 50)];
    [self.view addSubview:view2];
    
    view2.backgroundColor = [UIColor greenColor];
    
    WZZBaseView * view3 = [[WZZBaseView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    [_rightLabel addSubview:view3];
    [view3 setBackgroundColor:[UIColor yellowColor]];
}

- (IBAction)next:(id)sender {
    tmpViewController * vc = [[tmpViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)test:(id)sender {
    [sender wzz_startLoadingWithStyle:UIViewWZZLoading_Style_WiteBlack];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender wzz_endLoading];
    });
//    [_rightLabel dismissLikeLaunchPadDuration:0.3f complete:nil];
    
//    [_rightLabel moveWithDuration:0.3f fromPoint:_rightLabel.frame.origin toPoint:CGPointMake(_rightLabel.frame.origin.x-50, _rightLabel.frame.origin.y) complete:nil];
    
//    [_rightLabel moveWithSpeed:50/0.3 fromPoint:_rightLabel.frame.origin toPoint:CGPointMake(_rightLabel.frame.origin.x-50, _rightLabel.frame.origin.y) complete:nil];
    
//    SafeAreaDemoVC * vc = [[SafeAreaDemoVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    self.title = [self.title isEqualToString:@"一二三四五六七八九"]?@"标题":@"一二三四五六七八九";
    
//    self.basevc_navigationBarHidden = !self.basevc_navigationBarHidden;
//    [[WZZSingleManager shareInstance] changeWindowRoot:WZZSingleManager_ChangeWindowRoot_Tabbar];
//    [_topLabel wzz_startLoadingWithStyle:UIViewWZZLoading_Style_WiteBlack];
//    number++;
//    NSLog(@"开始加载%zd", number);
//    NSLog(@"%s", __func__);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"结束加载:%zd", number);
//        [_topLabel wzz_endLoading];
//    });
}

@end
