//
//  WZZBaseVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseVC.h"
#import "WZZBaseNVCAutoItemView.h"

@interface WZZBaseVC ()

/**
 顶部约束
 */
@property (strong, nonatomic) NSLayoutConstraint * realSelfView_topCon;

/**
 realSelfView下部约束
 */
@property (strong, nonatomic) NSLayoutConstraint * realSelfView_BottomCon;

/**
 nav高度约束
 */
@property (strong, nonatomic) NSLayoutConstraint * navgation_HeightCon;

/**
 状态栏高度
 */
@property (strong, nonatomic) NSLayoutConstraint * stateBar_HeightCon;

@end

@implementation WZZBaseVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.basevc_navigationBarColor = DEF_MAINCOLOR;
        self.xibJustInSelfView = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _superCreateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //刷新statebar前景色
    self.basevc_stateBarTintColor = self.basevc_stateBarTintColor;
}

//MARK:创建UI
- (void)_superCreateUI {
    //view颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if (self.xibJustInSelfView) {
        /**
         处理view适配
         将self.view交给___realSelfView
         xib加在___realSelfView上，而代码视图加在self.view上
         **/
        ___realSelfView = self.view;
        UIView * selfView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.view = selfView;
        [selfView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:___realSelfView];
        [___realSelfView setBackgroundColor:[UIColor clearColor]];
    }
    
    //状态栏
    [self createStateBar];
    
    //导航栏
    [self createNavigationBar];
    
    //横线
    [self createBarLineView];
    
    //左按钮
    WZZBaseNVCAutoItemSpace * b_space = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    WZZBaseNVCAutoItemImage * b_img = [WZZBaseNVCAutoItemImage imageWithWidth:30.0f];
    b_img.image = [UIImage imageNamed:@"base_back"];
    __weak WZZBaseVC * weakSelf = self;
    WZZBaseNVCAutoItemView * leftBtn = [WZZBaseNVCAutoItemView itemWithItemArr:@[b_space, b_img] clickBlock:^{
        [weakSelf basevc_backClick];
    }];
    self.basevc_leftButtonArr = @[leftBtn];
    
    //标题按钮
    WZZBaseNVCAutoItemSpace * t_space = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    WZZBaseNVCAutoItemLabel * t_label = [WZZBaseNVCAutoItemLabel labelWithMaxWidth:DEF_SCREEN_WIDTH-100 minWidth:0 line:0];
    t_label.text = @"标题";
    t_label.textAlignment = NSTextAlignmentCenter;
    t_label.textColor = [UIColor whiteColor];
    WZZBaseNVCAutoItemSpace * t_space2 = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    WZZBaseNVCAutoItemView * titleBtn = [WZZBaseNVCAutoItemView itemWithItemArr:@[t_space, t_label, t_space2] clickBlock:^{
        [weakSelf basevc_backClick];
    }];
    self.basevc_titleButtonArr = @[titleBtn];
    
    //右按钮
    WZZBaseNVCAutoItemSpace * r_space = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    WZZBaseNVCAutoItemLabel * r_label = [WZZBaseNVCAutoItemLabel labelWithMaxWidth:DEF_SCREEN_WIDTH-100 minWidth:0 line:0];
    WZZBaseNVCAutoItemSpace * r_space2 = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    WZZBaseNVCAutoItemView * rightBtn = [WZZBaseNVCAutoItemView itemWithItemArr:@[r_space, r_label, r_space2] clickBlock:^{
        [weakSelf basevc_backClick];
    }];
    self.basevc_rightButtonArr = @[rightBtn];
    
    //使用constant布局，frame布局将无效
    //以下方法关闭frame到autolayout的转换过渡
    //_basevc_stateBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (self.xibJustInSelfView) {
        ___realSelfView.translatesAutoresizingMaskIntoConstraints = NO;
        //给xib所在的___realSelfView初始布局
        _realSelfView_topCon = [NSLayoutConstraint constraintWithItem:___realSelfView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        _realSelfView_topCon.active = YES;
        [NSLayoutConstraint constraintWithItem:___realSelfView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:___realSelfView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
        _realSelfView_BottomCon = [NSLayoutConstraint constraintWithItem:___realSelfView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-DEF_BOTTOM_SAFEAREA_HEIGHT];
        _realSelfView_BottomCon.active = YES;
    }
    
    //刷新ui
    [self _superReloadUI];
}

//MARK:刷新UI
- (void)_superReloadUI {
    //视图
    _realSelfView_BottomCon.constant = _basevc_tabbarPlace?-(DEF_BOTTOM_SAFEAREA_HEIGHT+DEF_TABBAR_HEIGHT):-DEF_BOTTOM_SAFEAREA_HEIGHT;
    
    //导航栏
    _navgation_HeightCon.constant = _basevc_navigationBarHidden?0:44;
    _basevc_navigationBar.hidden = _basevc_navigationBarHidden;
    
    //状态栏
    CGFloat stateBarHeight = DEF_STATEBAR_HEIGHT;
    _basevc_stateBarHidden = !UIDeviceOrientationIsPortrait([self getOrientation]);//状态栏在横屏状态下隐藏
    if (_basevc_stateBarHidden) {//当状态栏为隐藏时高度为0
        stateBarHeight = 0;
    }
    _stateBar_HeightCon.constant = stateBarHeight;
    _basevc_stateBar.hidden = _basevc_stateBarHidden;
}

//MARK:返回点击
- (void)basevc_backClick {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 属性
//MARK:标题
- (void)setBasevc_titleButtonArr:(NSArray <WZZBaseNVCAutoItemView *> *)basevc_titleButtonArr {
    [_basevc_titleLabel removeFromSuperview];
    _basevc_titleButtonArr = basevc_titleButtonArr;
    if (_basevc_titleButtonArr.count) {
        _basevc_titleLabel = [WZZBaseNVCAutoItemView itemWithItemArr:basevc_titleButtonArr];
        [_basevc_navigationBar addSubview:_basevc_titleLabel];
        _basevc_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        //约束，上下x居中
        [NSLayoutConstraint constraintWithItem:_basevc_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:_basevc_titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:_basevc_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeCenterX multiplier:1 constant:0].active = YES;
    }
}

//MARK:左按钮
- (void)setBasevc_leftButtonArr:(NSArray <WZZBaseNVCAutoItemView *> *)basevc_leftButtonArr {
    [_basevc_leftButton removeFromSuperview];
    _basevc_leftButtonArr = basevc_leftButtonArr;
    if (basevc_leftButtonArr.count) {
        _basevc_leftButton = [WZZBaseNVCAutoItemView itemWithItemArr:basevc_leftButtonArr];
        [_basevc_navigationBar addSubview:_basevc_leftButton];
        _basevc_leftButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        //约束，上下左
        [NSLayoutConstraint constraintWithItem:_basevc_leftButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:_basevc_leftButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:_basevc_leftButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    }
}

//MARK:右按钮
- (void)setBasevc_rightButtonArr:(NSArray <WZZBaseNVCAutoItemView *> *)basevc_rightButtonArr {
    [_basevc_rightButton removeFromSuperview];
    _basevc_rightButtonArr = basevc_rightButtonArr;
    if (basevc_rightButtonArr.count) {
        _basevc_rightButton = [WZZBaseNVCAutoItemView itemWithItemArr:basevc_rightButtonArr];
        [_basevc_navigationBar addSubview:_basevc_rightButton];
        _basevc_rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        //约束，上下右
        [NSLayoutConstraint constraintWithItem:_basevc_rightButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:_basevc_rightButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:_basevc_rightButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    }
}

//MARK:设置标题
- (void)setTitle:(NSString *)title {
    for (UIView * view in self.basevc_titleLabel.autoItemArr) {
        if ([view isKindOfClass:[WZZBaseNVCAutoItemLabel class]]) {
            WZZBaseNVCAutoItemLabel * label = (WZZBaseNVCAutoItemLabel *)view;
            label.text = title;
            return;
        } else if ([view isKindOfClass:[WZZBaseNVCAutoItemView class]]) {
            WZZBaseNVCAutoItemView * v2 = (WZZBaseNVCAutoItemView *)view;
            for (UIView * view2 in v2.autoItemArr) {
                if ([view2 isKindOfClass:[WZZBaseNVCAutoItemLabel class]]) {
                    WZZBaseNVCAutoItemLabel * label = (WZZBaseNVCAutoItemLabel *)view2;
                    label.text = title;
                    return;
                }
            }
        }
    }
}

//MARK:隐藏导航栏
- (void)setBasevc_navigationBarHidden:(BOOL)basevc_navigationBarHidden {
    _basevc_navigationBarHidden = basevc_navigationBarHidden;
    [self _superReloadUI];
}

//MARK:隐藏状态栏
- (void)setBasevc_stateBarHidden:(BOOL)basevc_stateBarHidden {
    _basevc_stateBarHidden = basevc_stateBarHidden;
    [self _superReloadUI];
}

//MARK:导航栏颜色
- (void)setBasevc_navigationBarColor:(UIColor *)basevc_navigationBarColor {
    _basevc_navigationBarColor = basevc_navigationBarColor;
    [_basevc_stateBar setBackgroundColor:basevc_navigationBarColor];
    [_basevc_navigationBar setBackgroundColor:basevc_navigationBarColor];
}

//MARK:底部导航栏留空
- (void)setBasevc_tabbarPlace:(BOOL)basevc_tabbarPlace {
    _basevc_tabbarPlace = basevc_tabbarPlace;
    [self _superReloadUI];
}

//MARK:状态栏颜色
- (void)setBasevc_stateBarTintColor:(WZZBaseVC_StateBarTintColor)basevc_stateBarTintColor {
    _basevc_stateBarTintColor = basevc_stateBarTintColor;
    //状态栏
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 初始化UI
//状态栏
- (void)createStateBar {
    _basevc_stateBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_STATEBAR_HEIGHT)];
    [self.view addSubview:_basevc_stateBar];
    
    //给statebar布局，上左右高
    _basevc_stateBar.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:_basevc_stateBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_stateBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_stateBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    self.stateBar_HeightCon = [NSLayoutConstraint constraintWithItem:_basevc_stateBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:DEF_STATEBAR_HEIGHT];
    self.stateBar_HeightCon.active = YES;
}

- (void)createNavigationBar {
    //创建navigationBar
    _basevc_navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_basevc_stateBar.frame), _basevc_stateBar.bounds.size.width, 44)];
    [self.view addSubview:_basevc_navigationBar];
    
    self.basevc_navigationBarColor = DEF_MAINCOLOR;
    
    _basevc_navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    //给navigation布局，上左右高
    [NSLayoutConstraint constraintWithItem:_basevc_navigationBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_stateBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_navigationBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_navigationBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    _navgation_HeightCon = [NSLayoutConstraint constraintWithItem:_basevc_navigationBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44];
    _navgation_HeightCon.active = YES;
}

//横线
- (void)createBarLineView {
    _barLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _basevc_navigationBar.frame.size.height-1, _basevc_navigationBar.frame.size.width, 1)];
    [_basevc_navigationBar addSubview:_barLineView];
    [_barLineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    //给navigation的线布局，下左右高
    _barLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:_barLineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_barLineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_barLineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_barLineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1].active = YES;
}

#pragma mark - 系统方法
//- (BOOL)prefersStatusBarHidden {
//    return _basevc_stateBarHidden;
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    switch (_basevc_stateBarTintColor) {
        case WZZBaseVC_StateBarTintColor_Black:
        {
            return UIStatusBarStyleDefault;
        }
            break;
        case WZZBaseVC_StateBarTintColor_White:
        {
            return UIStatusBarStyleLightContent;
        }
            break;
            
        default:
        {
            return ([WZZBaseVC isLightColor:_basevc_navigationBarColor])?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
        }
            break;
    }
}

- (BOOL)shouldAutorotate {
    [self _superReloadUI];
    return YES;
}

#pragma mark - 辅助方法

- (UIDeviceOrientation)getOrientation {
    return (UIDeviceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
}

//判断颜色是不是亮色
+ (BOOL)isLightColor:(UIColor *)color {
    if (!color) {
        return YES;
    }
    CGFloat components[3];
    [self getRGBComponents:components forColor:color];
    //    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    
    CGFloat num = components[0] + components[1] + components[2];
    if (num < 382) {
        return NO;
    } else {
        return YES;
    }
}

//获取RGB值
+ (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 bitmapInfo);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component];
    }
}

@end
