//
//  DZMSegmentedControl.h
//  AnimationTest
//
//  Created by fxg on 2018/7/5.
//  Copyright © 2018年 fxg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZMSegmentedControl;
@class DZMSegmentedControlItem;

#pragma mark - 设置代理

@protocol DZMSegmentedControlDelegate <NSObject>

@optional

-(void)segmentControl:(DZMSegmentedControl *)segmentedControl
           clickIndex:(NSInteger)index;

@end


#pragma mark - 主体
@interface DZMSegmentedControl : UIView


/**
 代理
 */
@property (nonatomic, weak) id<DZMSegmentedControlDelegate> delegate;

/**
 默认Item字体属性
 */
@property (nonatomic, strong) NSDictionary *itemAttributes;

/**
 选中Item字体属性
 */
@property (nonatomic, strong) NSDictionary *itemSelectAttributes;

/**
 每个Item四周间距
 */
@property (nonatomic, assign) UIEdgeInsets itemInset;

/**
 内部四周间距
 */
@property (nonatomic, assign) UIEdgeInsets contentInset;

/**
 滚动条高度
 */
@property (nonatomic, assign) CGFloat sliderHeight;

/**
 滚动条
 */
@property (nonatomic, strong) UIView *sliderView;

/**
 数据源
 */
@property (nonatomic, strong) NSArray *titles;

/**
 滚动控件
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 layout
 */
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

/**
 记录选中的IndexPath
 */
@property (nonatomic, assign) NSIndexPath *selectIndexPath;

/**
 记录选中的Item
 */
@property (nonatomic, weak) DZMSegmentedControlItem *selectItem;

/**
 所有的Item大小
 */
@property (nonatomic, strong) NSMutableArray *itemSizes;

/**
 所有的Item文字大小
 */
@property (nonatomic, strong) NSMutableArray *itemTitleSizes;

/**
 所有的Item使用的滚动条大小
 */
@property (nonatomic, strong) NSMutableArray *itemSliderRects;

/**
相关联滚动控件
 */
@property (nonatomic, strong) UIScrollView *registerScrollView;

/**
 是点击滚动
 */
@property (nonatomic, assign) BOOL isClickSelect;


- (void)reload:(NSArray *)titles
   selectIndex:(NSInteger)selectIndex
      animated:(BOOL)animated;


@end


#pragma mark - DZMSegmentedControlItem

@interface DZMSegmentedControlItem:UICollectionViewCell

@property (nonatomic, copy) NSAttributedString *itemAttributedText;

@property (nonatomic, copy) NSAttributedString *itemSelectAttributedText;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic,assign) UIEdgeInsets itemInset;



@end


