//
//  SOrderManagementController.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderManagementController.h"
#import "SItemView.h"
#import "SOrderManagementCell.h"
#import "SOderMangerModel.h"
#import "SOrderManagementCell_sub1.h"
#import "SOrderManagementCell_sub2.h"
#import "SOrderManagementCell_sub3.h"
#import "SOrder_logistics.h"
@interface SOrderManagementController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArr;
    NSString *state;
}
@property (weak, nonatomic) IBOutlet UIView *NoOrderTipView;
@property (weak, nonatomic) IBOutlet SItemView *orderStatusItemView;
@property (weak, nonatomic) IBOutlet UITableView *orderManagementTable;

@property (assign,nonatomic) NSInteger page;
@end

static NSString * OrderManagementCellID = @"OrderManagementCellID";

@implementation SOrderManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单管理";
    
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    self.NoOrderTipView.hidden = NO;
    dataArr=[NSMutableArray array];
 //   [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([SOrderManagementCell class]) bundle:nil] forCellReuseIdentifier:OrderManagementCellID];
    
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([SOrderManagementCell_sub1 class]) bundle:nil] forCellReuseIdentifier:@"SOrderManagementCell_sub1"];
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([SOrderManagementCell_sub2 class]) bundle:nil] forCellReuseIdentifier:@"SOrderManagementCell_sub2"];
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([SOrderManagementCell_sub3 class]) bundle:nil] forCellReuseIdentifier:@"SOrderManagementCell_sub3"];
    
      self.page=1;
      state=@"";
      [ self refreshAndLoadMoreMethod];
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    self.orderStatusItemView.itemsArray = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价",@"已完成"];
    self.orderStatusItemView.SelectItemBlock = ^(NSInteger index) {
        NSString * itemStr = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价",@"已完成"][index];
            self.page=1;
        if ([itemStr containsString:@"全部"]) {
              state=@"";

        }else if ([itemStr containsString:@"待付款"]){
             state=@"0";
 
        }
        else if ([itemStr containsString:@"待发货"]){
            state=@"1";
        }
        else if ([itemStr containsString:@"待收货"]){
          state=@"2";
        }
        else if ([itemStr containsString:@"待评价"]){
            state=@"3";
        }
        else
        {
            state=@"4";
        }
          [_orderManagementTable.mj_header beginRefreshing];
    };
}

-(void)getData
{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    SOderMangerModel *model=[[SOderMangerModel alloc] init];
    model.shop_id = _shopId;
    model.type = @"2";
    model.status=state;
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];
    [model getShopGoodsListMethod:^(id result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      
      //  NSString *str=[NSString stringWithFormat:@"%@",result[@"code"]];
        if ([result[@"code"]  intValue]==200) {
            if (self.page==1) {
                if (SWNOTEmptyArr(dataArr)) {
                     [dataArr removeAllObjects];
                }   
               
            }
                NSArray *data = result[@"data"];
            if (SWNOTEmptyArr(data)) {
                for (int i = 0; i<data.count; i++)
                {
                    SOderMangerModel *model=[[SOderMangerModel alloc]init];
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
            _orderManagementTable.hidden=YES;
        }
        else
        {
            _NoOrderTipView.hidden=YES;
            _orderManagementTable.hidden=NO;
        }
         [_orderManagementTable reloadData];
        [_orderManagementTable.mj_footer endRefreshing];
        [_orderManagementTable.mj_header endRefreshing];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
        [_orderManagementTable.mj_footer endRefreshing];
        [_orderManagementTable.mj_header endRefreshing];
    }];
    
    
}
#pragma mark ========== numberOfSectionsInTableView ==========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return dataArr.count;
  //  return 3;
}
#pragma mark - =========================== UITableViewDataSource =============================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (dataArr.count>0) {
        SOderMangerModel *model=dataArr[section];
        NSArray *arr=model.order_goods;
        return arr.count+2;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SOderMangerModel *model=dataArr[indexPath.section];
  
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
        
        if ([model.ticket_color intValue]==0 ) {
            cell.lab_yongjuan.text=@"";
          
        }
        else if ([model.ticket_color intValue]==1)
        {
            cell.lab_yongjuan.text=@"红券";
          
        }
        else if ([model.ticket_color intValue]==2)
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
         if ([model.ticket_color intValue]==0  ) {
             cell.lab_yongjuanTittle.hidden=YES;
             cell.lab_yongjuanbi.hidden=YES;
         }
        else
        {
            cell.lab_yongjuanTittle.hidden=NO;
            cell.lab_yongjuanbi.hidden=NO;
        }

//        if (model.profit_num.length==0) {
//            cell.lab_shouyi.text=@"0积分";
//        }else
//        {
//            cell.lab_shouyi.text=[NSString stringWithFormat:@"%@积分",model.profit_num];
//        }
        cell.lab_time.text=model.order_time;
         cell.viewHHH.constant=0;
        cell.btnView.hidden=YES;
        if ([model.is_open isEqualToString:@"1"]) {
            cell.imaView_flag.hidden=NO;
        }
        else
        {
            cell.imaView_flag.hidden=YES;
        }
        if ([model.is_special intValue] ==1) {
            cell.wuliuBtn.hidden=NO;
        }
        else
        {
            cell.wuliuBtn.hidden=YES;
        }
        //按钮点击回调
        __weak typeof(self) WeakSelf = self;
        cell.wuliuBlock  = ^{
            __strong typeof(WeakSelf) StrongSelf = WeakSelf;
           [StrongSelf freightBtnClick:model.order_id];
        };
        return cell;
       
    }
    else
    {
        
        SOrderManagementCell_sub2 *cell=[tableView dequeueReusableCellWithIdentifier:@"SOrderManagementCell_sub2"];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.imaview_icon sd_setImageWithURL:[NSURL URLWithString:arr[indexPath.row-1][@"pic"]]
                             placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        cell.lab_goods_name.text=arr[indexPath.row-1][@"goods_name"];
        cell.lab_goods_price.text=[NSString stringWithFormat:@"¥%@",arr[indexPath.row-1][@"shop_price"]];
        cell.lab_goods_number.text=[NSString stringWithFormat:@"x%@",arr[indexPath.row-1][@"goods_num"]];
        if ([arr[indexPath.row-1][@"is_special"] intValue] ==1) {
            cell.viewFlag.hidden=NO;
        }
        else
        {
             cell.viewFlag.hidden=YES;
        }
        return cell;
     
    }
  
   

    return nil;
   
    
   
}
#pragma mark ========== heightForHeaderInSection ==========
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SOderMangerModel *model=dataArr[indexPath.section];

    NSArray *arr=model.order_goods;
    if (indexPath.row==0) {

        return 48;
    }
    else if(indexPath.row==arr.count+1)
    {

        return 110;

    }
    else
    {


        return 94;

    }




}
- (void)selectItem:(UISegmentedControl *)sender {
    
}
-(void)freightBtnClick:(NSString *)order_id

{
    //测试大礼包：多物流
    SOrder_logistics * logistics = [[SOrder_logistics alloc] init];
    logistics.order_id = order_id;

    [self.navigationController pushViewController:logistics animated:YES];
}
@end
