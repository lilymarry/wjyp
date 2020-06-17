//
//  SOrderCompleteController.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderCompleteController.h"
#import "SMemberOrder.h"
#import "SAAPIHelper.h"
#import "SlineDetailWebController.h"
@interface SOrderCompleteController ()
@property (weak, nonatomic) IBOutlet UIButton *checkOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *backMainBtn;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLab;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLab;

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIImageView *payStatusImageView;
@property (weak, nonatomic) IBOutlet UILabel *payStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) CALayer * cornerLayer;
@end

@implementation SOrderCompleteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单完成";
    self.cornerLayer = [[CALayer alloc] init];
    self.cornerLayer.backgroundColor=[UIColor whiteColor].CGColor;
    [self.topView.layer addSublayer:self.cornerLayer];
    [self.topView bringSubviewToFront:self.userIconImageView];
    
    self.payStatusLabel.textColor = [UIColor colorWithRed:29.501/255.0 green:174.247/255.0 blue:28.4988/255.0 alpha:1];
    
    [self CreatNavBar];
    
    [self requestDataFromServer];
}


-(void)requestDataFromServer{
     _order_id = _order_id ?:@"";
    [MBProgressHUD showMessage:nil toView:self.view];
    [SAAPIHelper offlineStore_orderSuccess_order_id:_order_id
                                         completion:^(BOOL isSuccess, NSString *message, id result) {
                                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                             if (isSuccess) {
                                                 [self dealWithDataWithModel:result];
                                             }else{
                                                 [MBProgressHUD showError:message toView:self.view];
                                             }
                                         }];
    
    
}

-(void)dealWithDataWithModel:(id)data{
    SOrderCompleteModel *model = data;
 
    [_userIconImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]
                          placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

    _merchantNameLab.text = model.merchant_name;
    _payTimeLab.text = [NSString stringWithFormat:@"时间:%@",model.pay_time];
    
    if (model.pay_status) {
        [_payStatusImageView setImage:[UIImage imageNamed:@"付款成功"]];
        _payMoneyLabel.text = @"支付成功";
        _payStatusLabel.text= @"支付成功";
    }else{
        [_payStatusImageView setImage:[UIImage imageNamed:@"付款失败"]];
        _payMoneyLabel.text = @"支付失败";
        _payStatusLabel.text= @"支付失败";
    }
    _payMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",model.order_price];
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:_payMoneyLabel.text];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    _payMoneyLabel.attributedText = AttributedStr;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //设置圆角
    self.cornerLayer.position = self.userIconImageView.layer.position;
    self.cornerLayer.bounds = self.userIconImageView.layer.bounds;
    
    self.userIconImageView.layer.cornerRadius = self.userIconImageView.bounds.size.width * 0.5;
    self.userIconImageView.layer.borderWidth = 2;
    self.userIconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userIconImageView.clipsToBounds = YES;

    self.cornerLayer.shadowColor=[UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.cornerLayer.shadowRadius = 1;
    self.cornerLayer.shadowOffset = CGSizeMake(0.5,1);
    self.cornerLayer.shadowOpacity = 0.5;
    self.cornerLayer.cornerRadius = self.userIconImageView.layer.cornerRadius;

    
    self.checkOrderBtn.layer.cornerRadius = self.checkOrderBtn.bounds.size.height * 0.5;
    self.checkOrderBtn.layer.borderWidth = 1;
    self.checkOrderBtn.layer.borderColor = [UIColor colorWithRed:241.996/255.0 green:47.9993/255.0 blue:47.9993/255.0 alpha:1].CGColor;
    self.checkOrderBtn.layer.masksToBounds = YES;
    
    
    self.backMainBtn.layer.cornerRadius = self.backMainBtn.bounds.size.height * 0.5;
    self.backMainBtn.layer.borderWidth = 1;
    self.backMainBtn.layer.borderColor = [UIColor colorWithRed:253.0/255.0 green:127.998/255.0 blue:1.99997/255.0 alpha:1].CGColor;
    self.backMainBtn.layer.masksToBounds = YES;
}
//创建NavigationBar
-(void)CreatNavBar{
    UIButton * leftBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBackBtn.frame = CGRectMake(0, 0, 30, 44);
    [leftBackBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    [leftBackBtn addTarget:self action:@selector(PopCurrentInterface) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackBtn];
    
    self.navigationItem.leftBarButtonItems = @[leftBackBarItem];
}


- (IBAction)lookOrderPage:(UIButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        NSString *    urlStr =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/os_orderlist/status/9/p/1.html", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
        conter.fag=@"15";
        conter.urlStr=urlStr;
        [self.navigationController pushViewController:conter animated:YES];
        
//        SMemberOrder*memberOrderVC = [SMemberOrder new];
//        memberOrderVC.coming = _isPopRootVC; //支付进入   直接进入
//        memberOrderVC.type = @"线下商铺";
//        [self.navigationController pushViewController:memberOrderVC animated:YES];
    });
}

- (IBAction)popToHomePage:(UIButton *)sender {
//    [self PopCurrentInterface];
    if (self.tabBarController.selectedIndex != 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:NO];
        });
        self.tabBarController.selectedIndex = 0;
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

//返回上一级界面
-(void)PopCurrentInterface{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
