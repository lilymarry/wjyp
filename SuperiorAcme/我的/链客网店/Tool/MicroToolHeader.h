//
//  MicroToolHeader.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#ifndef MicroToolHeader_h
#define MicroToolHeader_h

#define SUCCESS_STATE(X) ([X integerValue] == 200)



//颜色宏定义
#define UIColorHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#define kLineColor [[UIColor blackColor] colorWithAlphaComponent:.2]

/*******************************   本地存储   *********************************/
//获取到本地的plist文件的单例类
#define USERDEFAULT  [NSUserDefaults standardUserDefaults]
//存储数据到本地的plist文件中
#define USERDEFAULTS(value,key)  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];\
[defaults setObject:value forKey:key];\
[defaults synchronize];

#define Font(x) [UIFont systemFontOfSize:(x)]

// block 中使用
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

/*判断是否为空*/
#define NOTNULL(x) ((![x isKindOfClass:[NSNull class]])&&x)
#define SWNOTEmptyArr(X) (NOTNULL(X)&&[X isKindOfClass:[NSArray class]]&&[X count])
#define SWNOTEmptyDictionary(X) (NOTNULL(X)&&[X isKindOfClass:[NSDictionary class]]&&[[X allKeys]count])
#define SWNOTEmptyStr(X) (NOTNULL(X)&&[X isKindOfClass:[NSString class]]&&((NSString *)X).length)
#define SWToStr(X) [APPMangerTool replaceStr:X blankStr:@""]


#endif /* MicroToolHeader_h */
