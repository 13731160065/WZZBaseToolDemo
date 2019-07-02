//
//  WZZBaseTool.h
//  WZZViewToolDemo
//
//  Created by wyq_iMac on 2019/7/2.
//  Copyright © 2019 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 系统宏

//MARK:获取系统版本号
#define WZZ_System_SysVersion [UIDevice currentDevice].systemVersion.doubleValue

//MARK:获取app的bundleid
#define WZZ_System_AppBundleId [[NSBundle mainBundle] bundleIdentifier]

//MARK:获取app的build号
#define WZZ_System_AppBuildNum [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"]

//MARK:获取app的版本号
#define WZZ_System_AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//MARK:弱引用self
#define WZZ_WeakSelf __weak typeof(self) weakSelf = self

#pragma mark - 尺寸(iPhoneX适配)

//MARK:是不是IPhoneX
#define WZZ_Size_ISIPHONEX [WZZBaseTool wzz_isIphoneX]

//MARK:底部安全区高度
#define WZZ_Size_BOTTOM_SAFEAREA_HEIGHT (WZZ_Size_ISIPHONEX ? 33.0f : 0.0f)

//MARK:StateBar高度
#define WZZ_Size_STATEBAR_HEIGHT (WZZ_Size_ISIPHONEX ? 44.0f : 20.0f)

//MARK:NavigationBar高度
#define WZZ_Size_NAVIGATIONBAR_HEIGHT (44.0f)

//MARK:StateBar+NavigationBar高度
#define WZZ_Size_UPBAR_HEIGHT (WZZ_Size_ISIPHONEX ? 44.0f : 20.0f)

//MARK:tabbar高度
#define WZZ_Size_TABBAR_HEIGHT 48.0f

//屏幕宽
#define WZZ_Size_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

//屏幕高
#define WZZ_Size_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height-WZZ_Size_BOTTOM_SAFEAREA_HEIGHT)

#pragma mark - 颜色

//MARK:哈希色值
#define WZZ_Color_HEXCOLOR(rgbValue) [UIColor \
colorWithRed:((double)((rgbValue & 0xFF0000) >> 16))/255.0f \
green:((double)((rgbValue & 0xFF00) >> 8))/255.0f \
blue:((double)(rgbValue & 0xFF))/255.0f alpha:1.0f]

//MARK:哈希色A值
#define WZZ_Color_HEXACOLOR(rgbValue, ca) [UIColor \
colorWithRed:((double)((rgbValue & 0xFF0000) >> 16))/255.0f \
green:((double)((rgbValue & 0xFF00) >> 8))/255.0f \
blue:((double)(rgbValue & 0xFF))/255.0f alpha:(double)ca]

//MARK:RGBA色值
#define WZZ_Color_RGBACOLOR(cr, cg, cb, ca) [UIColor \
colorWithRed:((double)cr)/255.0f \
green:((double)cg)/255.0f \
blue:((double)cb)/255.0f alpha:((double)ca)]

#pragma mark - 本地化
//获取当前文件名
#define WZZ_Localized_GETFILENAME [[[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent] stringByDeletingPathExtension]
//根据当前文件定位  string文件
#define WZZ_Localized_FileString(keyStr) NSLocalizedStringFromTable(keyStr, WZZ_Localized_GETFILENAME, nil)

@interface WZZBaseTool : NSObject

/**
 是不是iphonex
 
 @return 是不是
 */
+ (BOOL)wzz_isIphoneX;

@end

