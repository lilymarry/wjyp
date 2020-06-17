//
//  SOrderSend.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SOrderSendBackBlock) (NSString * name, NSString * name_price, NSString * tem_id, NSString * type_status, NSString * shipping_id, NSString * shipping_name, NSString * same_tem_id, NSString * desc, NSString * type);

@interface SOrderSend : UIViewController

- (void)showModel_andGoods_id:(NSString *)goods_id andAddress_id:(NSString *)address_id andGoods_info:(NSString *)goods_info;
@property (nonatomic, copy) SOrderSendBackBlock SOrderSendBack;
@end
