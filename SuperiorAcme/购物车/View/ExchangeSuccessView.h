//
//  ExchangeSuccessView.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeSuccessView : UIView

/**
 背景图
 */
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

/**
 查看订单
 */
@property (weak, nonatomic) IBOutlet UIButton *checkOrders;

/**
 返回首页
 */
@property (weak, nonatomic) IBOutlet UIButton *backHome;

@end
