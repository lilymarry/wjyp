//
//  SMemberOrderView.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderView.h"
#import "SMemberOrderViewCell.h"
#import "SMemberOrderMemberOrderList.h"
#import "SUserBalanceUserBalanceHjs.h"
#import "SOfflineStoreOrderListModel.h"

@interface SMemberOrderView () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arr;
    NSString * type;
}
@end

@implementation SMemberOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SMemberOrderView" owner:self options:nil];
        [self addSubview:_thisView];
        
        
        [_mTable registerNib:[UINib nibWithNibName:@"SMemberOrderViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SMemberOrderViewCell"];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showMolde:(NSArray *)thisArr andType:(NSString *)thisType{
    arr = thisArr;
    type = thisType;
    [_mTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([type isEqualToString:@"会员卡"]) {
        SMemberOrderMemberOrderList * list = arr[indexPath.section];
        if ([list.order_status integerValue] == 1) {
            return 140;
        } else if ([list.order_status integerValue] == 2) {
            return 140;
        } else if ([list.order_status integerValue] == 5) {
            return 140;
        } else {
            return 90;
        }
    }
    if ([type isEqualToString:@"充值"]) {
        SUserBalanceUserBalanceHjs * list = arr[indexPath.section];
        if ([list.status integerValue] == 0) {
            return 140;
        } else if ([list.status integerValue] == 1) {
            return 140;
        } else if ([list.status integerValue] == 5) {
            return 140;
        } else {
            return 90;
        }
    }
    
    if ([type isEqualToString:@"线下商铺"]) {
        SOfflineStoreOrderListModel * list = arr[indexPath.section];
        if ([list.status integerValue] == 0) {
            return 140;
        } else if ([list.status integerValue] == 1) {
            return 140;
        } else if ([list.status integerValue] == 5) {
            return 140;
        } else {
            return 90;
        }
    }
    
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SMemberOrderViewCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SMemberOrderViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([type isEqualToString:@"会员卡"]) {
        SMemberOrderMemberOrderList * list = arr[indexPath.section];
        cell.one.text = list.rank_name;
        cell.two.text = [NSString stringWithFormat:@"(购买时间:%@)",list.create_time];
        cell.three.text = [NSString stringWithFormat:@"订单编号:%@",list.order_sn];
        cell.four.text = list.validity;
        if ([list.order_status integerValue] == 1) {
            cell.status.text = @"未支付";
            cell.oneBtn.hidden = NO;
            cell.twoBtn.hidden = NO;
            [cell.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [cell.twoBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        } else if ([list.order_status integerValue] == 2) {
            cell.status.text = @"已支付";
            cell.oneBtn.hidden = YES;
            cell.twoBtn.hidden = NO;
            [cell.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status integerValue] == 5) {
            cell.status.text = @"已取消";
            cell.oneBtn.hidden = YES;
            cell.twoBtn.hidden = NO;
            [cell.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else {
            cell.status.text = list.order_status;
            cell.oneBtn.hidden = YES;
            cell.twoBtn.hidden = YES;
        }
    }
    if ([type isEqualToString:@"充值"]) {
        SUserBalanceUserBalanceHjs * list = arr[indexPath.section];
        cell.one.text = list.pay_type;
        cell.two.text = [NSString stringWithFormat:@"(购买时间:%@)",list.create_time];
        cell.three.text = [NSString stringWithFormat:@"订单编号:%@",list.order_sn];
        cell.four.text = [NSString stringWithFormat:@"￥%@",list.money];
        if ([list.status integerValue] == 0) {
            cell.status.text = @"未支付";
            cell.oneBtn.hidden = NO;
            cell.twoBtn.hidden = NO;
            [cell.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [cell.twoBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        } else if ([list.status integerValue] == 1) {
            cell.status.text = @"已支付";
            cell.oneBtn.hidden = YES;
            cell.twoBtn.hidden = NO;
            [cell.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.status integerValue] == 5) {
            cell.status.text = @"已取消";
            cell.oneBtn.hidden = YES;
            cell.twoBtn.hidden = NO;
            [cell.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else {
            cell.status.text = list.status;
            cell.oneBtn.hidden = YES;
            cell.twoBtn.hidden = YES;
        }
    }
    
    if ([type isEqualToString:@"线下商铺"]) {
        SOfflineStoreOrderListModel * list = arr[indexPath.section];
        cell.one.text = list.merchant_name;
        cell.two.text = [NSString stringWithFormat:@"(下单时间:%@)",list.create_time];
        cell.three.text = [NSString stringWithFormat:@"订单编号:%@",list.order_sn];
        NSString *moneyStr = @"";
        if ([list.pay_status isEqualToString:@"4"]) {
            moneyStr = [NSString stringWithFormat:@"%@积分",list.order_price];
        }else{
            moneyStr = [NSString stringWithFormat:@"¥%@",list.order_price];;
        }
        cell.four.text = moneyStr;
        if ([list.pay_status integerValue] == 0) {
            if ([list.status integerValue] == 0) {
                cell.status.text = @"未支付";
                cell.oneBtn.hidden = NO;
                cell.twoBtn.hidden = NO;
                [cell.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                [cell.twoBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            } else if ([list.status integerValue] == 5) {
                cell.oneBtn.hidden = YES;
                cell.twoBtn.hidden = NO;
                [cell.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            } else {
                cell.status.text = list.status;
                cell.oneBtn.hidden = YES;
                cell.twoBtn.hidden = YES;
            }
        }else if ([list.pay_status integerValue] == 1){
            cell.status.text = @"已支付";
            cell.oneBtn.hidden = YES;
            cell.twoBtn.hidden = NO;
            [cell.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            if([list.status intValue] == 0){
            cell.oneBtn.hidden = list.common_status;
            [cell.oneBtn setTitle:@"评价" forState:0];
            
            }
        }
    }
    

    [cell.oneBtn addTarget:self action:@selector(oneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.oneBtn setTag:indexPath.section];
    [cell.twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.twoBtn setTag:indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([type isEqualToString:@"会员卡"]) {
        SMemberOrderMemberOrderList * list = arr[indexPath.section];
        if (self.SMemberOrderViewInfor) {
            self.SMemberOrderViewInfor(list.id,list.order_status,list.member_coding);
        }
    }
    if ([type isEqualToString:@"充值"]) {
        SUserBalanceUserBalanceHjs * list = arr[indexPath.section];
        if (self.SMemberOrderViewInfor) {
            self.SMemberOrderViewInfor(list.id,list.status,list.money);
        }
    }
    if ([type isEqualToString:@"线下商铺"]) {
        SOfflineStoreOrderListModel * list = arr[indexPath.section];
        if (self.SOfflineStoreOrderInfor) {
    self.SOfflineStoreOrderInfor(list.order_id,list.merchant_id,list.pay_status,list.status,list.common_status);
        }
    }
}
- (void)oneBtnClick:(UIButton *)btn {
    if ([type isEqualToString:@"会员卡"]) {
        SMemberOrderMemberOrderList * list = arr[btn.tag];
        if (self.SMemberOrderViewOneBtn) {
            self.SMemberOrderViewOneBtn(list.id,list.order_status);
        }
    }
    if ([type isEqualToString:@"充值"]) {
        SUserBalanceUserBalanceHjs * list = arr[btn.tag];
        if (self.SMemberOrderViewOneBtn) {
            self.SMemberOrderViewOneBtn(list.id,list.status);
        }
    }
    if ([type isEqualToString:@"线下商铺"]) {
        SOfflineStoreOrderListModel * list = arr[btn.tag];
        if ([btn.titleLabel.text isEqualToString:@"评价"]) {
            if(self.sMemberOrderViewOneBtnCommentBlock){
                self.sMemberOrderViewOneBtnCommentBlock(list.order_id, btn);
            }
        }else{
            if (self.SMemberOrderViewOneBtn) {
                self.SMemberOrderViewOneBtn(list.order_id,list.status);
            }
        }
    }
}
- (void)twoBtnClick:(UIButton *)btn {
    if ([type isEqualToString:@"会员卡"]) {
        SMemberOrderMemberOrderList * list = arr[btn.tag];
        if (self.SMemberOrderViewTwoBtn) {
            self.SMemberOrderViewTwoBtn(list.id,list.order_status,btn,list.member_coding);
        }
    }
    if ([type isEqualToString:@"充值"]) {
        SUserBalanceUserBalanceHjs * list = arr[btn.tag];
        if (self.SMemberOrderViewTwoBtn) {
            self.SMemberOrderViewTwoBtn(list.id,list.status,btn,list.money);
        }
    }
    if ([type isEqualToString:@"线下商铺"]) {
        SOfflineStoreOrderListModel * list = arr[btn.tag];
        if (self.SMemberOrderViewTwoBtn) {
            if([btn.titleLabel.text isEqualToString:@"立即支付"]){
                self.SMemberOrderViewTwoBtn(list.order_id,list.status,btn,list.order_price);
            }else if ([btn.titleLabel.text isEqualToString:@"删除订单"]){
                self.SMemberOrderViewTwoBtn(list.order_id,list.status,btn,list.order_price);
            }
        
        }
    }
    
}
@end
