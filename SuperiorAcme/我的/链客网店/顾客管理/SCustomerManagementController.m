//
//  SCustomerManagementController.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCustomerManagementController.h"
#import "SCustomerManagementCell.h"
#import "SCustomerManagementCellHelper.h"

@interface SCustomerManagementController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *noDataTipView;

@property (nonatomic, strong) NSMutableArray *customers;

@property (nonatomic, strong) NSMutableArray *shops;

@end

static NSString * CustomerManagementCellID = @"CustomerManagementCellID";

@implementation SCustomerManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   [self CreatNavBar:@[@"店主身份", @"普通顾客"] andIsHaveRightBtn:NO andRightBtnOption:nil andDefaultHiddenForRightBtn:nil];
    [_mTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SCustomerManagementCell class]) bundle:nil] forCellReuseIdentifier:CustomerManagementCellID];
    _mTableView.contentInset = UIEdgeInsetsMake(7, 0, 0, 0);
    
    [self requestDataFromServer];
    
}

- (void)requestDataFromServer{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:_shopId forKey:@"id"];
    [para setValue:@"1" forKey:@"type"];
     [SRegisterLogin shareInstance].method = @"GET";
    [HttpManager getWithUrl:@"Distribution/orders"
              andParameters:para
                 andSuccess:^(id Json) {
                    [MBProgressHUD hideHUDForView:self.view animated:NO];
                     if (SWNOTEmptyDictionary(Json)) {
                         if (SUCCESS_STATE(Json[@"code"])) {
                             NSDictionary *data = Json[@"data"];
                             NSLog(@"SSS_ %@",data);
                             if (SWNOTEmptyDictionary(data)) {
                                 [self reloadTableViewWithDatas:data];
                             }
                         
                         }else{
                           [MBProgressHUD showSuccess:Json[@"message"] toView:self.view];
                         }
                     }
                 }
                    andFail:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:NO];
                        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
                    }];
    
}

- (void)reloadTableViewWithDatas:(id)data{
    NSArray *shop = data[@"shop"];
    NSArray *consumer = data[@"consumer"];
    for (NSDictionary *dic  in shop) {
        [self.shops addObject:[SCustomerManagementCellHelper heperWithModel:[SCustomerManagementModel mj_objectWithKeyValues:dic]]];
    }
    for (NSDictionary *dic  in consumer) {
        [self.customers addObject:[SCustomerManagementCellHelper heperWithModel:[SCustomerManagementModel mj_objectWithKeyValues:dic]]];
    }
    if (self.shops.count==0&&self.customers.count==0) {
        _noDataTipView.hidden=NO;
    }
    else
    {
        _noDataTipView.hidden=YES;
    }
    [_mTableView reloadData];
    
}

- (void)selectItem:(UISegmentedControl *)sender {
    //NSLog(@"%@",[sender titleForSegmentAtIndex:sender.selectedSegmentIndex]);
    [_mTableView reloadData];
}

#pragma mark - =========================== UITableViewDataSource =============================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_segmentControl.selectedSegmentIndex == 0) {
        return self.shops.count;
    }else{
         return self.customers.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SCustomerManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomerManagementCellID];
    SCustomerManagementCellHelper *cellHelper = nil;
    if (_segmentControl.selectedSegmentIndex == 0) {
        cellHelper = self.shops[indexPath.row];
        cell.level = cellHelper.is_has_shop ?  [NSString stringWithFormat:@"%@店主",cellHelper.set_name] : [NSString stringWithFormat:@"%@店主", cellHelper.member_coding_html];
        
    }else{
        cellHelper = self.customers[indexPath.row];
        cell.level = cellHelper.is_has_shop ?  cellHelper.set_name : cellHelper.member_coding_html;
    }
    
    cell.icon = cellHelper.head_path;
    cell.name = cellHelper.nickname;
    
    if ([cellHelper.is_balance isEqualToString:@"1"]) {
         cell.price = [NSString stringWithFormat:@"贡献%@余额",cellHelper.profit_num];
    }
    else
    {
       cell.price = [NSString stringWithFormat:@"贡献%@积分",cellHelper.profit_num];
    }
   
    
    cell.time = cellHelper.pay_time;
    
    return cell;
}
#pragma mark - =========================== UITableViewDelegate =============================
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(NSMutableArray *)customers{
    if (!_customers) {
        _customers = [NSMutableArray array];
    }
    return _customers;
}

-(NSMutableArray *)shops{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}


@end
