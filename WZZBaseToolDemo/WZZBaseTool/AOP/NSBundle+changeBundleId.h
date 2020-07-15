//
//  NSBundle+changeBundleId.h
//  fff3
//
//  Created by 王泽众 on 2018/3/22.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (changeBundleId)

@property (strong, nonatomic) NSString * nowBundleId;

/**
 修改包名

 @param bundleId 包名，nil为默认包名
 */
- (void)changeBundleIdentifier:(NSString *)bundleId;

@end
