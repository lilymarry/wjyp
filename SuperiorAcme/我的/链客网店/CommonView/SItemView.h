//
//  SItemView.h
//  XibTest
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 科技沃天. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 item点击block

 @param index 点击的item的索引
 */
typedef void(^SelectItemBlock)(NSInteger index);

@interface SItemView : UIView


/**
 传入的标题数组
 */
@property (nonatomic, strong) NSArray * itemsArray;

/**
 外部滚动调用的block回调
 */
@property (nonatomic, copy) SelectItemBlock ScrollSelectItemBlock;

/**
 选中某一个item后的回调
 */
@property (nonatomic, copy) SelectItemBlock SelectItemBlock;

/**
 是否显示箭头
 */
@property (nonatomic, assign) BOOL showArrow;

/**
 恢复默认选中第一个item
 */
-(void)RecoverDefaultItem;

@end


#pragma mark - =========================== 自定义的ItemButton =============================
@interface ItemButton : UIButton

@end
