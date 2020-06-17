  //
//  HSQActionSheet.h
//  PocketConsulting
//
//  Created by nian on 16/9/6.
//  Copyright © 2016年 hanshanquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSQActionSheet;

typedef enum {
    HSQActionSheetStyleDefault, // 正常字体样式
    HSQActionSheetStyleCancel,  // 粗体字样式
    HSQActionSheetStyleDestructive // 红色字体样式
} HSQActionSheetStyle;

@protocol HSQActionSheetDelegate <NSObject>
/**
 *  代理方法
 *
 *  @param actionSheet actionSheet
 *  @param index       被点击按钮是哪个
 */
- (void)clickAction:(HSQActionSheet *)actionSheet atIndex:(NSUInteger)index;
@end

@interface HSQActionSheet : UIView

/**
 *  设置代理
 */
@property (nonatomic, weak) id<HSQActionSheetDelegate> delegate;
/**
 *  初始化方法
 *
 *  @param title    提示内容
 *  @param confirms 选项标题数组
 *  @param cancel   取消按钮标题
 *  @param style    显示样式
 *
 *  @return         actionSheet
 */
+ (HSQActionSheet *)actionSheetWithTitle:(NSString *)title confirms:(NSArray *)confirms cancel:(NSString *)cancel style:(HSQActionSheetStyle)style;
/**
 *  显示方法
 *
 *  @param obj UIView或者UIWindow类型
 */
- (void)showInView:(id)obj;

@end
