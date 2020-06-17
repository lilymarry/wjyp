//
//  SOrder_logistics.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrder_logistics.h"
#import "SOrder_logisticsCell.h"
#import "SOL_top.h"
#import "SOrderOrderLogistics.h"
#import "SMessageInfor.h"

@interface SOrder_logistics () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SOrder_logistics

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SOrder_logisticsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOrder_logisticsCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    SOrderOrderLogistics * log = [[SOrderOrderLogistics alloc] init];
    log.order_id = _order_id;
    log.order_type = _order_type;
    [MBProgressHUD showMessage:nil toView:self.view];
    [log sOrderOrderLogisticsSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SOrderOrderLogistics * log = (SOrderOrderLogistics *)data;
            arr = log.data;
            [_mTable reloadData];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    
    self.title = @"订单物流";
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
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SOL_top * header = [[SOL_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    SOrderOrderLogistics * log = arr[section];
    header.express_no.text = log.express_no;
    
    [header.sendBtn setTag:section];
    [header.sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    return header;
}
- (void)sendBtnClick:(UIButton *)btn {
    SOrderOrderLogistics * log = arr[btn.tag];

    SMessageInfor * infor = [[SMessageInfor alloc] init];
    infor.type = @"快递信息";
    NSString *type = @"0";
    if ([_order_type isEqualToString:@"拼单购"]) {
        type = @"1";
    }else if ([_order_type isEqualToString:@"无界商店"]){
        /*
         *增加无界商店查看物流信息详情时需要的type值
         */
        type = @"5";
    }
    infor.code_Url = [NSString stringWithFormat:@"%@%@?order_goods_id=%@&type=%@", Base_url, SOrderOrderLogistics_Info, _order_goods_id, type];
    [self.navigationController pushViewController:infor animated:YES];
}
- (NSString *)transform:(NSString *)chinese{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    
    //返回最近结果
    return pinyin;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SOrder_logisticsCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SOrder_logisticsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SOrderOrderLogistics * log = arr[indexPath.section];
    [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:log.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.goods_name.text = log.goods_name;
    cell.shop_price.text = [NSString stringWithFormat:@"￥%@",log.shop_price];
    cell.attr.text = log.attr;
    cell.goods_num.text = [NSString stringWithFormat:@"x%@",log.goods_num];
    
    if ([log.is_active isEqualToString:@"2"]) {
        cell.view_2980.hidden=NO;
        cell.lab_2980.text=@"399";
    }
    else
    {
        cell.view_2980.hidden=YES;
    }
    
    return cell;
}
@end
