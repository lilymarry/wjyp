//
//  SNPageConst.h
//  SNPageView
//
//  Created by wangsen on 16/3/30.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#ifndef SNPageConst_h
#define SNPageConst_h

typedef NS_ENUM(NSInteger, PageViewStyle) { //标记滑块
    PageViewStyleLine,//线条滑动
    PageViewStyleArcFill,//弧形填充
    PageViewStyleArcHollow,//弧形空心
    PageViewStyleSquareFill//方形填充
};
//按钮tag
#define kBtnTag(a) (10000 + a)
#define kSubViewTag(a) (20000 + a)
#define RGBColor(r, g, b)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]

#endif /* SNPageConst_h */
