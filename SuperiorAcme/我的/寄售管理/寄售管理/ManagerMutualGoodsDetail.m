//
//  ManagerMutualGoodsDetail.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ManagerMutualGoodsDetail.h"
#import "ManagerMutualGoodsDetailModel.h"
#import "ManagerMutualGoodsDetailListCell.h"
#import "ManagerMutualGoodsDetailTopCell.h"
#import "SGoodsInfor_first.h"
@interface ManagerMutualGoodsDetail ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arr;
    ManagerMutualGoodsDetailModel*  order_info;
    
}

@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation ManagerMutualGoodsDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"寄售商品";
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"ManagerMutualGoodsDetailListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ManagerMutualGoodsDetailListCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"ManagerMutualGoodsDetailTopCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ManagerMutualGoodsDetailTopCell"];
    
    
    self.title=@"寄售管理";
    
    
    ManagerMutualGoodsDetailModel * center = [[ManagerMutualGoodsDetailModel alloc] init];
    center.type = @"2";
    center.order_id=_order_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [center  ManagerMutualGoodsDetailModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        ManagerMutualGoodsDetailModel * center = (ManagerMutualGoodsDetailModel *)data;
        arr=[NSArray arrayWithArray:center.data.goods_list];
        order_info=center.data.order_info;
        [_mTable reloadData];
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 1;
    }
    return arr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        ManagerMutualGoodsDetailModel * center =   order_info;
        
        ManagerMutualGoodsDetailTopCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"ManagerMutualGoodsDetailTopCell" forIndexPath:indexPath];
        cell.merchant_nameLab.text=center.merchant_name;
      
        cell.goods_nameLab.text=center.goods_name;
     
        cell.max_numLab.text=[NSString stringWithFormat:@"%@",center.param.max_num];
        cell.already_numLab.text=[NSString stringWithFormat:@"%@",center.param.already_num];
        cell.surplus_numLab.text=[NSString stringWithFormat:@"%@",center.param.surplus_num];
        cell.cai_numnLab.text=[NSString stringWithFormat:@"%@",center.param.cai_num];
    
        return cell;
    }
    else
    {
        ManagerMutualGoodsDetailModel * center =   arr[indexPath.row];
        
        ManagerMutualGoodsDetailListCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"ManagerMutualGoodsDetailListCell" forIndexPath:indexPath];
        [cell.goods_imagView sd_setImageWithURL:[NSURL URLWithString:center.abs_url] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
         cell.goods_nameLab.text=center.goods_name;
        
        cell.discountLab.text=[NSString stringWithFormat:@"最多可使用%@%%红券",center.discount];
        
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"寄售额:¥%@ 利润:¥%@",center.wholesale_price,center.profit]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,center.wholesale_price.length+1)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(center.wholesale_price.length+9,center.profit.length+1)];
        
        cell.profitLab.attributedText = AttributedStr;
        
        cell.consign_sale_numLab.text=[NSString stringWithFormat:@"可寄售件数:%@",center.param.consign_sale_num];
        
        cell.deal_numLab.text=[NSString stringWithFormat:@"已寄售件数:%@",center.param.deal_num];
        cell.indexLab.text=[NSString stringWithFormat:@"指数:%@",center.param.index];
        
        cell.same_sale_numLab.text=[NSString stringWithFormat:@"可在线寄售数量:%@",center.param.same_sale_num];
        cell.already_numLab.text=[NSString stringWithFormat:@"已在线寄售数量:%@",center.param.already_num];
        cell.jishouBtn.tag=indexPath.row;
        [cell.jishouBtn addTarget:self action:@selector(jishouBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
  
    
    
}
-(void)jishouBtnPress:(UIButton *)sender
{
     ManagerMutualGoodsDetailModel * center =   arr[sender.tag];
    
    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
    info.goods_id = order_info.goods_id;
    info.order_id =order_info.order_id;
    info.product_id=order_info.product_id;
    info.overType = NULL;
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
    
}

@end
