//
//  AcceptCompanyVC.m
//  TaoMiShop
//
//  Created by zhaobaofeng on 16/8/9.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import "AcceptCompanyVC.h"
#import "SAfterSaleShipping.h"//物流列表
#import "SRecommendingBusinessType.h"
#import "SInvoiceInvoice.h"
#import "SInvoiceType.h"

@interface AcceptCompanyVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;//列表
    NSString * model_explain;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AcceptCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    
    [self showModel];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_tableView, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_type == nil) {
        self.title = @"承运公司";
    }
    if ([_type isEqualToString:@"2"]) {
        self.title = @"类别";
    }
    if ([_type isEqualToString:@"3"]) {
        self.title = @"发票明细";
    }
    if ([_type isEqualToString:@"4"]) {
        self.title = @"发票类型";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    if ([_type isEqualToString:@"4"] && _invoice_type_isno == NO) {
//        [MBProgressHUD showError:@"请选择发票类型" toView:self.view];
//        return;
        if (self.AcceptCompanyVC_invoice) {
            self.AcceptCompanyVC_invoice(@"", @"", @"", @"", @"", @"", @"");
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)showModel {
    if (_type == nil) {
        SAfterSaleShipping * list = [[SAfterSaleShipping alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list expressNamesFromOrderSN:_expressOrderSN success:^(NSDictionary *dic) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([dic[@"code"] isEqualToString:@"1"]) {
                arr = dic[@"data"];
                [_tableView reloadData];
            } else {
                [MBProgressHUD showError:dic[@"message"] toView:self.view];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
//        [list sAfterSaleShippingSuccess:^(NSString *code, NSString *message, id data) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            SAfterSaleShipping * list = (SAfterSaleShipping *)data;
//            arr = list.data;
//            [_tableView reloadData];
//        } andFailure:^(NSError *error) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
//        }];
    }
    if ([_type isEqualToString:@"2"]) {
        SRecommendingBusinessType * list = [[SRecommendingBusinessType alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sRecommendingBusinessTypeSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SRecommendingBusinessType * list = (SRecommendingBusinessType *)data;
            arr = list.data;
            [_tableView reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"3"]) {
        SInvoiceType * list = [[SInvoiceType alloc] init];
        list.goods_id = _goods_id;
        list.invoice_type = _t_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sInvoiceTypeSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SInvoiceType * list = (SInvoiceType *)data;
            arr = list.data;
            [_tableView reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"4"]) {
        SInvoiceInvoice * list = [[SInvoiceInvoice alloc] init];
        
        NSMutableArray * split_arr = [[NSMutableArray alloc] init];
        NSMutableDictionary * dic_split = [[NSMutableDictionary alloc] init];
        [dic_split setValue:_goods_id forKey:@"goods_id"];
        [dic_split setValue:_num forKey:@"num"];
        [dic_split setValue:_product_id forKey:@"product_id"];
        [split_arr addObject:dic_split];
        
        list.goods = [split_arr mj_JSONString];
        /*
         *无界商店的商品发票价格的计算根据商品使用的积分计算
         */
        list.shop_price = self.shop_Price;
        list.special_typel = self.special_type;
        
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sInvoiceInvoiceSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SInvoiceInvoice * list = (SInvoiceInvoice *)data;
            model_explain = list.data.explain;
            arr = list.data.list;
            [_tableView reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}

#pragma mark -UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.textColor = WordColor;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
    }
    if (_type == nil) {
        cell.textLabel.text = arr[indexPath.row][@"cname"];
    }
    if ([_type isEqualToString:@"2"]) {
        SRecommendingBusinessType * list = arr[indexPath.row];
        cell.textLabel.text = list.type;
    }
    if ([_type isEqualToString:@"3"]) {
        SInvoiceType * list = arr[indexPath.row];
        cell.textLabel.text = list.list;
    }
    if ([_type isEqualToString:@"4"]) {
        SInvoiceInvoice * list = arr[indexPath.row];
        cell.textLabel.text = list.invoice_type;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_type == nil) {
        if (self.AcceptCompanyVC_delivery) {
            self.AcceptCompanyVC_delivery(arr[indexPath.row][@"invoice"],arr[indexPath.row][@"cname"]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if ([_type isEqualToString:@"2"]) {
        if (self.AcceptCompanyVC_delivery) {
            SRecommendingBusinessType * list = arr[indexPath.row];
            self.AcceptCompanyVC_delivery(list.rec_type_id,list.type);
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
    if ([_type isEqualToString:@"3"]) {
        SInvoiceType * list = arr[indexPath.row];
        if (self.AcceptCompanyVC_type) {
            self.AcceptCompanyVC_type(list.list);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    if ([_type isEqualToString:@"4"]) {
        SInvoiceInvoice * list = arr[indexPath.row];
        if (self.AcceptCompanyVC_invoice) {
            self.AcceptCompanyVC_invoice(list.invoice_id, list.invoice_type, list.express_fee, list.tax, list.tax_pay, model_explain, list.t_id);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
