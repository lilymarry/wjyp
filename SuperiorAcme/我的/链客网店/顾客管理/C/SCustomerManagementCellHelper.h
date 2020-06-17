//
//  SCustomerManagementCellHelper.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCustomerManagementModel.h"

@interface SCustomerManagementCellHelper : NSObject

+(instancetype)heperWithModel:(SCustomerManagementModel *)customerManagement;

- (SCustomerManagementModel *)customerManagement;

-(NSString *)head_path;

-(NSString *)nickname;

-(NSString *)order_price;

-(NSString *)pay_time;

-(NSString *)set_name;

-(NSString *)member_coding_html;
-(NSString *)is_balance;
-(NSString *)profit_num;

-(BOOL)is_has_shop;

-(BOOL)is_special;

-(BOOL)is_open;

@end
