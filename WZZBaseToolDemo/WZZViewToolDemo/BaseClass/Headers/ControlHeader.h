//
//  ControlHeader.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/8.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#ifndef ControlHeader_h
#define ControlHeader_h

//正式模式
#define DEF_BuildMode_release = 1

//生产模式
#define DEF_BuildMode_adhoc = 2

//测试模式
#define DEF_BuildMode_test = 3

/*
 修改编译模式，方便调试
 使用以下方法控制多种模式判断
 #if DEF_BuildMode == DEF_BuildMode_test
 
 #elif DEF_BuildMode == DEF_BuildMode_adhoc
 
 #elif DEF_BuildMode == DEF_BuildMode_release
 
 #endif
 
 修改DEF_BuildMode宏对应的值即可切换编译模式
 */
#define DEF_BuildMode DEF_BuildMode_test

#endif /* ControlHeader_h */
