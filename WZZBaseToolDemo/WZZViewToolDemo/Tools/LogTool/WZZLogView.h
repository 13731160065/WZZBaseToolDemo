//
//  WZZLogView.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/8/30.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZZLogView : UIView<UITextFieldDelegate>

/**
 搜索框
 */
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

/**
 移动视图
 */
@property (weak, nonatomic) IBOutlet UIView *moveView;

/**
 log框
 */
@property (weak, nonatomic) IBOutlet UITextView *logTV;

/**
 关闭点击
 */
@property (nonatomic, strong) void(^closeClick)(void);

/**
 清空点击
 */
@property (nonatomic, strong) void(^clearClick)(void);

/**
 更新所有日志

 @param str 日志
 */
- (void)updateAllLog:(NSString *)str;

/**
 更新新增日志

 @param str 新日志
 */
- (void)updateLog:(NSString *)str;

@end
