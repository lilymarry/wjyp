//
//  CleanSOrderConfirm.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/12.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "CleanSOrderConfirm.h"
#import "CleanConfirmOrderModel.h"
#import "SOrderConfirm_goodsCell.h"
@interface CleanSOrderConfirm ()
{NSArray *arr;}
@property (strong, nonatomic) IBOutlet UILabel *sumPrice;
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation CleanSOrderConfirm

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认订单";
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SOrderConfirm_goodsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOrderConfirm_goodsCell"];
    
    
    self.title=@"寄售管理";
    
     [MBProgressHUD showMessage:nil toView:self.view];
    CleanConfirmOrderModel  *list=[[CleanConfirmOrderModel alloc]init];
    list.goods_id=_goods_id;
    list.num=_num;
    list.product_id=_product_id;
    list.order_id=_order_id;
    [list CleanConfirmOrderModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if ([code intValue]==1) {
             arr = [NSArray arrayWithArray:list.data.item];
            _sumPrice.text= [NSString stringWithFormat:@"总计:%@",list.data.sum_shop_price];
        }
        else
        {
               [MBProgressHUD showSuccess:message toView:self.view];
        }
       
        
        [_mTable reloadData];
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];

    }];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return arr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        CleanConfirmOrderModel * list =   arr[indexPath.row];
        
        SOrderConfirm_goodsCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SOrderConfirm_goodsCell" forIndexPath:indexPath];
  
    [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.thisTitle.text = list.goods_name;
    cell.shop_price.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
    cell.num.text = [NSString stringWithFormat:@"x%@",list.num];
    cell.goods_attr.text = list.goods_attr_first;
    return cell;

}

- (IBAction)surePress:(id)sender
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
