//
//  SOrderInfor.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderInfor : UIViewController
@property (nonatomic, copy) NSString * order_type;//普通商品、
@property (nonatomic, copy) NSString * order_id;//订单id
@property (nonatomic, assign) BOOL  Is_2980;
@property (nonatomic, assign) BOOL  IsInShop;// 399
@property (nonatomic, assign) BOOL  IsSuiPian;//
@end
