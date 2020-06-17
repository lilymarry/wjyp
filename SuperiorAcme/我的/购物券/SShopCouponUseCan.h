//
//  SShopCouponUseCan.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SShopCouponUseCan : UIViewController
@property (nonatomic, copy) NSString * type;//1:购物券使用明细 2:积分明细 3:余额明细 4成长值明细 5线下充值明细 6赠送明细 7某一条赠送蓝券具体明细  8 黄劵使用明细   9 银两明细
@property (nonatomic, copy) NSString * voucher_id;// 赠送蓝色券某条具体明细的id 
@end
