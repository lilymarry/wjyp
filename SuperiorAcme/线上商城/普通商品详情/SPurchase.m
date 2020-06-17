//
//  SPurchase.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPurchase.h"
#import "SPurchaseCell.h"
#import "SSPurchase_header.h"
#import "SSPurchase_footer.h"
#import "SGoodsGroupGoodsList.h"
#import "SOrderConfirm.h"

@interface SPurchase () <UITableViewDataSource,UITableViewDelegate>
{
    SSPurchase_header * header;
    NSArray * arr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SPurchase

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
//    adjustsScrollViewInsets_NO(_mTable, self);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SPurchaseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SPurchaseCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    SGoodsGroupGoodsList * list = [[SGoodsGroupGoodsList alloc] init];
    list.goods_id = _goods_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sGoodsGroupGoodsListSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SGoodsGroupGoodsList * list = (SGoodsGroupGoodsList *)data;
        arr = list.data;
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
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
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, 13, 10, 0);
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake( 0,-15,-23, 0);
    
    [rightBtn setImage:[UIImage imageNamed:@"详情分享"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    
    self.title = @"搭配购商品";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBtnClick {
  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SGoodsGroupGoodsList * list = arr[section];
    if (list.open_isno == YES) {
        return 0;
    }
    return list.goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SGoodsGroupGoodsList * list = arr[section];
    if (list.open_isno == YES) {
        return 200;
    }
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    header = [[SSPurchase_header alloc] init];
    
    SGoodsGroupGoodsList * list = arr[section];
    header.group_name.text = [NSString stringWithFormat:@"搭配组合：%@", list.group_name];
    if ([list.ticket_buy_discount integerValue] == 0) {
        header.ticket_buy_discount.backgroundColor = WordColor_sub_sub;
        header.ticket_buy_discount.text = @"不可使用代金券";
    } else {
        header.ticket_buy_discount.backgroundColor = [UIColor orangeColor];
        header.ticket_buy_discount.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
    }
    header.group_price.text = [NSString stringWithFormat:@"搭配价：￥%@",list.group_price];
    header.integral.text = list.integral;
    header.delPrice.text = [NSString stringWithFormat:@"立省￥%.2f",[list.goods_price floatValue] - [list.group_price floatValue]];
    [header showModel:list.goods];
    
    if (list.open_isno == NO) {
        header.frame = CGRectMake(0, 0, ScreenW, 100);
        header.showCollect.hidden = YES;
        [header.openBtn setImage:[UIImage imageNamed:@"搭配购上"] forState:UIControlStateNormal];
    } else {
        header.frame = CGRectMake(0, 0, ScreenW, 200);
        header.showCollect.hidden = NO;
        [header.openBtn setImage:[UIImage imageNamed:@"搭配购下"] forState:UIControlStateNormal];
    }
    [header.openBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [header.openBtn setTag:section];

    return header;
}
- (void)openBtnClick:(UIButton *)btn {
    SGoodsGroupGoodsList * list = arr[btn.tag];
    if (list.open_isno == NO) {
        list.open_isno = YES;
    } else {
        list.open_isno = NO;
    }
    [_mTable reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SSPurchase_footer * footer = [[SSPurchase_footer alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    [footer.submitBtn setTag:section];
    [footer.submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return footer;
}
- (void)submitBtnClick:(UIButton *)btn {
    SGoodsGroupGoodsList * list = arr[btn.tag];

    SOrderConfirm * con = [[SOrderConfirm alloc] init];
    con.merchant_id = list.merchant_id;
    
    NSMutableArray * josn_arr = [[NSMutableArray alloc] init];
    for (SGoodsGroupGoodsList * list_sub in list.goods) {
        NSMutableDictionary * josn_dic = [[NSMutableDictionary alloc] init];
        [josn_dic setValue:list_sub.goods_id forKey:@"goods_id"];
        if (list_sub.product_id != nil) {
            [josn_dic setValue:list_sub.product_id forKey:@"product_id"];
        }
        [josn_arr addObject:josn_dic];
    }
    con.goods_Json = [josn_arr mj_JSONString];
    [self.navigationController pushViewController:con animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPurchaseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SPurchaseCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SGoodsGroupGoodsList * list = arr[indexPath.section];
    SGoodsGroupGoodsList * list_sub = list.goods[indexPath.row];
    [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list_sub.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.goods_name.text = list_sub.goods_name;
    cell.shop_price.text = [NSString stringWithFormat:@"原价:￥%@",list_sub.shop_price];
    
    return cell;
}
@end
