//
//  SCustomerManagementCellHelper.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCustomerManagementCellHelper.h"

@interface SCustomerManagementCellHelper ()

@property (strong, nonatomic) SCustomerManagementModel *customerManagement;

@end

@implementation SCustomerManagementCellHelper

+(instancetype)heperWithModel:(SCustomerManagementModel *)customerManagement{
    SCustomerManagementCellHelper *helper = [SCustomerManagementCellHelper new];
    helper.customerManagement = customerManagement;
    return helper;
}

//- (SCustomerManagementModel *)customerManagement{
//    return self.customerManagement;
//}

-(NSString *)head_path{
    return self.customerManagement.head_path;
}

-(NSString *)nickname{
    return self.customerManagement.nickname;
}

-(NSString *)order_price{
    return [NSString stringWithFormat:@"+%@",self.customerManagement.order_price];
}

-(NSString *)pay_time{
    return self.customerManagement.deal_time;
}

-(NSString *)set_name{
    return self.customerManagement.set_name;
}

-(NSString *)member_coding_html{
    return self.customerManagement.member_coding_html;
}
-(NSString *)is_balance
{
    return self.customerManagement.is_balance;
}
-(BOOL)is_has_shop{
    return self.customerManagement.is_has_shop;
}

-(BOOL)is_special{
    return self.customerManagement.is_special;
}

-(BOOL)is_open{
    return self.customerManagement.is_open;
}
-(NSString *)profit_num
{
    return self.customerManagement.profit_num;
}

@end
