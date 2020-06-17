//
//  SASegementControlView.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/16.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "DZMSegmentedControl.h"
#import "MicroToolHeader.h"

@class SASegementOverView;


@interface SASegementControlView : UIView

/**
 是否显示箭头
 默认显示
 */
@property (nonatomic, assign) BOOL isShowArrow;

@property (nonatomic, strong) DZMSegmentedControl *segmentedControl;

/**
 全部分类展开层
 */
@property (nonatomic,strong)SASegementOverView *overView;

/**
 创建一个可以滚动点击的Bar
 
 @param datas  数据源
 
 @return 实例
 */
-(instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas;
//初始化其他部分视图
-(void)otherViewSettingWithSuperView:(UIView *)superView;

/**
 获取该控件高度
 */
+(CGFloat)barViewHeight;

@end

#pragma mark - 遮盖层

typedef void(^didSelectItemBlock)(NSInteger index);

@interface SASegementOverView : UIView

/**
 展示控件
 */
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) didSelectItemBlock selectItemBlock;

-(instancetype)initWithFrame:(CGRect)rect datas:(NSArray *)datas;

@end
