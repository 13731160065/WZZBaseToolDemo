//
//  WZZTmpView.m
//  WZZBaseProject
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 王泽众. All rights reserved.
//

#import "WZZTmpView.h"

@interface WZZTmpView ()


@property (weak, nonatomic) IBOutlet UILabel *aLabel;
@property (assign, nonatomic) NSInteger idxx;

@end

@implementation WZZTmpView

- (IBAction)buttonClick:(id)sender {
    _aLabel.text = @(_idxx++).stringValue;
}


@end
