//
//  SOrderCenter_list_Auction_infor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderCenter_list_Auction_infor.h"
#import "SCallNumAll.h"
#import "SIntegralOrderDetails.h"

@interface SOrderCenter_list_Auction_infor ()
{
    NSArray * arr;
    NSString * thisNum;
}
@property (strong, nonatomic) IBOutlet UILabel *threeTitle;
@property (strong, nonatomic) IBOutlet UIButton *inforBtn;
@property (weak, nonatomic) IBOutlet UILabel *order_status;
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *order_sn;
@end

@implementation SOrderCenter_list_Auction_infor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    
    
    [_inforBtn addTarget:self action:@selector(inforBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self showModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"订单详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)showModel {
    SIntegralOrderDetails * details = [[SIntegralOrderDetails alloc] init];
    details.order_id = _order_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [details sIntegralOrderDetailsSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SIntegralOrderDetails * details = (SIntegralOrderDetails *)data;
            if ([details.data.order_status isEqualToString:@"10"]) {
                _order_status.text = @"进行中";
            } else if ([details.data.order_status isEqualToString:@"11"]) {
                _order_status.text = @"已揭晓";
            } else if ([details.data.order_status isEqualToString:@"12"]) {
                _order_status.text = @"已中奖";
            } else  {
                _order_status.text = @"状态有误,请联系客服";
            }
            [_goods_img sd_setImageWithURL:[NSURL URLWithString:details.data.list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            _goods_name.text = details.data.list.goods_name;
            _order_sn.text = [NSString stringWithFormat:@"期    号:%@",details.data.order_sn];
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"参    与:%@人次  查看全部号码",details.data.goods_num]];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(11 + details.data.goods_num.length, 6)];
            _threeTitle.attributedText = AttributedStr;
            arr = details.data.list.number;
            thisNum = details.data.goods_num;
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
#pragma mark - 查看全部号码
- (void)inforBtnClick {
    SCallNumAll * callNum = [[SCallNumAll alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:callNum];
    [callNum showModel:arr];
    callNum.thisNum.text = [NSString stringWithFormat:@"您参与了%@次，参与号码如下",thisNum];
    callNum.SCallNumAll_close = ^{
        [callNum removeFromSuperview];
    };
}
@end
