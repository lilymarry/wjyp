//
//  ApplyYellowController.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/9/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "ApplyYellowController.h"
#import "ApplyYellowModel.h"
#import "SOrderManagementCell_sub1.h"
#import "SOrderManagementCell_sub2.h"
#import "SOrderManagementCell_sub3.h"
#import "SItemView.h"
#import "SShopCouponUseCan.h"
@interface ApplyYellowController ()
<UITableViewDelegate, UITableViewDataSource,YellowDegreeCellDelegate>
{
    NSMutableArray *dataArr;
    NSString *state;
    NSString * ticket_lines;//最大黄劵数
}
@property (assign,nonatomic) NSInteger page;
@property (weak, nonatomic) IBOutlet UIView *NoOrderTipView;
@property (weak, nonatomic) IBOutlet SItemView *orderStatusItemView;
@property (weak, nonatomic) IBOutlet UITableView *orderManagementTable;
@property (weak, nonatomic) IBOutlet UILabel *lab_num;
@end

@implementation ApplyYellowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"黄券明细" style:UIBarButtonItemStyleDone target:self action:@selector(gotoDetail)];
    [self.navigationItem  setRightBarButtonItem:item];
    
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _page = 1;
    dataArr=[NSMutableArray array];
    self.title=@"黄券审核";
    
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([SOrderManagementCell_sub1 class]) bundle:nil] forCellReuseIdentifier:@"SOrderManagementCell_sub1"];
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([SOrderManagementCell_sub2 class]) bundle:nil] forCellReuseIdentifier:@"SOrderManagementCell_sub2"];
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([SOrderManagementCell_sub3 class]) bundle:nil] forCellReuseIdentifier:@"SOrderManagementCell_sub3"];
    
    
   // [self getDataWithStatus:@"1"];
    [self refreshAndLoadMoreMethod];
}
- (void)refreshAndLoadMoreMethod{
    _orderManagementTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    [_orderManagementTable.mj_header beginRefreshing];
    
    _orderManagementTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
    }];
    
}
-(void)getData
{
    // [dataArr removeAllObjects];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    ApplyYellowModel *model=[[ApplyYellowModel alloc] init];
    model.shopid = _shopId;
    model.type = @"4";
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];
    [model ApplyYellowListMethod:^(id result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
           //NSLog(@"SSSS%@",result);
        NSString *str=[NSString stringWithFormat:@"%@",result[@"code"]];
          _lab_num.text=[NSString stringWithFormat:@"剩余黄券额度：%@",result[@"nums"]];
        if ([str isEqualToString:@"200"]) {
            if (_page==1) {
                [dataArr removeAllObjects];
            }
            if ([result[@"nums"] intValue]>0) {
                NSArray *data = result[@"data"];
                for (int i = 0; i<data.count; i++)
                {
                   ApplyYellowModel *model=[[ApplyYellowModel alloc]init];
                    [model setValuesForKeysWithDictionary:data[i]];
                    [dataArr addObject:model];
                    
                }
            }
        }
        else
        {
            [MBProgressHUD showError:result[@"message"] toView:self.view];
        }
       
        if (dataArr.count==0) {
            _NoOrderTipView.hidden=NO;
        }
        else
        {
            _NoOrderTipView.hidden=YES;
        }
        [_orderManagementTable reloadData];
        [_orderManagementTable.mj_footer endRefreshing];
        [_orderManagementTable.mj_header endRefreshing];
        
    } andFailure:^(NSError *error) {
        [_orderManagementTable.mj_footer endRefreshing];
        [_orderManagementTable.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ========== numberOfSectionsInTableView ==========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArr.count;
}
#pragma mark - =========================== UITableViewDataSource =============================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataArr.count>0) {
        ApplyYellowModel *model=dataArr[section];
        NSArray *arr=model.order_goods;
        return arr.count+2;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyYellowModel *model=dataArr[indexPath.section];
    
    NSArray *arr=model.order_goods;
   
    if (indexPath.row==0) {
        SOrderManagementCell_sub1 *cell=[tableView dequeueReusableCellWithIdentifier:@"SOrderManagementCell_sub1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lab_shopName.text=model.shop_name;
        if ([ model.order_status containsString:@"0"]){
            cell.lab_state.text=@"待付款";
            
        }
        else if ([model.order_status containsString:@"1"]){
            cell.lab_state.text=@"待发货";
            
        }
        else if ([model.order_status containsString:@"2"]){
            cell.lab_state.text=@"待收货";
            
        }
        else if ([model.order_status containsString:@"3"]){
            cell.lab_state.text=@"待评价";
            
        }
        else
        {
            cell.lab_state.text=@"已完成";
            
        }
        [cell.topViewLeftBtn setTitle:model.shop_type forState:UIControlStateNormal];
        if ([model.shop_type isEqualToString:@"本店"]) {
            [cell.topViewLeftBtn setImage:[UIImage imageNamed:@"本店"] forState:UIControlStateNormal];
            [cell.topViewLeftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            cell.topViewLeftBtn.layer.borderColor = [UIColor redColor].CGColor;
            
        }
        else
        {
            [cell.topViewLeftBtn setImage:[UIImage imageNamed:@"链店"] forState:UIControlStateNormal];
            [cell.topViewLeftBtn setTitleColor:[UIColor colorWithRed:250/255.0 green:127/255.0 blue:46/255.0 alpha:1] forState:UIControlStateNormal];
            cell.topViewLeftBtn.layer.borderColor = [UIColor colorWithRed:250/255.0 green:127/255.0 blue:46/255.0 alpha:1].CGColor;
        }
        return cell;
    }
    else if(indexPath.row==arr.count+1)
    {
        SOrderManagementCell_sub3 *cell=[tableView dequeueReusableCellWithIdentifier:@"SOrderManagementCell_sub3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lab_maijia.text=model.buyer;
        cell.delegate=self;
        cell.model=model;
        
        if ([model.ticket_color isEqualToString:@"0"]) {
            cell.lab_yongjuan.text=@"";
            
        }
        else if ([model.ticket_color isEqualToString:@"1"])
        {
            cell.lab_yongjuan.text=@"红券";
            
        }
        else if ([model.ticket_color isEqualToString:@"2"])
        {
            cell.lab_yongjuan.text=@"黄券";
            
        }
        else
        {
            cell.lab_yongjuan.text=@"蓝券";
            
        }
        
        cell.lab_gongyingshang.text=model.supply_name;
        cell.lab_yongjuanbi.text=model.pay_tickets;
        
        if (model.pay_tickets.length==0||[model.pay_tickets doubleValue]==0.00) {
            cell.lab_yongjuanbiTittle.hidden=YES;
        }
        else{
            cell.lab_yongjuanbiTittle.hidden=NO;
        }
        if ([model.ticket_color isEqualToString:@"0"]) {
            cell.lab_yongjuanTittle.hidden=YES;
            cell.lab_yongjuanbi.hidden=YES;
        }
        else
        {
            cell.lab_yongjuanTittle.hidden=NO;
            cell.lab_yongjuanbi.hidden=NO;
        }
//        if (model.profit_num.length==0) {
//             cell.lab_shouyi.text=@"0积分";
//        }else
//        {
//        cell.lab_shouyi.text=[NSString stringWithFormat:@"%@积分",model.profit_num];
//        }
        cell.viewHHH.constant=83;
        cell.btnView.hidden=NO;
        cell.wuliuBtn.hidden=YES;
        cell.lab_time.hidden=YES;
        cell.tf_huangJuanNum.text=model.ticket_price;
        cell.lab_ticket_line.text=[NSString stringWithFormat:@"最多可使用%.2f的黄券",[self getHuanQuanEdu:model.ticket_lines str2:model.ticket_price] ];
         cell.ticket_lines=[NSString stringWithFormat:@"%f",[self getHuanQuanEdu:model.ticket_lines str2:model.ticket_price] ];
        ticket_lines=cell.ticket_lines;
        if ([model.is_open isEqualToString:@"1"]) {
            cell.imaView_flag.hidden=NO;
        }
        else
        {
            cell.imaView_flag.hidden=YES;
        }
        return cell;
        
    }
    else
    {
        
        SOrderManagementCell_sub2 *cell=[tableView dequeueReusableCellWithIdentifier:@"SOrderManagementCell_sub2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.imaview_icon sd_setImageWithURL:[NSURL URLWithString:model.order_goods[indexPath.row-1][@"pic"]]
                             placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        cell.lab_goods_name.text=model.order_goods[indexPath.row-1][@"goods_name"];
        cell.lab_goods_price.text=[NSString stringWithFormat:@"¥%@",model.order_goods[indexPath.row-1][@"shop_price"]];
        cell.lab_goods_number.text=[NSString stringWithFormat:@"x%@",model.order_goods[indexPath.row-1][@"goods_num"]];
        return cell;
        
    }
    return nil;
}
#pragma mark ========== heightForHeaderInSection ==========
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
#pragma mark ========== 自适应cell高度 ==========
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 260;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplyYellowModel *model=dataArr[indexPath.section];
    
    NSArray *arr=model.order_goods;
    if (indexPath.row==0) {
        
        return 48;
    }
    else if(indexPath.row==arr.count+1)
    {
        
        return 154;
        
    }
    else
    {
        return 94;
        
    }
}
- (void)selectItem:(UISegmentedControl *)sender {
    
}
-(float)getHuanQuanEdu:(NSString *)str1 str2:(NSString *)str2
{
    if ([str1 doubleValue]>[str2 doubleValue]) {
        return [str2 doubleValue];
    }
    else{
          return [str1 doubleValue];
    }
    
}
-(void)degreeBtnClick:(ApplyYellowModel *)model andtxf:(NSString *)text ticket_line:(NSString *)ticket_line
{
    [self shenheYelloWithOderId:model.order_id ticket_status:@"2" andTicket_price:text ticket_line:ticket_line];
}
-(void)disgreeBtnClick:(ApplyYellowModel *)model andtxf:(NSString *)text ticket_line:(NSString *)ticket_line
{
     [self shenheYelloWithOderId:model.order_id ticket_status:@"3" andTicket_price:text ticket_line:ticket_line];
}

-(void)shenheYelloWithOderId:(NSString *)odid  ticket_status:(NSString *)ticket_status
             andTicket_price:(NSString *)ticket_price ticket_line:(NSString *)ticket_line

{
    
    if ([ticket_price doubleValue]>[ticket_line doubleValue]) {
         [MBProgressHUD showError:@"超出最大黄券数" toView:self.view];
        return;
    }
    [MBProgressHUD showMessage:@"审核中..." toView:self.view];
    ApplyYellowModel *model=[[ApplyYellowModel alloc] init];
    model.order_id = odid;
    model.ticket_status = ticket_status;
    model.ticket_price=ticket_price;
    [model ShenHeYellowMethod:^(id result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      //   NSLog(@"SSSS%@",result);
      //  NSString *str=[NSString stringWithFormat:@"%@",result[@"code"]];
        
        if ([result[@"code"]  intValue]==200) {
             [self refreshAndLoadMoreMethod];
        }
        else
        {
         [MBProgressHUD showError:result[@"message"] toView:self.view];
        }
       
       // [self getDataWithStatus:@""];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
        
    }];
    
}
-(void)gotoDetail
{
    SShopCouponUseCan *list=[[SShopCouponUseCan alloc]init];
    list.type=@"8";
    [self.navigationController pushViewController:list animated:YES];
}


@end
