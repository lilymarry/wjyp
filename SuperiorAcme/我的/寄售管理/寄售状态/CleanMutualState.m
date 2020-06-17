//
//  CleanMutualState.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "CleanMutualState.h"
#import "SItemView.h"
#import "CleanMutualStateCell.h"
#import "CleanMutualStateModel.h"
#import "InCleanMutualStateCell.h"
#import "PopButton.h"
#import "CleanMutualStatePopView.h"
#import "RefuseMoney.h"
@interface CleanMutualState ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *dataArr;
    NSString *order_status;
}
@property (weak, nonatomic) IBOutlet SItemView *orderStatusItemView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *orderStatusItemViewHH;

@property (weak, nonatomic) IBOutlet UITableView *orderManagementTable;

@property (nonatomic,strong) CleanMutualStatePopView *operationView;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@end

@implementation CleanMutualState

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _orderManagementTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([CleanMutualStateCell class]) bundle:nil] forCellReuseIdentifier:@"CleanMutualStateCell"];
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([InCleanMutualStateCell class]) bundle:nil] forCellReuseIdentifier:@"InCleanMutualStateCell"];
    
    if ([_clean_order_status intValue]==1) {
        _orderStatusItemViewHH.constant=0;
        _orderStatusItemView.hidden=YES;
    }
    else
    {
        _orderStatusItemViewHH.constant=50;
        _orderStatusItemView.hidden=NO;
        order_status=@"1";
    }
    
      [self getData];
    
    if ([_clean_order_status intValue]==1) {
        self.title=@"寄售中";
    }
    else if ([_clean_order_status intValue]==2) {
        self.title=@"已交易";
    }
    else if ([_clean_order_status intValue]==3) {
        self.title=@"已提货";
    }
    else  {
        self.title=@"已退款";
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([_clean_order_status intValue]==2) {
        self.orderStatusItemView.itemsArray = @[@"待发货",@"待收货",@"已退款",@"已完成"];
        self.orderStatusItemView.SelectItemBlock = ^(NSInteger index) {
            NSString * itemStr = @[@"待发货",@"待收货",@"已退款",@"已完成"][index];
            
            if ([itemStr containsString:@"待发货"]){
                order_status=@"1";
            }
            else if ([itemStr containsString:@"待收货"]){
                order_status=@"2";
            }
            else if ([itemStr containsString:@"已退款"]){
                order_status=@"3";
            }
            else
            {
                order_status=@"4";
            }
            [self getData];
        };
    }
    else if ([_clean_order_status intValue]==3) {
        self.orderStatusItemView.itemsArray = @[@"待发货",@"待收货",@"已完成"];
        self.orderStatusItemView.SelectItemBlock = ^(NSInteger index) {
            NSString * itemStr = @[@"待发货",@"待收货",@"已完成"][index];
            
            if ([itemStr containsString:@"待发货"]){
                order_status=@"1";
            }
            else if ([itemStr containsString:@"待收货"]){
                order_status=@"2";
            }
            
            else
            {
                order_status=@"3";
            }
            [self getData];
        };
    }
    else  if ([_clean_order_status intValue]==4)
    {
        self.orderStatusItemView.itemsArray = @[@"退款中",@"已完成"];
        self.orderStatusItemView.SelectItemBlock = ^(NSInteger index) {
            NSString * itemStr = @[@"退款中",@"已完成"][index];
            
            if ([itemStr containsString:@"退款中"]){
                order_status=@"1";
            }
            
            else
            {
                order_status=@"2";
            }
            [self getData];
        };
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (self.operationView.shouldShowed) {
        [self.operationView dismiss];
        return;
    }
}
-(void)getData
{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    CleanMutualStateModel *model=[[CleanMutualStateModel alloc] init];
    model.clean_order_status = _clean_order_status;
    model.order_status =order_status ;
    [model CleanMutualStateModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==1) {
            CleanMutualStateModel *model= (CleanMutualStateModel *)data;
            dataArr=[NSArray arrayWithArray:model.data];
        }
        else
        {
            [MBProgressHUD showSuccess:message toView:self.view];
            
        }
        
        [_orderManagementTable reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
    
    
    
}

#pragma mark - =========================== UITableViewDataSource =============================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return dataArr.count;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CleanMutualStateModel *center=dataArr[indexPath.row];
    if ([_clean_order_status intValue]!=1) {
        
        
        CleanMutualStateCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CleanMutualStateCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.merchant_nameLab.text=center.merchant_name;
        cell.pay_timeLab.text=center.pay_time;
        [cell.goods_imagView sd_setImageWithURL:[NSURL URLWithString:center.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        
        cell.goods_nameLab.text=center.goods_name;
        cell.goods_attrLab.text=center.goods_attr;
        
        cell.goods_numLab.text=[NSString stringWithFormat:@"x%@",center.goods_num];
        NSString *str ;
        if ([_clean_order_status intValue]==2) {
            str=@"利润";
        }
        else if ([_clean_order_status intValue]==3) {
            str=@"补差价";
        }
        else
        {
            str=@"售价";
        }
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"寄售额:¥%@ %@:¥%@",center.wholesale_price,str,center.profit]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,center.wholesale_price.length+1)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(center.wholesale_price.length+str.length+7,center.profit.length+1)];
        
        cell.profitLab.attributedText = AttributedStr;
        
        cell.order_priceLab.text=[NSString stringWithFormat:@"共%@件商品 合计¥%@",center.goods_num,center.order_price];
        
        return cell;
    }
    
    else {
        InCleanMutualStateCell *cell=[tableView dequeueReusableCellWithIdentifier:@"InCleanMutualStateCell"];
   
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         [cell.goods_imagView sd_setImageWithURL:[NSURL URLWithString:center.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
         cell.goods_nameLab.text=center.goods_name;
         
         cell.pay_timeLab.text=[NSString stringWithFormat:@"活动开始时间:%@-%@",center.start_time,center.end_time];
         
         NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"寄售额:¥%@ 利润:¥%@",center.wholesale_price,center.profit]];
         [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,center.wholesale_price.length+1)];
         [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(center.wholesale_price.length+9,center.profit.length+1)];
         
         cell.profitLab.attributedText = AttributedStr;
    
        cell.operationBtn.appendIndexPath = indexPath;
        
        [cell.operationBtn  addTarget:self action:@selector(operationBtnPress:) forControlEvents:UIControlEventTouchUpInside];
     
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{  if ([_clean_order_status intValue]!=1) {
    return 151;
}
else
{
    return 113;
}
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.operationView.shouldShowed) {
        [self.operationView dismiss];
        return;
    }
}
- (void)operationBtnPress:(PopButton *)sender{
    
    CGRect rectInTableView = [_orderManagementTable rectForRowAtIndexPath:sender.appendIndexPath];
    CGFloat origin_Y = rectInTableView.origin.y + sender.frame.origin.y;
    CGRect targetRect = CGRectMake(CGRectGetMinX(sender.frame), origin_Y, CGRectGetWidth(sender.bounds), CGRectGetHeight(sender.bounds));
    if (self.operationView.shouldShowed) {
        [self.operationView dismiss];
        return;
    }
    _selectedIndexPath = sender.appendIndexPath;
    
    [self.operationView showAtView:self.orderManagementTable rect:targetRect ];
    
    
}
- (CleanMutualStatePopView *)operationView {
    if (!_operationView) {
        _operationView = [CleanMutualStatePopView initailzerWFOperationView];
        [_operationView.oneBtn  addTarget:self action:@selector(oneBtnPress) forControlEvents:UIControlEventTouchUpInside];
        [_operationView.twoBtn  addTarget:self action:@selector(twoBtnPress) forControlEvents:UIControlEventTouchUpInside];
        [_operationView.threeBtn  addTarget:self action:@selector(threeBtnPress) forControlEvents:UIControlEventTouchUpInside];
        [_operationView.fourBtn  addTarget:self action:@selector(fourBtnPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _operationView;
}
#pragma mark 详情
-(void)oneBtnPress
{
    NSLog(@"sdsad %ld",(long)_selectedIndexPath.row);
}
#pragma mark 提货
-(void)twoBtnPress
{
    
}
#pragma mark 退款
-(void)threeBtnPress
{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要申请退款吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     CleanMutualStateModel *center=dataArr[_selectedIndexPath.row];
        
        RefuseMoney *refu=[[RefuseMoney alloc]init];
        refu.order_id=center.clean_id;
        refu.goods_num=center.goods_num;
        [self.navigationController pushViewController:refu animated:YES];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark 分享
-(void)fourBtnPress
{
    
}

@end
