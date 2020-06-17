//
//  SOrderSend.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderSend.h"
#import "SOrderSendCell.h"
#import "SFreightSplit.h"

@interface SOrderSend () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray * thisArr;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UIView *groundView;
@end

@implementation SOrderSend

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 5;
    
    [_mTable registerNib:[UINib nibWithNibName:@"SOrderSendCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOrderSendCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)showModel_andGoods_id:(NSString *)goods_id andAddress_id:(NSString *)address_id andGoods_info:(NSString *)goods_info {
    SFreightSplit * split = [[SFreightSplit alloc] init];
    split.address_id = address_id;
    split.now_goods_id = goods_id;
    split.goods_info = goods_info;
    [split sFreightSplitSuccess:^(NSString *code, NSString *message, id data) {
        SFreightSplit * split = (SFreightSplit *)data;
        thisArr = split.data.tem;
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return thisArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SOrderSendCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SOrderSendCell" forIndexPath:indexPath];
    
    SFreightSplit * list = thisArr[indexPath.row];
    cell.type.text = [NSString stringWithFormat:@"%@(%@)\n%@",list.type_name,list.shipping_name,list.desc];
    if ([list.pay integerValue] == 0) {
        cell.pay.text = @"包邮";
    } else {
        cell.pay.text = [NSString stringWithFormat:@"%@元",list.pay];
    }
    
    return cell;
}
- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SFreightSplit * list = thisArr[indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.SOrderSendBack) {
            self.SOrderSendBack(list.type_name, list.pay, list.id, list.type_status, list.shipping_id, list.shipping_name, list.same_tem_id, list.desc, list.type);
        }
    }];
}
@end
