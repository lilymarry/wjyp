//
//  ManagerMutualGoods.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ManagerMutualGoods.h"
#import "ManagerMutualGoodsModel.h"
#import "ManagerMutualGoodsCell.h"
#import "ManagerMutualGoodsDetail.h"
@interface ManagerMutualGoods ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arr;
}

@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation ManagerMutualGoods

- (void)viewDidLoad {
    [super viewDidLoad];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"ManagerMutualGoodsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ManagerMutualGoodsCell"];
        self.title=@"寄售管理";
    
    
    ManagerMutualGoodsModel * center = [[ManagerMutualGoodsModel alloc] init];
    center.type = @"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [center  ManagerMutualGoodsModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
                ManagerMutualGoodsModel * center = (ManagerMutualGoodsModel *)data;
                arr=[NSArray arrayWithArray:center.data];
        
            [_mTable reloadData];
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return arr.count;
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
ManagerMutualGoodsModel * center =arr[indexPath .row];
   ManagerMutualGoodsCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"ManagerMutualGoodsCell" forIndexPath:indexPath];
    cell.merchant_nameLab.text=center.merchant_name;
    cell.order_snLab.text=[NSString stringWithFormat:@"订单号：%@",center.order_sn];
    cell.goods_nameLab.text=center.goods_name;
    cell.goods_attrLab.text=center.goods_attr;
    cell.goods_numLab.text=[NSString stringWithFormat:@"x%@",center.goods_num];
    cell.shop_priceLab.text=[NSString stringWithFormat:@"¥%@",center.shop_price];
    cell.max_numLab.text=[NSString stringWithFormat:@"已寄售件数:%@",center.param.max_num];
    cell.already_numLab.text=[NSString stringWithFormat:@"可寄售件数:%@",center.param.already_num];
    cell.surplus_numLab.text=[NSString stringWithFormat:@"剩余件数:%@",center.param.surplus_num];
    cell.cai_numnLab.text=[NSString stringWithFormat:@"已完成件数:%@",center.param.cai_num];
    cell.indexLab.text=[NSString stringWithFormat:@"指数:%@",center.param.index];
    cell.order_priceLab.text=[NSString stringWithFormat:@"共%@件商品 合计¥%@",center.goods_num,center.order_price];
     [ cell.goods_imagView sd_setImageWithURL:[NSURL URLWithString:center.abs_url] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    return cell;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ManagerMutualGoodsDetail  *detail=[[ManagerMutualGoodsDetail alloc]init];
    ManagerMutualGoodsModel * center =arr[indexPath .row];
    detail.order_id=center.order_id;
    [self.navigationController pushViewController:detail animated:YES];
   
}



@end
