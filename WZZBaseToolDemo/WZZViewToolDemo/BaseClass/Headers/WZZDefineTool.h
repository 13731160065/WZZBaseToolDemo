//
//  WZZDefineTool.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/14.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#ifndef WZZDefineTool_h
#define WZZDefineTool_h

//获取当前文件名
#define DEF_GETFILENAME [[[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent] stringByDeletingPathExtension]

//根据当前文件定位string文件
#define WZZLocalizedFileString(keyStr) NSLocalizedStringFromTable(keyStr, DEF_GETFILENAME, nil)

#endif /* WZZDefineTool_h */
