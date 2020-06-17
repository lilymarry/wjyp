//
//  CustomerServiceInfor.m
//  TaoMiShop
//
//  Created by TXD_air on 16/10/22.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import "CustomerServiceInfor.h"
#import "CsCell1.h"
#import "SAfterSaleShowAfter.h"//售后展示数据
#import "ManifestInformationVC.h"//退货地址填写
#import "SAfterSaleCancelAfter.h"//取消售后
#import "GCustomerService.h"

@interface CustomerServiceInfor () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBtn_WWW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableView_HHH;
@end

@implementation CustomerServiceInfor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:@"CsCell1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CsCell1"];
    
//    [self initRefresh];
    
    _leftBtn.layer.masksToBounds = YES;
    _leftBtn.layer.cornerRadius = 20;
    _leftBtn.layer.borderWidth = 1.0;
    _leftBtn.layer.borderColor = WordColor_sub_sub_sub.CGColor;
    
    _rightBtn.layer.masksToBounds = YES;
    _rightBtn.layer.cornerRadius = 20;
    _rightBtn.layer.borderWidth = 1.0;
    _rightBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    if ([_is_sales isEqualToString:@"1"]) {
        _leftBtn_WWW.constant = -45;
        _rightBtn.hidden = NO;
    } else {
        _leftBtn_WWW.constant = 0;
        _rightBtn.hidden = YES;
    }
    if ([_after_type isEqualToString:@"2"]) {
        //售后成功
        _tableView_HHH.constant = 0;
    }
    if ([_after_type isEqualToString:@"3"]) {
        //售后拒绝
        [_rightBtn setTitle:@"重新申请" forState:UIControlStateNormal];
        _leftBtn_WWW.constant = -45;
        _rightBtn.hidden = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_tableView, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"售后处理";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidAppear:(BOOL)animated {
    [self showModel];
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
- (void)leftButtonPressed:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)initRefresh
//{
//    __block CustomerServiceInfor * blockSelf = self;
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [blockSelf showModel];
//    }];
//}
- (void)showModel {
    SAfterSaleShowAfter * list = [[SAfterSaleShowAfter alloc] init];
    list.apply_id = _back_apply_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sAfterSaleShowAfterSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SAfterSaleShowAfter * list = (SAfterSaleShowAfter *)data;
        arr = list.data;
//        [_tableView.mj_header endRefreshing];
        [_tableView reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arr.count;//arr.count
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW/2 - 75, 10, 150, 20)];
    title.backgroundColor = [UIColor groupTableViewBackgroundColor];
    title.layer.masksToBounds = YES;
    title.layer.cornerRadius = 5;
    [titleView addSubview:title];
    title.textColor = WordColor_sub;
    title.font = [UIFont systemFontOfSize:13];
    title.textAlignment = NSTextAlignmentCenter;
    
    SAfterSaleShowAfter * list = arr[section];
    title.text = list.time;
    return titleView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAfterSaleShowAfter * list = arr[indexPath.section];
    if ([list.is_title integerValue] != 1) {
        return 50;
    }
    
    CGSize size = [list.content boundingRectWithSize:CGSizeMake(ScreenW - 60, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    NSInteger  num = 0;
    if (size.height < 50) {
        num = 50;
    } else {
        num = size.height + 10;
    }
    return 50 + num;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == arr.count - 1) {
        return 40;
    }
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CsCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"CsCell1" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SAfterSaleShowAfter * list = arr[indexPath.section];
    cell.thisTitle.text = list.title;
    if ([list.is_title integerValue] == 1) {
        cell.thisTitle.hidden = NO;
        cell.thisTitle_HHH.constant = 50;
        cell.thisTitleLine.hidden = NO;
    } else {
        cell.thisTitle.hidden = YES;
        cell.thisTitle_HHH.constant = 0;
        cell.thisTitleLine.hidden = YES;
    }
    if ([list.type isEqualToString:@"1"]) {
        cell.leftImage.hidden = YES;
        cell.rightImage.hidden = NO;
        cell.blueView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        cell.thisTitle.textColor = WordColor_sub;
        cell.thisContent.textColor = WordColor_sub;
        cell.thisTitleLine.backgroundColor = WordColor_sub;
    } else {
        cell.leftImage.hidden = NO;
        if ([list.setting isEqualToString:@"1"]) {
            cell.leftImage.image = [UIImage imageNamed:@"售后黄"];
            cell.blueView.backgroundColor = [UIColor colorWithRed:241/255.0 green:130/255.0 blue:70/255.0 alpha:1.0];
        } else {
            cell.leftImage.image = [UIImage imageNamed:@"售后蓝"];
            cell.blueView.backgroundColor = [UIColor colorWithRed:82/255.0 green:162/255.0 blue:204/255.0 alpha:1.0];
        }
        cell.rightImage.hidden = YES;
        cell.thisTitle.textColor = [UIColor whiteColor];
        cell.thisContent.textColor = [UIColor whiteColor];
        cell.thisTitleLine.backgroundColor = [UIColor whiteColor];
    }
    cell.thisContent.text = list.content;

    NSLog(@"content:%@",list.content);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        //退货
//        HMemberOrderShowAfter * log = arr[indexPath.section];
//        if ([log.t_h isEqualToString:@"1"]) {
        
//        }
        
        
    } else if (indexPath.section == 4) {
        //物流跳转
//        HMemberOrderShowAfter * log = arr[indexPath.section];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.kuaidi100.com/index_all.html?type=%@kuaidi&postid=%@",log.delivery_code,log.w_sn]]];
    }
}

- (IBAction)leftBtn:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消售后?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        SAfterSaleCancelAfter * cancel = [[SAfterSaleCancelAfter alloc] init];
        cancel.back_apply_id = _back_apply_id;
        cancel.order_goods_id = _order_goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [cancel sAfterSaleCancelAfterSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (IBAction)rightBtn:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"退货"]) {
        ManifestInformationVC * rettt = [[ManifestInformationVC alloc] init];
        rettt.back_apply_id = _back_apply_id;
        rettt.infor_back = _inforBlock;
        [self.navigationController pushViewController:rettt animated:YES];
    } else {
        GCustomerService * cs = [[GCustomerService alloc] init];

        cs.thisMoney = _refund_price;
        cs.order_goods_id = _order_goods_id;
        cs.order_id = _order_id;
        cs.inforBlock = _inforBlock;
        
        NSString * typeStr;
        // 1普通商品 2拼单购 3无界预购 4比价购 5无界商店
        if ([_order_type isEqualToString:@"普通商品"]) {
            typeStr = @"1";
        } else if ([_order_type isEqualToString:@"拼单购"]) {
            typeStr = @"2";
        } else if ([_order_type isEqualToString:@"无界预购"]) {
            typeStr = @"3";
        } else if ([_order_type isEqualToString:@"比价购"]) {
            typeStr = @"4";
        } else if ([_order_type isEqualToString:@"无界商店"]) {
            typeStr = @"5";
        }
        cs.order_type = typeStr;
        [self.navigationController pushViewController:cs animated:YES];

    }
    
}
@end
