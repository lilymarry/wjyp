//
//  CategoryItemView.h
//  XibTest
//
//  Created by 科技沃天 on 2018/6/8.
//  Copyright © 2018年 科技沃天. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 显示隐藏block

 @param isShow 是否展示
 */
typedef void(^ShowCategoryItemBlock)(BOOL isShow);


/**
 分类点击的回调

 @param index 点击的分类对应的索引
 */
typedef void(^CategoryItemClickBlock)(NSInteger index);


/**
 点击隐藏分类弹出框
 */
typedef void(^TapToHiddenCategoryPopViewBlock)();

@interface CategoryItemView : UIView

/**
 分类数组
 */
@property (nonatomic, strong) NSArray * itemsArr;

/**
 显示隐藏block
 */
@property (nonatomic, copy) ShowCategoryItemBlock showCategoryItemBlock;

/**
 item的点击的回调
 */
@property (nonatomic, copy) CategoryItemClickBlock selectedItemBlock;

/**
 点击隐藏分类弹出框
 */
@property (nonatomic, copy) TapToHiddenCategoryPopViewBlock TapToHiddenCategoryBlock;

@end
