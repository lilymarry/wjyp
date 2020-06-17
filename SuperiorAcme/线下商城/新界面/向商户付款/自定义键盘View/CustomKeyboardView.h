//
//  CustomKeyboardView.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
//点击数字回调
typedef void(^ClickNumBlcok)(NSString *);
//撤销回调
typedef void(^RevocationBlcok)();
//确认付款回调
typedef void(^PayMoneyBlcok)();

@interface CustomKeyboardView : UIView

/**
 输入数字回调
 */
@property (nonatomic, copy) ClickNumBlcok ClickNumCallBackBlcok;

/**
 撤销回调
 */
@property (nonatomic, copy) RevocationBlcok RevocationCallBackBlock;

/**
 确认付款回调
 */
@property (nonatomic, copy) PayMoneyBlcok PayMoneyCallBackBlock;
@end
