//
//  SEvaSubmit.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaSubmit.h"
#import "RatingBar.h"
#import "SEvaSubmitCell.h"

#import "SOrderCommentindex.h"
#import "SOrderCommentOrder.h"

#import "SEvaSubmit_subViewController.h"

#import "SAAPIHelper.h"


@interface SEvaSubmit () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * model_imageArr;
    
    NSArray * arr;
    RatingBar * merchant_star;
    NSString * merchant_star_num;
    RatingBar * delivery_star;
    NSString * delivery_star_num;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIButton *downBtn;

@property (nonatomic, strong)SAAPIHelper *apiHelper;
@end

@implementation SEvaSubmit

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];

    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SEvaSubmitCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SEvaSubmitCell"];
    
    _downBtn.layer.masksToBounds = YES;
    _downBtn.layer.cornerRadius = 15;
    _downBtn.layer.borderWidth = 1.0;
    _downBtn.layer.borderColor = [UIColor redColor].CGColor;
    
//    if ([_order_type isEqualToString:@"线下商铺"]) {
//        self.apiHelper = [SAAPIHelper new];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"订单评价";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [self showModel];
}
- (void)showModel {
    
//    if ([_order_type isEqualToString:@"线下商铺"]) {
//
//        [self.apiHelper offlineStoreCommentWithOrder_id:<#(NSString *)#>
//                                                content:<#(NSString *)#>
//                                                picture:<#(NSArray *)#>
//                                            environment:<#(NSString *)#>
//                                                  serve:<#(NSString *)#>];
//        return;
//    }
    
    SOrderCommentindex * list = [[SOrderCommentindex alloc] init];
    list.order_id = _order_id;
    if ([_order_type isEqualToString:@"普通商品"]) {

    list.order_type = @"1";
 
        
    } else if ([_order_type isEqualToString:@"拼单购"]) {
        list.order_type = @"2";
    } else if ([_order_type isEqualToString:@"无界预购"]) {
        list.order_type = @"3";
    } else if ([_order_type isEqualToString:@"比价购"]) {
        list.order_type = @"4";
    } else if ([_order_type isEqualToString:@"无界商店"]) {
        list.order_type = @"5";
    }
    else if ([_order_type isEqualToString:@"集碎片"]) {
        list.order_type = @"16";
    }
    else
    {
        list.order_type = @"";
    }

    [MBProgressHUD showMessage:nil toView:self.view];
    [list sOrderCommentindexSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SOrderCommentindex * list = (SOrderCommentindex *)data;
            
            arr = list.data.goods_list;
            [_mTable reloadData];
            
            [merchant_star removeFromSuperview];
            [delivery_star removeFromSuperview];
            
            //星星
            merchant_star = [[RatingBar alloc] initWithFrame:CGRectMake(85,0, 130, 50)];
            merchant_star.viewColor = [UIColor clearColor];
            merchant_star.starNum = ^(int starNum) {
                        merchant_star_num = [NSString stringWithFormat:@"%d",starNum];
            };
            [_oneView addSubview:merchant_star];
            
            delivery_star = [[RatingBar alloc] initWithFrame:CGRectMake(85,0, 130, 50)];
            delivery_star.viewColor = [UIColor clearColor];
            delivery_star.starNum = ^(int starNum) {
                        delivery_star_num = [NSString stringWithFormat:@"%d",starNum];
            };
            [_twoView addSubview:delivery_star];
            if ([list.data.order_status isEqualToString:@"0"]) {
                merchant_star.starNumber = 5;
                merchant_star_num = @"5";
                delivery_star.starNumber = 5;
                delivery_star_num = @"5";
                merchant_star.enable = YES;
                delivery_star.enable = YES;
                _downBtn.hidden = NO;
            } else {
                merchant_star.starNumber = [list.data.merchant_star integerValue];
                delivery_star.starNumber = [list.data.delivery_star integerValue];
                merchant_star.enable = NO;
                delivery_star.enable = NO;
                _downBtn.hidden = YES;
            }
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
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
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 10;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEvaSubmitCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SEvaSubmitCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SOrderCommentindex * list = arr[indexPath.section];
    [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.goods_name.text = list.goods_name;
    if ([list.is_active isEqualToString:@"2"]) {
        cell.view_2980.hidden=NO;
        cell.lab_2980.text=@"399";
    }
    else
    {
        cell.view_2980.hidden=YES;
    }
    if ([list.status isEqualToString:@"0"]) {
        cell.submitBtn.hidden = NO;
    } else {
        for (UIView * view in cell.starView.subviews) {
            [view removeFromSuperview];
        }
        for (int i = 0; i < 5; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 12, 15, 15)];
            [cell.starView addSubview:imageView];
            if (i < [list.all_star integerValue]) {
                imageView.image = [UIImage imageNamed:@"评价黄星"];
            } else {
                imageView.image = [UIImage imageNamed:@"评价白星"];
            }
        }
        cell.submitBtn.hidden = YES;
    }
    [cell.submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.submitBtn setTag:indexPath.section];
    return cell;
}
- (void)submitBtnClick:(UIButton *)btn {
    SOrderCommentindex * list = arr[btn.tag];

    SEvaSubmit_subViewController * eva_sub = [[SEvaSubmit_subViewController alloc] init];
    if ([_order_type isEqualToString:@"普通商品"]) {
        
        eva_sub.order_type = @"1";
        
    } else if ([_order_type isEqualToString:@"拼单购"]) {
        eva_sub.order_type = @"2";
    } else if ([_order_type isEqualToString:@"无界预购"]) {
        eva_sub.order_type = @"3";
    } else if ([_order_type isEqualToString:@"比价购"]) {
        eva_sub.order_type = @"4";
    } else if ([_order_type isEqualToString:@"无界商店"]) {
        eva_sub.order_type = @"5";
    }
    else if ([_order_type isEqualToString:@"集碎片"]) {
        eva_sub.order_type = @"16";
    }
    else
    {
        eva_sub.order_type = @"";
    }

    eva_sub.model_goods_img = list.goods_img;
    eva_sub.model_goods_name = list.goods_name;
    eva_sub.order_id = _order_id;
    eva_sub.order_goods_id = list.order_goods_id;
    [self.navigationController pushViewController:eva_sub animated:YES];
}
- (IBAction)downBtn:(UIButton *)sender {
    SOrderCommentOrder * order = [[SOrderCommentOrder alloc] init];
    order.order_id = _order_id;
    order.merchant_star = merchant_star_num;
    order.delivery_star = delivery_star_num;
    if ([_order_type isEqualToString:@"普通商品"]) {
        order.order_type = @"1";
    } else if ([_order_type isEqualToString:@"拼单购"]) {
        order.order_type = @"2";
    } else if ([_order_type isEqualToString:@"无界预购"]) {
        order.order_type = @"3";
    } else if ([_order_type isEqualToString:@"比价购"]) {
        order.order_type = @"4";
    } else if ([_order_type isEqualToString:@"无界商店"]) {
        order.order_type = @"5";
    }
    else if ([_order_type isEqualToString:@"集碎片"]) {
        order.order_type = @"16";
    }
    else
    {
         order.order_type = @"";
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [order sOrderCommentOrderSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showModel];
            });
        } else {
            [MBProgressHUD showSuccess:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
@end
