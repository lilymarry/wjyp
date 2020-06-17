//
//  STicketFight.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.

//  进口馆导航item


#import <UIKit/UIKit.h>

@interface STicketFight : UIViewController
@property (nonatomic, copy) NSString * type;//1:票券区 2:拼团购 3:无界商店 4:无界预购 5:进口馆-国家馆 10：爆款专区  11互清库存

@property (nonatomic, copy) NSString * country_id;//5国家馆需要
@property (nonatomic, copy) NSString * country_name;
@end
