//
//  SOrderCenter_list.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderCenter_list : UIViewController
@property (nonatomic, assign) BOOL coming;//YES直接进来 NO支付进来
@property (nonatomic, copy) NSString * type;//1:线上商城 2:拼团区 3:无界预购 4:竞拍汇 5:汽车购 6:房产购 7:爱心商店  //13
//@property (nonatomic, assign) BOOL  Is_399;//普通商品、
@end
