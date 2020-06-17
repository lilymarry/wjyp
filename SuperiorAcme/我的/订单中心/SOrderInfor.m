//
//  SOrderInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderInfor.h"
#import "SOrderInfor_top.h"
#import "SOrderInfor_down.h"
#import "SOrderInfor_footer.h"
#import "SOrderInforCell.h"
#import "SOrderInforCell_sub.h"
#import "SOrderInforCell_sub_sub.h"
#import "GCustomerService.h"//申请售后
#import "CustomerServiceInfor.h"//售后流程图

#import "SOrderDetails.h"//普通商品详情
#import "SPay.h"
#import "SEvaSubmit.h"
#import "SOrderReceiving.h"
#import "SOrderCancelOrder.h"
#import "SOrderDeleteOrder.h"
#import "SGroupBuyOrderDetails.h"//拼单商品详情
#import "SGroupBuyOrderCancelOrder.h"
#import "SGroupBuyOrderDeleteOrder.h"
#import "SGroupBuyOrderReceiving.h"
#import "SPreOrderPreDetails.h"//无界预购详情
#import "SPreOrderPreCancelOrder.h"
#import "SPreOrderPreDeleteOrder.h"
#import "SPreOrderPreReceiving.h"
#import "SAuctionOrderPreDetails.h"//比价购详情
#import "SAuctionOrderCancelOrder.h"
#import "SAuctionOrderDeleteOrder.h"
#import "SAuctionOrderReceiving.h"
#import "SOrderConfirm.h"
#import "SIntegralBuyOrderDetails.h"//无界商店详情
#import "SIntegralBuyOrderCancelOrder.h"
#import "SIntegralBuyOrderDeleteOrder.h"
#import "SIntegralBuyOrderReceiving.h"

//#import "SMessageInfor.h"//快递信息加载
#import "SOrder_logistics.h"//大礼包多物流
#import "SOrderInfor_Come.h"//确认收货提示
#import "SOrderDelayReceiving.h"//延长收货
#import "SOnlineShopInfor.h"//店铺详情
#import "SOrderRemind.h"//发货提醒
#import "SPay_Pass.h"//收货验证

#import "SgiftOderDetailModel.h"
#import "SgiftOderReceivingModel.h"
#import "SgiftDeleteOder.h"
#import "SgiftCancelOrderModel.h"
#import "SgiftOrderdelayReceiving.h"

@interface SOrderInfor () <UITableViewDelegate,UITableViewDataSource>
{
    SOrderInfor_top * top;
    SOrderInfor_down * down;
    NSArray * arr;
    NSArray * crr;
    
    NSString * order_num;//总个数
    NSString * order_price;//总金额
    NSString * pay_tickets;//使用券金额
    NSString * ticket_color;//1红 2黄 3蓝
    NSString * order_status;//订单状态
    
    BOOL firstComing;//第一次进来
    
    //拼团购需要传递的参数
    NSString * model_order_type;
    NSString * model_group_buy_id;

    
    //无界优品所需参数
    NSString * start;//": 1,                                    // 定金
    NSString * end;//": 4,                                   // 尾款
    NSString * start_integral;//”：999                        // 定金积分
    NSString * final_integral;//”：999                        // 尾款积分
    
    //比价购所需参数
    NSString * model_buy_type;//”                //订单类型（0->一口价，1->竞拍）
    
    NSString * model_freight;//"   // 运费
    NSString * model_express_company;//"   // 快递公司名
    NSString * model_express_no;//"           // 快递单号
    
    NSString * model_sure_status;//1支持七天无理由退换货
   // NSString * model_server;//": "放弃此商品七天无理由退换货？",              // 确认收货提示框内容
    NSString * model_server_else;//": "注：七天后将自动收货",                    // 确认收货提示框注释内容
    
    NSString * merchant_id;//商家id
    NSString *  apply_id;
    NSString *  order_type;
   
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mTable_HHH;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
/*
 *用户真实支付的金额(无论有没有使用代金券)
 */
@property (nonatomic, assign) CGFloat RealPayMoney;
@end

@implementation SOrderInfor
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"订单详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)viewDidAppear:(BOOL)animated {
    if (firstComing == NO) {
        firstComing = YES;
    } else {
        [self showModel];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SOrderInforCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOrderInforCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"SOrderInforCell_sub" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOrderInforCell_sub"];
    [_mTable registerNib:[UINib nibWithNibName:@"SOrderInforCell_sub_sub" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOrderInforCell_sub_sub"];
    
    top = [[SOrderInfor_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 210)];
    top.sendView.hidden = YES;
    top.sendView_HHH.constant = 0;
    _mTable.tableHeaderView = top;
    [top.freightBtn addTarget:self action:@selector(freightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [top.merchant_inforBtn addTarget:self action:@selector(merchant_inforBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    down = [[SOrderInfor_down alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    _mTable.tableFooterView = down;
    
    
    _oneBtn.layer.masksToBounds = YES;
    _oneBtn.layer.cornerRadius = 15;
    _oneBtn.layer.borderWidth = 1.0;
    _oneBtn.layer.borderColor = MyLine.CGColor;
    
    _twoBtn.layer.masksToBounds = YES;
    _twoBtn.layer.cornerRadius = 15;
    _twoBtn.layer.borderWidth = 1.0;
    _twoBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    [self showModel];
}
- (void)showModel {
    if ([_order_type isEqualToString:@"普通商品"]) {
        SOrderDetails * detail = [[SOrderDetails alloc] init];
        detail.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [detail sOrderDetailsSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SOrderDetails * detail = (SOrderDetails *)data;
                order_status = detail.data.order_status;
                apply_id= detail.data.apply_id;
                
                down.thisContent.text = detail.data.leave_message;
                if ([detail.data.order_status isEqualToString:@"0"]) {
                    top.order_status.text = @"待付款";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_twoBtn setTitle:@"付款" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"1"]) {
                    top.order_status.text = @"待发货";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"2"]) {
                    top.order_status.text = @"待收货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
//                    [_twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"3"]) {
                    top.order_status.text = @"待评价";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"评价" forState:UIControlStateNormal];
                    if ([detail.data.apply_id isEqualToString:@"0"]&&[detail.data.order_type isEqualToString:@"7"]) {
                       _oneBtn.hidden = NO;
                        [_oneBtn setTitle:@"去寄售" forState:UIControlStateNormal];
                    }
                  
                }
                if ([detail.data.order_status isEqualToString:@"4"]) {
                    top.order_status.text = @"已完成";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                    if ([detail.data.apply_id isEqualToString:@"0"]&&[detail.data.order_type isEqualToString:@"7"]) {
                        _oneBtn.hidden = NO;
                        [_oneBtn setTitle:@"去寄售" forState:UIControlStateNormal];
                    }
                }
                if ([detail.data.order_status isEqualToString:@"5"]) {
                    top.order_status.text = @"已取消";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                top.logistics.text = detail.data.logistics;
                top.logistics_time.text = detail.data.logistics_time;
                top.user_name.text = detail.data.user_name;
                top.phone.text = detail.data.phone;
                top.address.text = detail.data.address;
              
                   //top.merchant_name.text =[NSString stringWithFormat:@"%@(分销)",detail.data.shop_name] ;
                    if (detail.data.shop_name.length==0) {
                        top.merchant_name.text =[NSString stringWithFormat:@"%@",detail.data.merchant_name] ;
                    }
                    else
                    {
                       top.merchant_name.text =[NSString stringWithFormat:@"%@",detail.data.shop_name] ;
                    }
                    
               
                merchant_id = detail.data.merchant_id;
                order_price = detail.data.order_price;
                pay_tickets = detail.data.pay_tickets;
                ticket_color = detail.data.ticket_color;
                model_freight = detail.data.freight;
                model_express_company = detail.data.express_company;
                model_express_no = detail.data.express_no;
                NSInteger list_num = 0;
                for (SOrderDetails * list in detail.data.list) {
                    list_num += [list.goods_num integerValue];
                }
                order_num = [NSString stringWithFormat:@"%zd",list_num];
                arr = detail.data.list;
                [_mTable reloadData];
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_order_type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderDetails * detail = [[SGroupBuyOrderDetails alloc] init];
        detail.group_buy_order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [detail sGroupBuyOrderDetailsSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            //@"GroupBuyOrder/details" 此接口 code 返回类型是数字 再以下代码中做了类型处理 方式app crash
            NSString *str;
            if ([code isKindOfClass:[NSNumber class]]) {
                str = [NSString stringWithFormat:@"%@", code];
            } else {
                str = code;
            }
            if ([str isEqualToString:@"1"]) {
                SGroupBuyOrderDetails * detail = (SGroupBuyOrderDetails *)data;
                down.thisContent.text = detail.data.leave_message;
                model_order_type = detail.data.order_type;
                model_group_buy_id = detail.data.group_buy_id;
                order_status = detail.data.order_status;
                if ([detail.data.order_status isEqualToString:@"0"]) {
                    top.order_status.text = @"待付款";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_twoBtn setTitle:@"付款" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"1"]) {
                    top.order_status.text = @"拼单中";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"2"]) {
                    top.order_status.text = @"待发货";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"3"]) {
                    top.order_status.text = @"待收货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
//                    [_twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"4"]) {
                    top.order_status.text = @"待评价";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"评价" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"5"]) {
                    top.order_status.text = @"已完成";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 0;
              //      [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"6"]) {
                    top.order_status.text = @"已取消";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                
                if ([detail.data.order_status isEqualToString:@"7"]) {
                    top.order_status.text = @"待抽奖";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                    down.hidden = YES;
                }
                
                if ([detail.data.order_status isEqualToString:@"8"]) {
                    top.order_status.text = @"未拼成";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                    down.hidden = YES;
                }
                
                if ([detail.data.order_status isEqualToString:@"10"]) {
                    top.order_status.text = @"未中奖";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
//                    _twoBtn.hidden = YES;
//                    _mTable_HHH.constant = 0;
//                    down.hidden = YES;
                    /*
                     *体验拼单,未中奖的订单详情页,显示"删除订单"按钮
                     */
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                
                top.logistics.text = detail.data.logistics;
                top.logistics_time.text = detail.data.logistics_time;
                top.user_name.text = detail.data.user_name;
                top.phone.text = detail.data.phone;
                top.address.text = detail.data.address;
                top.merchant_name.text = detail.data.merchant_name;
                order_price = detail.data.order_price;
                model_freight = detail.data.freight;
                model_express_company = detail.data.express_company;
                model_express_no = detail.data.express_no;
                
                /*
                 *获取使用的代金券的金额和代金券的类型
                 */
                pay_tickets = detail.data.pay_tickets;
                ticket_color = detail.data.ticket_color;
                /*
                 *拼单界面添加店铺id
                 */
                merchant_id = detail.data.merchant_id;
                NSInteger list_num = 0;
                for (SGroupBuyOrderDetails * list in detail.data.list) {
                    list_num += [list.goods_num integerValue];
                }
                order_num = [NSString stringWithFormat:@"%zd",list_num];
                arr = detail.data.list;
                [_mTable reloadData];
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_order_type isEqualToString:@"无界预购"]) {
        SPreOrderPreDetails * detail = [[SPreOrderPreDetails alloc] init];
        detail.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [detail sPreOrderPreDetailsSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SPreOrderPreDetails * detail = (SPreOrderPreDetails *)data;
                down.thisContent.text = detail.data.leave_message;
                start = detail.data.start;
                end = detail.data.end;
                start_integral = detail.data.start_integral;
                final_integral = detail.data.final_integral;
                order_status = detail.data.order_status;
                if ([detail.data.order_status isEqualToString:@"0"]) {
                    top.order_status.text = @"预购中";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"1"]) {
                    top.order_status.text = @"待付尾款";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_twoBtn setTitle:@"付款" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"2"]) {
                    top.order_status.text = @"待发货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"3"]) {
                    top.order_status.text = @"待收货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
//                    [_twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"4"]) {
                    top.order_status.text = @"待评价";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"评价" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"5"]) {
                    top.order_status.text = @"已完成";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"6"]) {
                    top.order_status.text = @"已取消";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"7"]) {
                    top.order_status.text = @"待付定金";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_twoBtn setTitle:@"付款" forState:UIControlStateNormal];
                }
                top.logistics.text = detail.data.logistics;
                top.logistics_time.text = detail.data.logistics_time;
                top.user_name.text = detail.data.user_name;
                top.phone.text = detail.data.phone;
                top.address.text = detail.data.address;
                top.merchant_name.text = detail.data.merchant_name;
                order_price = detail.data.order_price;
                model_freight = detail.data.freight;
                model_express_company = detail.data.express_company;
                model_express_no = detail.data.express_no;
                NSInteger list_num = 0;
                for (SPreOrderPreDetails * list in detail.data.list) {
                    list_num += [list.goods_num integerValue];
                }
                order_num = [NSString stringWithFormat:@"%zd",list_num];
                arr = detail.data.list;
                [_mTable reloadData];
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_order_type isEqualToString:@"比价购"]||[_order_type isEqualToString:@"比价购纪录"]) {
        SAuctionOrderPreDetails * detail = [[SAuctionOrderPreDetails alloc] init];
        detail.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [detail sAuctionOrderPreDetailsSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SAuctionOrderPreDetails * detail = (SAuctionOrderPreDetails *)data;
                down.thisContent.text = detail.data.leave_message;
                order_status = detail.data.order_status;
                model_buy_type = detail.data.buy_type;
                if ([detail.data.order_status isEqualToString:@"1"]) {
                    top.order_status.text = @"待付款";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_twoBtn setTitle:@"付款" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"3"]) {
                    top.order_status.text = @"待发货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"4"]) {
                    top.order_status.text = @"待收货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
//                    [_twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"8"]) {
                    top.order_status.text = @"待评价";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"评价" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"6"]) {
                    top.order_status.text = @"已完成";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"5"]) {
                    top.order_status.text = @"已取消";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"10"]) {
                    top.order_status.text = @"竞拍中";
                    top.frame = CGRectMake(0, 0, ScreenW, 100);
                    top.sendView_topHHH.constant = 0;
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    top.addressView.hidden = YES;
                    top.addressView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"11"]) {
                    top.order_status.text = @"竞拍成功";
                    top.frame = CGRectMake(0, 0, ScreenW, 100);
                    top.sendView_topHHH.constant = 0;
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    top.addressView.hidden = YES;
                    top.addressView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"12"]) {
                    top.order_status.text = @"竞拍结束";
                    top.frame = CGRectMake(0, 0, ScreenW, 100);
                    top.sendView_topHHH.constant = 0;
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    top.addressView.hidden = YES;
                    top.addressView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                top.logistics.text = detail.data.logistics;
                top.logistics_time.text = detail.data.logistics_time;
                top.user_name.text = detail.data.user_name;
                top.phone.text = detail.data.phone;
                top.address.text = detail.data.address;
                top.merchant_name.text = detail.data.merchant_name;
                order_price = detail.data.order_price;
                model_freight = detail.data.freight;
                model_express_company = detail.data.express_company;
                model_express_no = detail.data.express_no;
                NSInteger list_num = 0;
                for (SPreOrderPreDetails * list in detail.data.list) {
                    list_num += [list.goods_num integerValue];
                }
                order_num = [NSString stringWithFormat:@"%zd",list_num];
                arr = detail.data.list;
                [_mTable reloadData];
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_order_type isEqualToString:@"无界商店"]) {
        SIntegralBuyOrderDetails * detail = [[SIntegralBuyOrderDetails alloc] init];
        detail.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [detail sIntegralBuyOrderDetailsSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SIntegralBuyOrderDetails * detail = (SIntegralBuyOrderDetails *)data;
                order_status = detail.data.order_status;
                down.thisContent.text = detail.data.leave_message;
                if ([detail.data.order_status isEqualToString:@"0"]) {
                    top.order_status.text = @"待付款";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_twoBtn setTitle:@"付款" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"1"]) {
                    top.order_status.text = @"待发货";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"2"]) {
                    top.order_status.text = @"待收货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                    //                    [_twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"3"]) {
                    top.order_status.text = @"待评价";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"评价" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"4"]) {
                    top.order_status.text = @"已完成";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    /*
                     *显示物流信息查看框
                     */
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 0;
                  //  [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"5"]) {
                    top.order_status.text = @"已取消";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                top.logistics.text = detail.data.logistics;
                top.logistics_time.text = detail.data.logistics_time;
                top.user_name.text = detail.data.user_name;
                top.phone.text = detail.data.phone;
                top.address.text = detail.data.address;
                top.merchant_name.text = detail.data.merchant_name;
                merchant_id = detail.data.merchant_id;
                order_price = detail.data.order_price;
                pay_tickets = detail.data.pay_tickets;
                ticket_color = detail.data.ticket_color;
                model_freight = detail.data.freight;
                model_express_company = detail.data.express_company;
                model_express_no = detail.data.express_no;
                NSInteger list_num = 0;
                for (SOrderDetails * list in detail.data.list) {
                    list_num += [list.goods_num integerValue];
                }
                order_num = [NSString stringWithFormat:@"%zd",list_num];
                arr = detail.data.list;
                [_mTable reloadData];
                /*
                order_status = detail.data.order_status;
                down.thisContent.text = detail.data.leave_message;
                if ([detail.data.order_status isEqualToString:@"0"]) {
                    top.order_status.text = @"待付款";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_twoBtn setTitle:@"付款" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"1"]) {
                    top.order_status.text = @"待发货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"2"]) {
                    top.order_status.text = @"待收货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
//                    [_twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"3"]) {
                    top.order_status.text = @"待评价";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"评价" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"4"]) {
                    top.order_status.text = @"已完成";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"5"]) {
                    top.order_status.text = @"已取消";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                top.logistics.text = detail.data.logistics;
                top.logistics_time.text = detail.data.logistics_time;
                top.user_name.text = detail.data.user_name;
                top.phone.text = detail.data.phone;
                top.address.text = detail.data.address;
                top.merchant_name.text = detail.data.merchant_name;
                order_price = detail.data.order_price;
                model_freight = detail.data.freight;
                model_express_company = detail.data.express_company;
                model_express_no = detail.data.express_no;
                NSInteger list_num = 0;
//                for (SIntegralBuyOrderDetails * list in detail.data.list) {
//                    list_num += [list.goods_num integerValue];
//                }
                order_num = [NSString stringWithFormat:@"%@",detail.data.goods_num];
                arr = detail.data.list;
                [_mTable reloadData];
                */
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    else if ([_order_type isEqualToString:@"赠品专区"])
    {
        SgiftOderDetailModel * detail = [[SgiftOderDetailModel alloc] init];
        detail.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [detail SgiftOderDetailModelSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"200"]) {
                SgiftOderDetailModel * detail = (SgiftOderDetailModel *)data;
                order_status = detail.data.order_status;
                down.thisContent.text = detail.data.leave_message;
                if ([detail.data.order_status isEqualToString:@"0"]) {
                    top.order_status.text = @"待付款";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_twoBtn setTitle:@"付款" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"1"]) {
                    top.order_status.text = @"待发货";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
                if ([detail.data.order_status isEqualToString:@"2"]) {
                    top.order_status.text = @"待收货";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                    //                    [_twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                }
//                if ([detail.data.order_status isEqualToString:@"3"]) {
//                    top.order_status.text = @"待评价";
//                    top.frame = CGRectMake(0, 0, ScreenW, 310);
//                    top.sendView.hidden = NO;
//                    top.sendView_HHH.constant = 100;
//                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
//                    _oneBtn.hidden = YES;
//                    _twoBtn.hidden = NO;
//                    _mTable_HHH.constant = 50;
//                    [_twoBtn setTitle:@"评价" forState:UIControlStateNormal];
//                }
                if ([detail.data.order_status isEqualToString:@"4"]) {
                    top.order_status.text = @"已完成";
                    top.frame = CGRectMake(0, 0, ScreenW, 310);
                    /*
                     *显示物流信息查看框
                     */
                    top.sendView.hidden = NO;
                    top.sendView_HHH.constant = 100;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                    _oneBtn.hidden = NO;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 0;
                    //  [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if ([detail.data.order_status isEqualToString:@"5"]) {
                    top.order_status.text = @"已取消";
                    top.frame = CGRectMake(0, 0, ScreenW, 210);
                    top.sendView.hidden = YES;
                    top.sendView_HHH.constant = 0;
                    crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                    _oneBtn.hidden = YES;
                    _twoBtn.hidden = NO;
                    _mTable_HHH.constant = 50;
                    [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                top.logistics.text = detail.data.logistics;
                top.logistics_time.text = detail.data.logistics_time;
                top.user_name.text = detail.data.user_name;
                top.phone.text = detail.data.phone;
                top.address.text = detail.data.address;
                top.merchant_name.text = detail.data.merchant_name;
                merchant_id = detail.data.merchant_id;
                order_price = detail.data.order_price;
                pay_tickets = detail.data.pay_tickets;
                ticket_color = detail.data.ticket_color;
                model_freight = detail.data.freight;
                model_express_company = detail.data.express_company;
                model_express_no = detail.data.express_no;
                NSInteger list_num = 0;
                for (SOrderDetails * list in detail.data.list) {
                    list_num += [list.goods_num integerValue];
                }
                order_num = [NSString stringWithFormat:@"%zd",list_num];
                arr = detail.data.list;
                [_mTable reloadData];
                /*
                 order_status = detail.data.order_status;
                 down.thisContent.text = detail.data.leave_message;
                 if ([detail.data.order_status isEqualToString:@"0"]) {
                 top.order_status.text = @"待付款";
                 top.frame = CGRectMake(0, 0, ScreenW, 210);
                 top.sendView.hidden = YES;
                 top.sendView_HHH.constant = 0;
                 crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                 _oneBtn.hidden = NO;
                 _twoBtn.hidden = NO;
                 _mTable_HHH.constant = 50;
                 [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                 [_twoBtn setTitle:@"付款" forState:UIControlStateNormal];
                 }
                 if ([detail.data.order_status isEqualToString:@"1"]) {
                 top.order_status.text = @"待发货";
                 top.frame = CGRectMake(0, 0, ScreenW, 310);
                 top.sendView.hidden = NO;
                 top.sendView_HHH.constant = 100;
                 crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                 _oneBtn.hidden = YES;
                 _twoBtn.hidden = YES;
                 _mTable_HHH.constant = 0;
                 }
                 if ([detail.data.order_status isEqualToString:@"2"]) {
                 top.order_status.text = @"待收货";
                 top.frame = CGRectMake(0, 0, ScreenW, 310);
                 top.sendView.hidden = NO;
                 top.sendView_HHH.constant = 100;
                 crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                 _oneBtn.hidden = YES;
                 _twoBtn.hidden = YES;
                 _mTable_HHH.constant = 0;
                 //                    [_twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                 }
                 if ([detail.data.order_status isEqualToString:@"3"]) {
                 top.order_status.text = @"待评价";
                 top.frame = CGRectMake(0, 0, ScreenW, 310);
                 top.sendView.hidden = NO;
                 top.sendView_HHH.constant = 100;
                 crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                 _oneBtn.hidden = YES;
                 _twoBtn.hidden = NO;
                 _mTable_HHH.constant = 50;
                 [_twoBtn setTitle:@"评价" forState:UIControlStateNormal];
                 }
                 if ([detail.data.order_status isEqualToString:@"4"]) {
                 top.order_status.text = @"已完成";
                 top.frame = CGRectMake(0, 0, ScreenW, 210);
                 top.sendView.hidden = YES;
                 top.sendView_HHH.constant = 0;
                 crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time],[NSString stringWithFormat:@"付款时间:%@",detail.data.pay_time]];
                 _oneBtn.hidden = YES;
                 _twoBtn.hidden = NO;
                 _mTable_HHH.constant = 50;
                 [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                 }
                 if ([detail.data.order_status isEqualToString:@"5"]) {
                 top.order_status.text = @"已取消";
                 top.frame = CGRectMake(0, 0, ScreenW, 210);
                 top.sendView.hidden = YES;
                 top.sendView_HHH.constant = 0;
                 crr = @[[NSString stringWithFormat:@"订单编号:%@",detail.data.order_sn],[NSString stringWithFormat:@"创建时间:%@",detail.data.create_time]];
                 _oneBtn.hidden = YES;
                 _twoBtn.hidden = NO;
                 _mTable_HHH.constant = 50;
                 [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                 }
                 top.logistics.text = detail.data.logistics;
                 top.logistics_time.text = detail.data.logistics_time;
                 top.user_name.text = detail.data.user_name;
                 top.phone.text = detail.data.phone;
                 top.address.text = detail.data.address;
                 top.merchant_name.text = detail.data.merchant_name;
                 order_price = detail.data.order_price;
                 model_freight = detail.data.freight;
                 model_express_company = detail.data.express_company;
                 model_express_no = detail.data.express_no;
                 NSInteger list_num = 0;
                 //                for (SIntegralBuyOrderDetails * list in detail.data.list) {
                 //                    list_num += [list.goods_num integerValue];
                 //                }
                 order_num = [NSString stringWithFormat:@"%@",detail.data.goods_num];
                 arr = detail.data.list;
                 [_mTable reloadData];
                 */
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
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
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return arr.count;//商品
    } else if (section == 1) {
        if (![_order_type isEqualToString:@"普通商品"] && ![_order_type isEqualToString:@"拼单购"]&& ![_order_type isEqualToString:@"比价购"]&&![_order_type isEqualToString:@"比价购纪录"]&&![_order_type isEqualToString:@"无界商店"]&&![_order_type isEqualToString:@"赠品专区"]) {
            if ([order_status isEqualToString:@"0"] || [order_status isEqualToString:@"7"]) {
                return 1;//一阶段
            }
            return 2;//二阶段
        } else {
            return 0;
        }
    }
    return crr.count;//订单信息
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else if (section == 1) {
        if ([_order_type isEqualToString:@"比价购纪录"]) {
            return 0.01;
        }
        return 110;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.01)];
        footer.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        return footer;
    } else if (section == 1) {
        if ([_order_type isEqualToString:@"比价购纪录"]) {
            UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.01)];
            footer.backgroundColor = [UIColor groupTableViewBackgroundColor];
            return footer;
        }
        SOrderInfor_footer * footer = [[SOrderInfor_footer alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 110)];
        
        footer.freight.text = [model_freight floatValue] < 0.01 ? @"包邮" : [NSString stringWithFormat:@"%@元",model_freight];
        footer.order_num.text = [NSString stringWithFormat:@"共%@件商品 合计：",order_num];
        if ([_order_type isEqualToString:@"无界商店"]) {
            footer.order_price.text = [NSString stringWithFormat:@"%@积分",order_price];
        }
        else if ([_order_type isEqualToString:@"赠品专区"])
        {
           footer.order_price.text = [NSString stringWithFormat:@"%@赠品券",order_price];
        }
        else {
            if ([pay_tickets integerValue] == 0) {
                //未用券
                footer.order_price.text = [NSString stringWithFormat:@"￥%@",order_price];
                /*
                 *实际付款金额
                 */
                self.RealPayMoney = [order_price floatValue];
            } else {
                //除去待支付、已取消订单
                if ([order_status integerValue] != 0 && [order_status integerValue] != 5) {
                    /*
                     *实际付款金额
                     */
                    self.RealPayMoney = [order_price floatValue] - [pay_tickets floatValue];
                    if ([ticket_color integerValue] == 1) {
//                        footer.order_price.text = [NSString stringWithFormat:@"￥%.2f(已抵%@红券)",[order_price floatValue] - [pay_tickets floatValue],pay_tickets];
                        footer.order_price.text = [NSString stringWithFormat:@"￥%.2f(已抵%@红券)",self.RealPayMoney,pay_tickets];
                    }
                    if ([ticket_color integerValue] == 2) {
//                        footer.order_price.text = [NSString stringWithFormat:@"￥%.2f(已抵%@黄券)",[order_price floatValue] - [pay_tickets floatValue],pay_tickets];
                        footer.order_price.text = [NSString stringWithFormat:@"￥%.2f(已抵%@黄券)",self.RealPayMoney,pay_tickets];
                    }
                    if ([ticket_color integerValue] == 3) {
//                        footer.order_price.text = [NSString stringWithFormat:@"￥%.2f(已抵%@蓝券)",[order_price floatValue] - [pay_tickets floatValue],pay_tickets];
                        footer.order_price.text = [NSString stringWithFormat:@"￥%.2f(已抵%@蓝券)",self.RealPayMoney,pay_tickets];
                    }
                    
                } else {
                    footer.order_price.text = [NSString stringWithFormat:@"￥%@",order_price];
                    /*
                     *实际付款金额
                     */
                    self.RealPayMoney = [order_price floatValue];
                }
            }
            
        }
        return footer;
    }
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    footer.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([_order_type isEqualToString:@"比价购"] || [_order_type isEqualToString:@"比价购纪录"]) {
            return 100;
        } else {
            if ([_order_type isEqualToString:@"普通商品"]) {
                SOrderDetails * details = arr[indexPath.row];
                NSInteger list_height = 300;
                if ([details.is_invoice integerValue] == 0) {
                    list_height -= 50;
                }
                if ([details.after_sale_status integerValue] == 0) {
                    list_height -= 50;
                }
                if ([details.integrity_a isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_b isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_c isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_d isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([order_status isEqualToString:@"0"] || [order_status isEqualToString:@"5"] || [order_status isEqualToString:@"1"]||[order_status isEqualToString:@"2"]) {
                    return 150 + list_height;
                }
                else {
                    //是否存在售后（0->不存在，1->存在）
                    if ([details.is_back_apply isEqualToString:@"1"]) {
                        return 150 + list_height;
                    } else {
                        return 100 + list_height;
                    }
                }
                
                return list_height;
            } else if ([_order_type isEqualToString:@"拼单购"]){
                SGroupBuyOrderDetails * details = arr[indexPath.row];
                NSInteger list_height = 300;
                if ([order_status isEqualToString:@"7"] || [order_status isEqualToString:@"8"] || [order_status isEqualToString:@"10"]) {
                    return 100;
                }
                if ([details.is_invoice integerValue] == 0) {
                    list_height -= 50;
                }
                if ([details.after_sale_status integerValue] == 0) {
                    list_height -= 50;
                }
                if ([details.integrity_a isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_b isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_c isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_d isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([order_status isEqualToString:@"0"] || [order_status isEqualToString:@"5"]) {
                    return 150 + list_height;
                } else {
                   return 150 + list_height;
                }
            } else if ([_order_type isEqualToString:@"无界商店"])
            {
                SIntegralBuyOrderDetails * details = arr[indexPath.row];
                NSInteger list_height = 300;
                if ([details.is_invoice integerValue] == 0) {
                    list_height -= 50;
                }
                if ([details.after_sale_status integerValue] == 0) {
                    list_height -= 50;
                }
                if ([details.integrity_a isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_b isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_c isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_d isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([order_status isEqualToString:@"0"] || [order_status isEqualToString:@"5"]) {
                    //2待支付 3已取消 会留白
                    return 100 + list_height;

                }
                else
                {
                    //是否存在售后（0->不存在，1->存在）
                    if ([details.is_back_apply isEqualToString:@"1"]) {
                        return 150 + list_height;
                    } else {
                        //1已提醒发货 并且没有 申请售后时    会留白
                        if (([details.remind_status isEqualToString:@"1"] && [details.status isEqualToString:@"0"])) {
                            return 100 + list_height;
                        }
                        return 150 + list_height;}
                }

            }
            else if ([_order_type isEqualToString:@"赠品专区"])
            {
                SgiftOderDetailModel * details = arr[indexPath.row];
                NSInteger list_height = 300;
                if ([details.is_invoice integerValue] == 0) {
                    list_height -= 50;
                }
                if ([details.after_sale_status integerValue] == 0) {
                    list_height -= 50;
                }
                if ([details.integrity_a isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_b isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_c isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([details.integrity_d isEqualToString:@""]) {
                    list_height -= 50;
                }
                if ([order_status isEqualToString:@"0"] || [order_status isEqualToString:@"5"]) {
                    //2待支付 3已取消 会留白
                    return 100 + list_height;
                    
                }
                else
                {
                    //是否存在售后（0->不存在，1->存在）
                    if ([details.is_back_apply isEqualToString:@"1"]) {
                        return 150 + list_height;
                    } else {
                        //1已提醒发货 并且没有 申请售后时    会留白
                        if (([details.remind_status isEqualToString:@"1"] && [details.status isEqualToString:@"0"])) {
                            return 100 + list_height;
                        }
                        return 150 + list_height;}
                }
                
            }
            
            else {
                return 150 + 150;
            }
            
        }
    } else if (indexPath.section == 1) {
        return 180;
    }
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SOrderInforCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SOrderInforCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([_order_type isEqualToString:@"普通商品"]) {
            SOrderDetails * details = arr[indexPath.row];
            
            [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:details.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            cell.goods_name.text = details.goods_name;
            cell.shop_price.text = [NSString stringWithFormat:@"￥%@",details.shop_price];
            
            if ([details.is_active isEqualToString:@"5"]) {
                cell.onTrialImageView.hidden = NO;
                cell.onTrialImageView.image=[UIImage imageNamed:@"爆款-flag"];
                CGAffineTransform transform= CGAffineTransformMakeRotation(-M_PI*0.2);
                /*关于M_PI
                 #define M_PI     3.14159265358979323846264338327950288
                 其实它就是圆周率的值，在这里代表弧度，相当于角度制 0-360 度，M_PI=180度
                 旋转方向为：顺时针旋转
                 
                 */
                 cell.onTrialImageView.transform = transform;//旋转
            }else{
                cell.onTrialImageView.hidden = YES;
            }
            if (_Is_2980) {
                 cell.view_2980.hidden=NO;
                 cell.attr.text = details.attr;
                cell.lab_flag.text=@"2980";
            }
            else  if ([details.is_active  intValue]==2) {
                 cell.view_2980.hidden=NO;
                 cell.lab_flag.text=@"399";
                if (details.return_integral == nil || [details.return_integral isEqualToString:@""]||[details.return_integral doubleValue]==0) {
                    cell.attr.text = details.attr;
                } else {
                    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",details.attr,details.return_integral]];
                    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(details.attr.length , 7 + details.return_integral.length)];
                    cell.attr.attributedText = AttributedStr;
                }
                
            }
            else  if ([details.is_active  intValue]==4) {
                     cell.view_2980.hidden=YES;
                    cell.attr.text = details.attr;
           
            }
            else
            {
                cell.view_2980.hidden=YES;
                if (details.return_integral == nil || [details.return_integral isEqualToString:@""]||[details.return_integral doubleValue]==0) {
                    cell.attr.text = details.attr;
                } else {
                    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",details.attr,details.return_integral]];
                    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(details.attr.length , 7 + details.return_integral.length)];
                    cell.attr.attributedText = AttributedStr;
                }
            }
            
            cell.goods_num.text = [NSString stringWithFormat:@"x%@",details.goods_num];
            cell.invoice_name.text = [NSString stringWithFormat:@"%@(发票运费:%@ 税金:%@)",details.invoice_name,details.express_fee,details.tax_pay];
            cell.after_sale_type.text = details.after_sale_type;
            cell.welfare.text = details.integrity_d;
            if ([details.is_invoice integerValue] == 0) {
                cell.oneView.hidden = YES;
                cell.oneView_HHH.constant = 0;
            } else {
                cell.oneView.hidden = NO;
                cell.oneView_HHH.constant = 50;
            }
            if ([details.after_sale_status integerValue] == 0) {
                cell.twoView.hidden = YES;
                cell.twoView_HHH.constant = 0;
            } else {
                cell.twoView.hidden = NO;
                cell.twoView_HHH.constant = 50;
            }
            
            //是否显示特殊描述
            if ([details.integrity_a isEqualToString:@""]) {
                cell.integrity_aView.hidden = YES;
                cell.integrity_aViewHHH.constant = 0;
            } else {
                cell.integrity_aView.hidden = NO;
                cell.integrity_aViewHHH.constant = 50;
                cell.integrity_a.text = details.integrity_a;
            }
            
            if ([details.integrity_b isEqualToString:@""]) {
                cell.integrity_bView.hidden = YES;
                cell.integrity_bView_HHH.constant = 0;
            } else {
                cell.integrity_bView.hidden = NO;
                cell.integrity_bView_HHH.constant = 50;
                cell.integrity_b.text = details.integrity_b;
            }
            
           if ([details.integrity_c isEqualToString:@""]) {
                cell.integrity_cView.hidden = YES;
                cell.integrity_cView_HHH.constant = 0;
            } else {
                cell.integrity_cView.hidden = NO;
                cell.integrity_cView_HHH.constant = 50;
                cell.integrity_c.text = details.integrity_c;
         }
            if ([details.integrity_d isEqualToString:@""]) {
                cell.threeView.hidden = YES;
                cell.threeView_HHH.constant = 0;
            } else {
                cell.threeView.hidden = NO;
                cell.threeView_HHH.constant = 50;
            }
            //是否显示收货按钮
            if ([order_status isEqualToString:@"1"]) {
                cell.againBtn.hidden = YES;

                if ([details.remind_status integerValue] == 0 && [details.after_type isEqualToString:@"0"] && [details.status integerValue] == 0) {
                    [cell.comeBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
                    cell.comeBtn.hidden = NO;
                } else {
                    cell.comeBtn.hidden = YES;
                }
            } else if ([order_status isEqualToString:@"2"]) {
                //此商品是否收货
                if ([details.after_type isEqualToString:@"0"]) {
                    cell.comeBtn.hidden = NO;
                    if ([details.status integerValue] == 1) {
                        [cell.comeBtn setTitle:@"已收货" forState:UIControlStateNormal];
                    } else {
                        [cell.comeBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                    }
                    
                    //是否已延长收货（0->否，1->是）
                    if ([details.sale_status isEqualToString:@"0"] && [details.after_type isEqualToString:@"0"] && [details.status integerValue] == 2) {
                        if ([details.status integerValue] == 1) {
                            cell.againBtn.hidden = YES;
                        } else {
                            cell.againBtn.hidden = NO;
                        }
                    } else {
                        cell.againBtn.hidden = YES;
                    }
                    
                } else {
                    cell.comeBtn.hidden = YES;
                    cell.againBtn.hidden = YES;
                }
            } else {
                cell.comeBtn.hidden = YES;
                cell.againBtn.hidden = YES;
            }
            NSLog(@"details.is_active %@",details.is_active);
            if ([order_status isEqualToString:@"0"] || [order_status isEqualToString:@"5"]) {
                cell.submitBtn.hidden = YES;
            } else {
                cell.submitBtn.hidden = NO;
                if ([details.after_type isEqualToString:@"0"]) {
                
                    [cell.submitBtn setTitle:@"申请售后" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"1"]) {
                    [cell.submitBtn setTitle:@"售后中" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"2"]) {
                    [cell.submitBtn setTitle:@"售后成功" forState:UIControlStateNormal];
                    if ([details.is_back_money integerValue] == 0) {
                        //是否显示收货按钮
                        if ([order_status isEqualToString:@"1"]) {
                            cell.againBtn.hidden = YES;
                            if ([details.remind_status integerValue] == 0) {
                                cell.comeBtn.hidden = NO;
                            } else {
                                cell.comeBtn.hidden = YES;
                            }
                        } else if ([order_status isEqualToString:@"2"]) {
                            //此商品是否收货
                            cell.comeBtn.hidden = NO;
                            //是否已延长收货（0->否，1->是）
                            if ([details.sale_status isEqualToString:@"0"] && [details.after_type isEqualToString:@"0"] && [details.status integerValue] == 2) {
                                if ([details.status integerValue] == 1) {
                                    cell.againBtn.hidden = YES;
                                } else {
                                    cell.againBtn.hidden = NO;
                                }
                            } else {
                                cell.againBtn.hidden = YES;
                            }
                        } else {
                            cell.comeBtn.hidden = YES;
                            cell.againBtn.hidden = YES;
                        }
                    } else {
                        cell.againBtn.hidden = YES;
                        cell.comeBtn.hidden = YES;
                    }
                } else if ([details.after_type isEqualToString:@"3"]) {
                    [cell.submitBtn setTitle:@"拒绝售后" forState:UIControlStateNormal];
                }
            }
            cell.timeCon.text = details.auto_time;
            
            //集碎片 2980 隐藏售后
         
            if (_Is_2980 ||[details.is_active isEqualToString:@"4"] ) {
                cell.submitBtn.hidden = YES;
                cell.comeBtn_WWW.constant = 10;
            }
            else
            {   //是否存在售后（0->不存在，1->存在）
                if ([details.is_back_apply isEqualToString:@"1"]) {
                    cell.submitBtn.hidden = NO;
                    cell.comeBtn_WWW.constant = 100;
                } else {
                    cell.submitBtn.hidden = YES;
                    cell.comeBtn_WWW.constant = 10;
                }
            }
        } else if ([_order_type isEqualToString:@"拼单购"]) {
            SGroupBuyOrderDetails * details = arr[indexPath.row];
            
            /*
             *订单详情页内,体验商品显示抽奖的提示图标
             */
            if ([details.group_type isEqualToString:@"1"]) {
                cell.onTrialImageView.hidden = NO;
            }else{
                cell.onTrialImageView.hidden = YES;
            }
            
            [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:details.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            cell.goods_name.text = details.goods_name;
            cell.shop_price.text = [NSString stringWithFormat:@"￥%@",details.shop_price];
//            cell.attr.text = details.attr;
            //规格 + 赠送积分
            if (details.return_integral == nil || [details.return_integral isEqualToString:@""]||[details.return_integral doubleValue]==0) {
                cell.attr.text = details.attr;
            } else {
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",details.attr,details.return_integral]];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(details.attr.length , 7 + details.return_integral.length)];
                cell.attr.attributedText = AttributedStr;
            }
            
            cell.goods_num.text = [NSString stringWithFormat:@"x%@",details.goods_num];
            cell.invoice_name.text = [NSString stringWithFormat:@"%@(发票运费:%@ 税金:%@)",details.invoice_name,details.express_fee,details.tax_pay];
            cell.after_sale_type.text = details.after_sale_type;
            cell.welfare.text = details.integrity_d;
            
            //待抽奖 或 未中奖 或 未拼成
            if ([order_status isEqualToString:@"7"] || [order_status isEqualToString:@"8"] || [order_status isEqualToString:@"10"]) {
                cell.oneView.hidden = YES;
                cell.oneView_HHH.constant = 0;
                cell.twoView.hidden = YES;
                cell.twoView_HHH.constant = 0;
                cell.integrity_aView.hidden = YES;
                cell.integrity_aViewHHH.constant = 0;
                cell.integrity_bView.hidden = YES;
                cell.integrity_bView_HHH.constant = 0;
                cell.integrity_cView.hidden = YES;
                cell.integrity_cView_HHH.constant = 0;
                cell.threeView.hidden = YES;
                cell.threeView_HHH.constant = 0;
                cell.submitBtn.hidden = YES;
                cell.againBtn.hidden = YES;
                cell.comeBtn.hidden = YES;
                return cell;
            }
            
            if ([details.is_invoice integerValue] == 0) {
                cell.oneView.hidden = YES;
                cell.oneView_HHH.constant = 0;
            } else {
                cell.oneView.hidden = NO;
                cell.oneView_HHH.constant = 50;
            }
            if ([details.after_sale_status integerValue] == 0) {
                cell.twoView.hidden = YES;
                cell.twoView_HHH.constant = 0;
            } else {
                cell.twoView.hidden = NO;
                cell.twoView_HHH.constant = 50;
            }
            
            //是否显示特殊描述
            if ([details.integrity_a isEqualToString:@""]) {
                cell.integrity_aView.hidden = YES;
                cell.integrity_aViewHHH.constant = 0;
            } else {
                cell.integrity_aView.hidden = NO;
                cell.integrity_aViewHHH.constant = 50;
                cell.integrity_a.text = details.integrity_a;
            }
            
            if ([details.integrity_b isEqualToString:@""]) {
                cell.integrity_bView.hidden = YES;
                cell.integrity_bView_HHH.constant = 0;
            } else {
                cell.integrity_bView.hidden = NO;
                cell.integrity_bView_HHH.constant = 50;
                cell.integrity_b.text = details.integrity_b;
            }
            
            if ([details.integrity_c isEqualToString:@""]) {
                cell.integrity_cView.hidden = YES;
                cell.integrity_cView_HHH.constant = 0;
            } else {
                cell.integrity_cView.hidden = NO;
                cell.integrity_cView_HHH.constant = 50;
                cell.integrity_c.text = details.integrity_c;
            }
            if ([details.integrity_d isEqualToString:@""]) {
                cell.threeView.hidden = YES;
                cell.threeView_HHH.constant = 0;
            } else {
                cell.threeView.hidden = NO;
                cell.threeView_HHH.constant = 50;
            }
            if ([order_status isEqualToString:@"2"]) {
                if ([details.remind_status integerValue] == 0) {
                    [cell.comeBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
                    cell.comeBtn.hidden = NO;
                } else {
                    cell.comeBtn.hidden = YES;
                }
            } else if ([order_status isEqualToString:@"3"]) {
                //是否显示收货按钮
                cell.comeBtn.hidden = NO;
            } else {
                cell.comeBtn.hidden = YES;
            }
            
            if ([order_status isEqualToString:@"0"]) {
                cell.submitBtn.hidden = YES;
            } else {
                cell.submitBtn.hidden = NO;
                if ([details.after_type isEqualToString:@"0"]) {
                    [cell.submitBtn setTitle:@"申请售后" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"1"]) {
                    [cell.submitBtn setTitle:@"售后中" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"2"]) {
                    [cell.submitBtn setTitle:@"退款成功" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"3"]) {
                    [cell.submitBtn setTitle:@"拒绝售后" forState:UIControlStateNormal];
                }
            }
            cell.timeCon.text = details.auto_time;
            //是否已延长收货（0->否，1->是）
            if ([order_status isEqualToString:@"3"]) {
                if ([details.status integerValue] > 1) {
                    if ([details.sale_status isEqualToString:@"0"]) {
                        cell.againBtn.hidden = NO;
                    } else {
                        cell.againBtn.hidden = YES;
                    }
                } else {
                    cell.againBtn.hidden = YES;
                }
            } else {
                cell.againBtn.hidden = YES;
            }
            //是否存在售后（0->不存在，1->存在）
            if ([details.is_back_apply isEqualToString:@"1"]) {
                cell.submitBtn.hidden = NO;
                cell.comeBtn_WWW.constant = 100;
            } else {
                cell.submitBtn.hidden = YES;
                cell.comeBtn_WWW.constant = 10;
            }
            
            //已取消
            if ([order_status isEqualToString:@"6"] || [order_status isEqualToString:@"1"]) {
                cell.submitBtn.hidden = YES;
            }
            
            
            
        } else if ([_order_type isEqualToString:@"无界预购"]) {
            SPreOrderPreDetails * details = arr[indexPath.row];
            
            [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:details.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            cell.goods_name.text = details.goods_name;
            cell.shop_price.text = [NSString stringWithFormat:@"￥%@",details.shop_price];
            cell.attr.text = details.attr;
            cell.goods_num.text = [NSString stringWithFormat:@"x%@",details.goods_num];
            
            //是否显示收货按钮
            if ([order_status isEqualToString:@"3"]) {
                cell.comeBtn.hidden = NO;
            } else {
                cell.comeBtn.hidden = YES;
            }
            if ([order_status isEqualToString:@"0"]) {
                cell.submitBtn.hidden = YES;
            } else {
                cell.submitBtn.hidden = NO;
                if ([details.after_type isEqualToString:@"0"]) {
                    [cell.submitBtn setTitle:@"申请售后" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"1"]) {
                    [cell.submitBtn setTitle:@"售后中" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"2"]) {
                    [cell.submitBtn setTitle:@"退款成功" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"3"]) {
                    [cell.submitBtn setTitle:@"拒绝售后" forState:UIControlStateNormal];
                }
            }
            cell.timeCon.text = details.sure_delivery_time;
            //是否已延长收货（0->否，1->是）
            if ([details.sale_status isEqualToString:@"0"]) {
                cell.againBtn.hidden = NO;
            } else {
                cell.againBtn.hidden = YES;
            }
            //是否存在售后（0->不存在，1->存在）
            if ([details.after_sale_type isEqualToString:@"1"]) {
                cell.submitBtn.hidden = NO;
                cell.comeBtn_WWW.constant = 100;
            } else {
                cell.submitBtn.hidden = YES;
                cell.comeBtn_WWW.constant = 10;
            }
        } else if ([_order_type isEqualToString:@"比价购"]||[_order_type isEqualToString:@"比价购纪录"]) {
            SAuctionOrderPreDetails * details = arr[indexPath.row];
            
            [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:details.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            cell.goods_name.text = details.goods_name;
            cell.shop_price.hidden = YES;
//            cell.shop_price.text = [NSString stringWithFormat:@"￥%@",details.shop_price];
            cell.attr.text = details.attr;
//            cell.goods_num.text = [NSString stringWithFormat:@"x%@",details.goods_num];
            cell.submitBtn.hidden = YES;
            cell.goods_num.hidden = YES;
            
            //是否显示收货按钮
            if ([order_status isEqualToString:@"4"]) {
                cell.comeBtn.hidden = NO;
            } else {
                cell.comeBtn.hidden = YES;
            }
            cell.timeCon.text = details.sure_delivery_time;
            //是否已延长收货（0->否，1->是）
            if ([details.sale_status isEqualToString:@"0"]) {
                cell.againBtn.hidden = NO;
            } else {
                cell.againBtn.hidden = YES;
            }
            //是否存在售后（0->不存在，1->存在）
            if ([details.after_sale_type isEqualToString:@"1"]) {
                cell.submitBtn.hidden = NO;
                cell.comeBtn_WWW.constant = 100;
            } else {
                cell.submitBtn.hidden = YES;
                cell.comeBtn_WWW.constant = 10;
            }
        } else if ([_order_type isEqualToString:@"无界商店"]) {
            SIntegralBuyOrderDetails * details = arr[indexPath.row];
            
            [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:details.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
           
            cell.goods_name.text = details.goods_name;
            cell.shop_price.text = [NSString stringWithFormat:@"%@积分",details.use_integral];
            
            //规格 + 赠送积分
            if (details.return_integral == nil || [details.return_integral isEqualToString:@""]||[details.return_integral doubleValue]==0) {
                cell.attr.text = details.attr;
            } else {
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",details.attr,details.return_integral]];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(details.attr.length , 7 + details.return_integral.length)];
                cell.attr.attributedText = AttributedStr;
            }
            
            cell.goods_num.text = [NSString stringWithFormat:@"x%@",details.goods_num];
            cell.invoice_name.text = [NSString stringWithFormat:@"%@(发票运费:%@ 税金:%@)",details.invoice_name,details.express_fee,details.tax_pay];
            cell.after_sale_type.text = details.after_sale_type;
            cell.welfare.text = details.integrity_d;
            if ([details.is_invoice integerValue] == 0) {
                cell.oneView.hidden = YES;
                cell.oneView_HHH.constant = 0;
            } else {
                cell.oneView.hidden = NO;
                cell.oneView_HHH.constant = 50;
            }
            if ([details.after_sale_status integerValue] == 0) {
                cell.twoView.hidden = YES;
                cell.twoView_HHH.constant = 0;
            } else {
                cell.twoView.hidden = NO;
                cell.twoView_HHH.constant = 50;
            }
        //是否显示特殊描述
            if ([details.integrity_a isEqualToString:@""]) {
                cell.integrity_aView.hidden = YES;
                cell.integrity_aViewHHH.constant = 0;
            } else {
                cell.integrity_aView.hidden = NO;
                cell.integrity_aViewHHH.constant = 50;
                cell.integrity_a.text = details.integrity_a;
            }

            if ([details.integrity_b isEqualToString:@""]) {
                cell.integrity_bView.hidden = YES;
                cell.integrity_bView_HHH.constant = 0;
            } else {
                cell.integrity_bView.hidden = NO;
                cell.integrity_bView_HHH.constant = 50;
                cell.integrity_b.text = details.integrity_b;
            }

            if ([details.integrity_c isEqualToString:@""]) {
                cell.integrity_cView.hidden = YES;
                cell.integrity_cView_HHH.constant = 0;
            } else {
                cell.integrity_cView.hidden = NO;
                cell.integrity_cView_HHH.constant = 50;
                cell.integrity_c.text = details.integrity_c;
            }
            if ([details.integrity_d isEqualToString:@""]) {
                cell.threeView.hidden = YES;
                cell.threeView_HHH.constant = 0;
            } else {
                cell.threeView.hidden = NO;
                cell.threeView_HHH.constant = 50;
            }
            //是否显示收货按钮
            if ([order_status isEqualToString:@"1"]) {
                cell.againBtn.hidden = YES;
                
                if ([details.remind_status integerValue] == 0 && [details.after_type isEqualToString:@"0"] && [details.status integerValue] == 0) {
                    [cell.comeBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
                    cell.comeBtn.hidden = NO;
                } else {
                    cell.comeBtn.hidden = YES;
                }
            } else if ([order_status isEqualToString:@"2"]) {
                //此商品是否收货
                if ([details.after_type isEqualToString:@"0"]) {
                    cell.comeBtn.hidden = NO;
                    if ([details.status integerValue] == 1) {
                        [cell.comeBtn setTitle:@"已收货" forState:UIControlStateNormal];
                    } else {
                        [cell.comeBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                    }
                    
                    //是否已延长收货（0->否，1->是）
                    if ([details.sale_status isEqualToString:@"0"] && [details.after_type isEqualToString:@"0"] && [details.status integerValue] == 2) {
                        if ([details.status integerValue] == 1) {
                            cell.againBtn.hidden = YES;
                        } else {
                            cell.againBtn.hidden = NO;
                        }
                    } else {
                        cell.againBtn.hidden = YES;
                    }
                    
                } else {
                    cell.comeBtn.hidden = YES;
                    cell.againBtn.hidden = YES;
                }
            } else {
                cell.comeBtn.hidden = YES;
                cell.againBtn.hidden = YES;
            }
            if ([order_status isEqualToString:@"0"] || [order_status isEqualToString:@"5"]) {
                cell.submitBtn.hidden = YES;
            } else {
                cell.submitBtn.hidden = NO;
                if ([details.after_type isEqualToString:@"0"]) {
                    [cell.submitBtn setTitle:@"申请售后" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"1"]) {
                    [cell.submitBtn setTitle:@"售后中" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"2"]) {
                    [cell.submitBtn setTitle:@"售后成功" forState:UIControlStateNormal];
                    if ([details.is_back_money integerValue] == 0) {
                        //是否显示收货按钮
                        if ([order_status isEqualToString:@"1"]) {
                            cell.againBtn.hidden = YES;
                            if ([details.remind_status integerValue] == 0) {
                                cell.comeBtn.hidden = NO;
                            } else {
                                cell.comeBtn.hidden = YES;
                            }
                        } else if ([order_status isEqualToString:@"2"]) {
                            //此商品是否收货
                            cell.comeBtn.hidden = NO;
                            //是否已延长收货（0->否，1->是）
                            if ([details.sale_status isEqualToString:@"0"] && [details.after_type isEqualToString:@"0"] && [details.status integerValue] == 2) {
                                if ([details.status integerValue] == 1) {
                                    cell.againBtn.hidden = YES;
                                } else {
                                    cell.againBtn.hidden = NO;
                                }
                            } else {
                                cell.againBtn.hidden = YES;
                            }
                        } else {
                            cell.comeBtn.hidden = YES;
                            cell.againBtn.hidden = YES;
                        }
                    } else {
                        cell.againBtn.hidden = YES;
                        cell.comeBtn.hidden = YES;
                    }
                } else if ([details.after_type isEqualToString:@"3"]) {
                    [cell.submitBtn setTitle:@"拒绝售后" forState:UIControlStateNormal];
                }
            }
            cell.timeCon.text = details.auto_time;
           
         
            //是否存在售后（0->不存在，1->存在）
            if ([details.is_back_apply isEqualToString:@"1"]) {
                cell.submitBtn.hidden = NO;
                cell.comeBtn_WWW.constant = 100;
            } else {
                cell.submitBtn.hidden = YES;
                cell.comeBtn_WWW.constant = 10;
            }
                
          
            
            /*
            cell.attr.text = details.attr;
            cell.attr.hidden = YES;
            cell.goods_num.text = [NSString stringWithFormat:@"x%@",details.goods_num];
            cell.submitBtn.hidden = YES;
            //是否显示收货按钮
            if ([order_status isEqualToString:@"2"]) {
                cell.comeBtn.hidden = NO;
            } else {
                cell.comeBtn.hidden = YES;
            }
            
            cell.timeCon.text = details.sure_delivery_time;
            //是否已延长收货（0->否，1->是）
            if ([details.sale_status isEqualToString:@"0"]) {
                cell.againBtn.hidden = NO;
            } else {
                cell.againBtn.hidden = YES;
            }
            //是否存在售后（0->不存在，1->存在）
            if ([details.after_sale_type isEqualToString:@"1"]) {
                cell.submitBtn.hidden = NO;
                cell.comeBtn_WWW.constant = 100;
            } else {
                cell.submitBtn.hidden = YES;
                cell.comeBtn_WWW.constant = 10;
            }
             */
        }
        else if ([_order_type isEqualToString:@"赠品专区"])
        {
            SgiftOderDetailModel * details = arr[indexPath.row];
            
            [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:details.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            
            cell.goods_name.text = details.goods_name;
            cell.shop_price.text = [NSString stringWithFormat:@"%@赠品券",details.use_voucher];
            
            //规格 + 赠送积分
            if (details.return_integral == nil || [details.return_integral isEqualToString:@""]||[details.return_integral doubleValue]==0) {
                cell.attr.text = details.attr;
            } else {
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",details.attr,details.return_integral]];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(details.attr.length , 7 + details.return_integral.length)];
                cell.attr.attributedText = AttributedStr;
            }
            
            cell.goods_num.text = [NSString stringWithFormat:@"x%@",details.goods_num];
            cell.invoice_name.text = [NSString stringWithFormat:@"%@(发票运费:%@ 税金:%@)",details.invoice_name,details.express_fee,details.tax_pay];
            cell.after_sale_type.text = details.after_sale_type;
            cell.welfare.text = details.integrity_d;
            if ([details.is_invoice integerValue] == 0) {
                cell.oneView.hidden = YES;
                cell.oneView_HHH.constant = 0;
            } else {
                cell.oneView.hidden = NO;
                cell.oneView_HHH.constant = 50;
            }
            if ([details.after_sale_status integerValue] == 0) {
                cell.twoView.hidden = YES;
                cell.twoView_HHH.constant = 0;
            } else {
                cell.twoView.hidden = NO;
                cell.twoView_HHH.constant = 50;
            }
            //是否显示特殊描述
            if ([details.integrity_a isEqualToString:@""]) {
                cell.integrity_aView.hidden = YES;
                cell.integrity_aViewHHH.constant = 0;
            } else {
                cell.integrity_aView.hidden = NO;
                cell.integrity_aViewHHH.constant = 50;
                cell.integrity_a.text = details.integrity_a;
            }
            
            if ([details.integrity_b isEqualToString:@""]) {
                cell.integrity_bView.hidden = YES;
                cell.integrity_bView_HHH.constant = 0;
            } else {
                cell.integrity_bView.hidden = NO;
                cell.integrity_bView_HHH.constant = 50;
                cell.integrity_b.text = details.integrity_b;
            }
            
            if ([details.integrity_c isEqualToString:@""]) {
                cell.integrity_cView.hidden = YES;
                cell.integrity_cView_HHH.constant = 0;
            } else {
                cell.integrity_cView.hidden = NO;
                cell.integrity_cView_HHH.constant = 50;
                cell.integrity_c.text = details.integrity_c;
            }
            if ([details.integrity_d isEqualToString:@""]) {
                cell.threeView.hidden = YES;
                cell.threeView_HHH.constant = 0;
            } else {
                cell.threeView.hidden = NO;
                cell.threeView_HHH.constant = 50;
            }
            //是否显示收货按钮
            if ([order_status isEqualToString:@"1"]) {
                cell.againBtn.hidden = YES;
                
                if ([details.remind_status integerValue] == 0 && [details.after_type isEqualToString:@"0"] && [details.status integerValue] == 0) {
                    [cell.comeBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
                    cell.comeBtn.hidden = NO;
                } else {
                    cell.comeBtn.hidden = YES;
                }
            } else if ([order_status isEqualToString:@"2"]) {
                //此商品是否收货
                if ([details.after_type isEqualToString:@"0"]) {
                    cell.comeBtn.hidden = NO;
                    if ([details.status integerValue] == 1) {
                        [cell.comeBtn setTitle:@"已收货" forState:UIControlStateNormal];
                    } else {
                        [cell.comeBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                    }
                    
                    //是否已延长收货（0->否，1->是）
                    if ([details.sale_status isEqualToString:@"0"] && [details.after_type isEqualToString:@"0"] && [details.status integerValue] == 2) {
                        if ([details.status integerValue] == 1) {
                            cell.againBtn.hidden = YES;
                        } else {
                            cell.againBtn.hidden = NO;
                        }
                    } else {
                        cell.againBtn.hidden = YES;
                    }
                    
                } else {
                    cell.comeBtn.hidden = YES;
                    cell.againBtn.hidden = YES;
                }
            } else {
                cell.comeBtn.hidden = YES;
                cell.againBtn.hidden = YES;
            }
            if ([order_status isEqualToString:@"0"] || [order_status isEqualToString:@"5"]) {
                cell.submitBtn.hidden = YES;
            } else {
                cell.submitBtn.hidden = NO;
                if ([details.after_type isEqualToString:@"0"]) {
                    [cell.submitBtn setTitle:@"申请售后" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"1"]) {
                    [cell.submitBtn setTitle:@"售后中" forState:UIControlStateNormal];
                } else if ([details.after_type isEqualToString:@"2"]) {
                    [cell.submitBtn setTitle:@"售后成功" forState:UIControlStateNormal];
                    if ([details.is_back_apply integerValue] == 0) {
                        //是否显示收货按钮
                        if ([order_status isEqualToString:@"1"]) {
                            cell.againBtn.hidden = YES;
                            if ([details.remind_status integerValue] == 0) {
                                cell.comeBtn.hidden = NO;
                            } else {
                                cell.comeBtn.hidden = YES;
                            }
                        } else if ([order_status isEqualToString:@"2"]) {
                            //此商品是否收货
                            cell.comeBtn.hidden = NO;
                            //是否已延长收货（0->否，1->是）
                            if ([details.sale_status isEqualToString:@"0"] && [details.after_type isEqualToString:@"0"] && [details.status integerValue] == 2) {
                                if ([details.status integerValue] == 1) {
                                    cell.againBtn.hidden = YES;
                                } else {
                                    cell.againBtn.hidden = NO;
                                }
                            } else {
                                cell.againBtn.hidden = YES;
                            }
                        } else {
                            cell.comeBtn.hidden = YES;
                            cell.againBtn.hidden = YES;
                        }
                    } else {
                        cell.againBtn.hidden = YES;
                        cell.comeBtn.hidden = YES;
                    }
                } else if ([details.after_type isEqualToString:@"3"]) {
                    [cell.submitBtn setTitle:@"拒绝售后" forState:UIControlStateNormal];
                }
            }
            cell.timeCon.text = details.auto_time;
            
            
            //是否存在售后（0->不存在，1->存在）
            if ([details.is_back_apply isEqualToString:@"1"]) {
                cell.submitBtn.hidden = NO;
                cell.comeBtn_WWW.constant = 100;
            } else {
                cell.submitBtn.hidden = YES;
                cell.comeBtn_WWW.constant = 10;
            }
            
            
        }
        
        [cell.submitBtn setTag:indexPath.row];
        [cell.submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.comeBtn setTag:indexPath.row];
        [cell.comeBtn addTarget:self action:@selector(comeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.againBtn setTag:indexPath.row];
        [cell.againBtn addTarget:self action:@selector(againBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else if (indexPath.section == 1) {
        SOrderInforCell_sub * cell = [tableView dequeueReusableCellWithIdentifier:@"SOrderInforCell_sub" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.topView_HHH.constant = 70;
            cell.top_senTitle.hidden = YES;
            cell.top_senPrice.hidden = YES;
            cell.downTitle.hidden = NO;
            cell.downTitle_HHH.constant = 30;
            cell.endTitle.hidden = NO;
            cell.end.hidden = NO;
            if ([order_status isEqualToString:@"0"]) {
                cell.pre_status.text = @"阶段1:未完成";
            } else if ([order_status isEqualToString:@"7"]) {
                cell.pre_status.text = @"阶段1:未完成";
            } else {
                cell.pre_status.text = @"阶段1:已完成";
            }
            cell.start.text = [NSString stringWithFormat:@"￥%@",start];
            cell.start_top_title.text = @"商品定金";
            cell.start_title.text = @"天猫积分";
            cell.start_integral.textColor = WordColor;
            cell.start_integral.text = [NSString stringWithFormat:@"-￥%@",start_integral == nil ? @"0.00" : start_integral];
            cell.end.text = [NSString stringWithFormat:@"￥%.2f",[start floatValue] - [start_integral floatValue]];
        } else {
            cell.topView_HHH.constant = 110;
            cell.top_senTitle.hidden = NO;
            cell.top_senPrice.hidden = NO;
            cell.start.text = [NSString stringWithFormat:@"￥%@",end];
            cell.top_senPrice.text = [NSString stringWithFormat:@"-￥%@",final_integral];
            cell.downTitle.hidden = YES;
            cell.downTitle_HHH.constant = 15;
            cell.endTitle.hidden = YES;
            cell.end.hidden = YES;
            if ([order_status isEqualToString:@"1"]) {
                cell.pre_status.text = @"阶段2:未完成";
            } else {
                cell.pre_status.text = @"阶段2:已完成";
            }
            cell.start_top_title.text = @"商品尾款";
            cell.start_title.text = @"尾款实付款";
            cell.start_integral.text = [NSString stringWithFormat:@"￥%.2f",[end floatValue] - [final_integral floatValue]];
            cell.start_integral.textColor = [UIColor redColor];
        }

        return cell;
    }
    SOrderInforCell_sub_sub * cell = [tableView dequeueReusableCellWithIdentifier:@"SOrderInforCell_sub_sub" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.thisTitle.text = crr[indexPath.row];
    
    return cell;
    
}
#pragma mark - 商品详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_order_type isEqualToString:@"普通商品"]) {
   
            SOrderDetails * details = arr[indexPath.row];
            SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
            info.goods_id = details.goods_id;
            info.overType = NULL;
            info.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info animated:YES];
    }
    
    if ([_order_type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderDetails * details = arr[indexPath.row];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = details.group_buy_id;
        info.overType = @"拼单购";
        info.a_id = details.a_id;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    }
    
    /*
     *无界商店商品详情的跳转
     */
    if ([_order_type isEqualToString:@"无界商店"]) {
        SIntegralBuyOrderDetails * details = arr[indexPath.row];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = details.integralBuy_id;
        info.overType = @"无界商店";
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    }
    
    if ([_order_type isEqualToString:@"赠品专区"]) {
       
            SgiftOderDetailModel * details = arr[indexPath.row];
            SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
            info.gift_goods_id = details.gift_goods_id;
            info.overType = @"赠品专区";
            info.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info animated:YES];
       
        
    }
    
}
- (void)submitBtnClick:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"申请售后"]) {
        //申请售后
        GCustomerService * cs = [[GCustomerService alloc] init];
        if ([_order_type isEqualToString:@"普通商品"] || [_order_type isEqualToString:@"无界商店"]) {
            SOrderDetails * details = arr[btn.tag];
//            cs.thisMoney_num = details.goods_num;
            if([_order_type isEqualToString:@"无界商店"]){
                cs.order_type = @"5";
                cs.thisMoney = @"0";
//                cs.order_goods_id = ((SIntegralBuyOrderDetails *)details).integralBuy_id;
                cs.order_goods_id = ((SIntegralBuyOrderDetails *)details).order_goods_id;
            }else{
                cs.thisMoney = details.refund_price;
                cs.order_type = @"1";
                cs.order_goods_id = details.order_goods_id;
            }
        } else if ([_order_type isEqualToString:@"拼单购"]) {
            SGroupBuyOrderDetails * details = arr[btn.tag];
//            cs.thisMoney = details.shop_price;
            /*
             *实际付款金额
             */
            cs.thisMoney = details.refund_price;
            cs.thisMoney_num = details.goods_num;
            cs.order_type = @"2";
            cs.order_goods_id = details.order_goods_id;
        } else if ([_order_type isEqualToString:@"无界预购"]) {
            SPreOrderPreDetails * details = arr[btn.tag];
            cs.thisMoney = details.shop_price;
            cs.thisMoney_num = details.goods_num;
            cs.order_type = @"3";
            cs.order_goods_id = details.order_goods_id;
        }
        cs.order_id = _order_id;
        cs.inforBlock = self;
        [self.navigationController pushViewController:cs animated:YES];
    } else {
        //售后流程
        CustomerServiceInfor * csInfor = [[CustomerServiceInfor alloc] init];
        if ([_order_type isEqualToString:@"普通商品"] || [_order_type isEqualToString:@"无界商店"]) {
            SOrderDetails * details = arr[btn.tag];
            csInfor.order_goods_id = details.order_goods_id;
            csInfor.back_apply_id = details.back_apply_id;
            if ([details.is_sales isEqualToString:@"1"]) {
                csInfor.is_sales = @"1";
            } else {
                csInfor.is_sales = @"0";
            }
            csInfor.after_type = details.after_type;
            
            if([_order_type isEqualToString:@"无界商店"]){
                csInfor.refund_price = @"0";
            }else{
                csInfor.refund_price = details.refund_price;
            }
        } else if ([_order_type isEqualToString:@"拼单购"]) {
            SGroupBuyOrderDetails * details = arr[btn.tag];
            csInfor.order_goods_id = details.order_goods_id;
            csInfor.back_apply_id = details.back_apply_id;
            if ([details.is_sales isEqualToString:@"1"]) {
                csInfor.is_sales = @"1";
            } else {
                csInfor.is_sales = @"0";
            }
            csInfor.after_type = details.after_type;
            /*
             *售后金额
             */
            csInfor.refund_price = details.refund_price;
        } else if ([_order_type isEqualToString:@"无界预购"]) {
            SPreOrderPreDetails * details = arr[btn.tag];
            csInfor.order_goods_id = details.order_goods_id;
            csInfor.back_apply_id = details.back_apply_id;
            if ([details.is_sales isEqualToString:@"1"]) {
                csInfor.is_sales = @"1";
            } else {
                csInfor.is_sales = @"0";
            }
            csInfor.after_type = details.after_type;
        }
        csInfor.order_id = _order_id;
        csInfor.inforBlock = self;
        csInfor.order_type = _order_type;
        [self.navigationController pushViewController:csInfor animated:YES];
    }
}
- (IBAction)oneBtn:(UIButton *)sender {
    
 
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消订单?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        if ([_order_type isEqualToString:@"普通商品"]) {
            //普通商品取消订单
            SOrderCancelOrder * cancel_order = [[SOrderCancelOrder alloc] init];
            cancel_order.order_id = _order_id;
            cancel_order.order_type = _order_type;
            [MBProgressHUD showMessage:nil toView:self.view];
            [cancel_order sOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
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
        } else if ([_order_type isEqualToString:@"拼单购"]) {
            //拼单购取消订单
            SGroupBuyOrderCancelOrder * cancel_order = [[SGroupBuyOrderCancelOrder alloc] init];
            cancel_order.group_buy_order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [cancel_order sGroupBuyOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
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
        } else if ([_order_type isEqualToString:@"无界预购"]) {
            //无界预购取消订单
            SPreOrderPreCancelOrder * cancel_order = [[SPreOrderPreCancelOrder alloc] init];
            cancel_order.order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [cancel_order sPreOrderPreCancelOrderSuccess:^(NSString *code, NSString *message) {
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
        } else if ([_order_type isEqualToString:@"比价购"]) {
            //比价购取消订单
            SAuctionOrderCancelOrder * cancel_order = [[SAuctionOrderCancelOrder alloc] init];
            cancel_order.order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [cancel_order sAuctionOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
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
        } else if ([_order_type isEqualToString:@"无界商店"]) {
            //无界商店取消订单
            SIntegralBuyOrderCancelOrder * cancel_order = [[SIntegralBuyOrderCancelOrder alloc] init];
            cancel_order.order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [cancel_order sIntegralBuyOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
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
        }
        else if ([_order_type isEqualToString:@"赠品专区"]) {
            
            SgiftCancelOrderModel * cancel_order = [[SgiftCancelOrderModel alloc] init];
            cancel_order.order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [cancel_order SgiftCancelOrderModelSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"200"]) {
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
        }
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)twoBtn:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"付款"]) {
        SPay * pay = [[SPay alloc] init];
        if ([_order_type isEqualToString:@"普通商品"]) {
            pay.model_type = @"普通商品";
            pay.order_id = _order_id;
            if (_Is_2980) {
                pay.is_active=@"3";
            }
            pay.IsInShop=_IsInShop;
            pay.IsSuiPian=_IsSuiPian;
          
        }
        if ([_order_type isEqualToString:@"拼单购"]) {
            pay.model_type = @"拼单购";
            pay.group_buy_id = model_group_buy_id;
            pay.group_buy_order_id = _order_id;
            pay.special_type_sub = @"4";
            pay.order_id = _order_id;
            //为了不让goods为空造成crash 添加以下代码
            NSMutableDictionary *goodsDic = [NSMutableDictionary dictionary];
            NSMutableArray *goodsArr = [NSMutableArray array];
            [goodsDic setValue:model_freight forKey:@"pay"];
            [goodsDic setValue:@"" forKey:@"send_company"];
            [goodsArr addObject:goodsDic];
            pay.goods = [goodsArr mj_JSONString];
        }
        if ([_order_type isEqualToString:@"无界预购"]) {
            pay.model_type = @"无界预购";
            pay.order_id = _order_id;
        }
        if ([_order_type isEqualToString:@"比价购"]) {
            pay.model_type = @"比价购";
            if ([model_buy_type isEqualToString:@"1"]) {
                //竞拍
                SOrderConfirm * com = [[SOrderConfirm alloc] init];
                com.order_id = _order_id;
                [self.navigationController pushViewController:com animated:YES];
                return ;
            } else {
                //一口价
                pay.auction_isno = YES;
            }
            pay.order_id = _order_id;
        }
        if ([_order_type isEqualToString:@"无界商店"]) {
            pay.model_type = @"无界商店";
            pay.order_id = _order_id;
            //为了不让goods为空造成crash 添加以下代码
            NSMutableDictionary *goodsDic = [NSMutableDictionary dictionary];
            NSMutableArray *goodsArr = [NSMutableArray array];
            [goodsDic setValue:model_freight forKey:@"pay"];
            [goodsDic setValue:@"" forKey:@"send_company"];
            [goodsArr addObject:goodsDic];
            pay.goods = [goodsArr mj_JSONString];
        }
        if ([_order_type isEqualToString:@"赠品专区"]) {
            pay.model_type = @"赠品专区";
            pay.order_id = _order_id;
            //为了不让goods为空造成crash 添加以下代码
            NSMutableDictionary *goodsDic = [NSMutableDictionary dictionary];
            NSMutableArray *goodsArr = [NSMutableArray array];
            [goodsDic setValue:model_freight forKey:@"pay"];
            [goodsDic setValue:@"" forKey:@"send_company"];
            [goodsArr addObject:goodsDic];
            pay.goods = [goodsArr mj_JSONString];
        }
        [self.navigationController pushViewController:pay animated:YES];
    } else if ([sender.titleLabel.text isEqualToString:@"确认收货"]) {
        if ([_order_type isEqualToString:@"普通商品"]) {
            SPay_Pass * pass = [[SPay_Pass alloc] init];
            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:pass animated:YES completion:nil];
            pass.SPay_Pass_back = ^{
                //普通商品确认收货
                SOrderReceiving * receiving = [[SOrderReceiving alloc] init];
                receiving.order_id = _order_id;
                [MBProgressHUD showMessage:nil toView:self.view];
                [receiving sOrderReceivingSuccess:^(NSString *code, NSString *message) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if ([code isEqualToString:@"1"]) {
                        [MBProgressHUD showSuccess:message toView:self.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self showModel];
                        });
                    } else {
                        [MBProgressHUD showError:message toView:self.view];
                    }
                } andFailure:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                }];
            };
            
        } else if ([_order_type isEqualToString:@"拼单购"]) {
            //拼单购确认收货
            SGroupBuyOrderReceiving * receiving = [[SGroupBuyOrderReceiving alloc] init];
            receiving.group_buy_order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [receiving sGroupBuyOrderReceivingSuccess:^(NSString *code, NSString *message) {
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
        } else if ([_order_type isEqualToString:@"无界预购"]) {
            //无界预购确认收货
            SPreOrderPreReceiving * receiving = [[SPreOrderPreReceiving alloc] init];
            receiving.order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [receiving sPreOrderPreReceivingSuccess:^(NSString *code, NSString *message) {
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
        } else if ([_order_type isEqualToString:@"比价购"]) {
            //比价购确认收货
            SAuctionOrderReceiving * receiving = [[SAuctionOrderReceiving alloc] init];
            receiving.order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [receiving sAuctionOrderReceivingSuccess:^(NSString *code, NSString *message) {
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
        } else if ([_order_type isEqualToString:@"无界商店"]) {
            //无界商店确认收货
            SIntegralBuyOrderReceiving * receiving = [[SIntegralBuyOrderReceiving alloc] init];
            receiving.order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [receiving sIntegralBuyOrderReceivingSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
        else if ([_order_type isEqualToString:@"赠品专区"])
        {
            
            SgiftOderReceivingModel * receiving = [[SgiftOderReceivingModel alloc] init];
            receiving.order_id = _order_id;
            receiving.status=@"1";
            [MBProgressHUD showMessage:nil toView:self.view];
            [receiving SgiftOderReceivingModelSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"200"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
    } else if ([sender.titleLabel.text isEqualToString:@"评价"]) {
        SEvaSubmit * evaSubmit = [[SEvaSubmit alloc] init];
        if ([_order_type isEqualToString:@"普通商品"]) {
            if (_IsSuiPian) {
                  evaSubmit.order_type = @"集碎片";
            }
            else
            {
                evaSubmit.order_type = @"普通商品";
            }
        } else if ([_order_type isEqualToString:@"拼单购"]) {
            evaSubmit.order_type = @"拼单购";
        } else if ([_order_type isEqualToString:@"无界预购"]) {
            evaSubmit.order_type = @"无界预购";
        } else if ([_order_type isEqualToString:@"比价购"]) {
            evaSubmit.order_type = @"比价购";
        } else if ([_order_type isEqualToString:@"无界商店"]) {
            evaSubmit.order_type = @"无界商店";
        }
       
        evaSubmit.order_id = _order_id;
        [self.navigationController pushViewController:evaSubmit animated:YES];
    } else if ([sender.titleLabel.text isEqualToString:@"删除订单"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除订单?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确定");
            if ([_order_type isEqualToString:@"普通商品"]) {
                //普通商品删除订单
                SOrderDeleteOrder * cancel_order = [[SOrderDeleteOrder alloc] init];
                cancel_order.order_id = _order_id;
                [MBProgressHUD showMessage:nil toView:self.view];
                [cancel_order sOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
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
            } else if ([_order_type isEqualToString:@"拼单购"]) {
                //拼单购删除订单
                SGroupBuyOrderDeleteOrder * cancel_order = [[SGroupBuyOrderDeleteOrder alloc] init];
                cancel_order.group_buy_order_id = _order_id;
                [MBProgressHUD showMessage:nil toView:self.view];
                [cancel_order sGroupBuyOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
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
            } else if ([_order_type isEqualToString:@"无界预购"]) {
                //无界预购删除订单
                SPreOrderPreDeleteOrder * cancel_order = [[SPreOrderPreDeleteOrder alloc] init];
                cancel_order.order_id = _order_id;
                [MBProgressHUD showMessage:nil toView:self.view];
                [cancel_order sPreOrderPreDeleteOrderSuccess:^(NSString *code, NSString *message) {
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
            } else if ([_order_type isEqualToString:@"比价购"]) {
                //比价购删除订单
                SAuctionOrderDeleteOrder * cancel_order = [[SAuctionOrderDeleteOrder alloc] init];
                cancel_order.order_id = _order_id;
                [MBProgressHUD showMessage:nil toView:self.view];
                [cancel_order sAuctionOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
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
            } else if ([_order_type isEqualToString:@"无界商店"]) {
                //无界商店删除订单
                SIntegralBuyOrderDeleteOrder * cancel_order = [[SIntegralBuyOrderDeleteOrder alloc] init];
                cancel_order.order_id = _order_id;
                [MBProgressHUD showMessage:nil toView:self.view];
                [cancel_order sIntegralBuyOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
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
            }
            else if ([_order_type isEqualToString:@"赠品专区"]) {
                //无界商店删除订单
                SgiftDeleteOder * cancel_order = [[SgiftDeleteOder alloc] init];
                cancel_order.order_id = _order_id;
                [MBProgressHUD showMessage:nil toView:self.view];
                [cancel_order SgiftDeleteOderModelSuccess:^(NSString *code, NSString *message) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if ([code isEqualToString:@"200"]) {
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
            }
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}
#pragma mark - 确认收货
- (void)comeBtnClick:(UIButton *)btn {
    if ([_order_type isEqualToString:@"普通商品"] || [_order_type isEqualToString:@"无界商店"]) {
        SOrderDetails * details = arr[btn.tag];
        if ([btn.titleLabel.text isEqualToString:@"已收货"] || [btn.titleLabel.text isEqualToString:@"确认收货"]) {
            if ([details.status integerValue] == 1) {
                [MBProgressHUD showError:@"此商品已收货" toView:self.view];
                return;
            }
            SPay_Pass * pass = [[SPay_Pass alloc] init];
            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:pass animated:YES completion:nil];
            pass.SPay_Pass_back = ^{
                //是否存在七天无理由退换货（0->不存在，1->存在）
                if ([details.sure_status isEqualToString:@"0"]) {
                    SOrderReceiving * receiving = [[SOrderReceiving alloc] init];
                    receiving.order_id = _order_id;
                    receiving.order_goods_id = details.order_goods_id;
                    receiving.status = @"";//2->七天后收货，1->现在收货
                    if([_order_type isEqualToString:@"无界商店"]){
                        receiving.orderType = _order_type;
                    }else{
                        receiving.order_goods_id = details.order_goods_id;
                    }
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [receiving sOrderReceivingSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                } else {
                    SOrderInfor_Come * come = [[SOrderInfor_Come alloc] init];
                    come.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    come.modalPresentationStyle = UIModalPresentationOverFullScreen;
                    [self.navigationController presentViewController:come animated:YES completion:nil];
                    come.server.text = details.server;
                    come.server_else.text = details.server_else;
                    come.SOrderInfor_Come_choice = ^(NSString *type) {
                        SOrderReceiving * receiving = [[SOrderReceiving alloc] init];
                        
                        if([_order_type isEqualToString:@"无界商店"]){
                            receiving.orderType = _order_type;
                        }else{
                             receiving.order_goods_id = details.order_goods_id;
                        }
                        receiving.order_id = _order_id;
                       
                        if ([type isEqualToString:@"1"]) {
                            receiving.status = @"1";//2->放弃，1->确认
                        }
                        if ([type isEqualToString:@"2"]) {
                            receiving.status = @"2";//2->放弃，1->确认
                        }
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [receiving sOrderReceivingSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [self showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    };
                }
            };
            
        } else {
            //提醒发货
            SOrderRemind * remind = [[SOrderRemind alloc] init];
            remind.orderType = _order_type;
            
            if([_order_type isEqualToString:@"无界商店"]){
                remind.order_id = _order_id;
            }else{
                remind.order_goods_id = details.order_goods_id;
            }
            [MBProgressHUD showMessage:nil toView:self.view];
            [remind sOrderRemindSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self showModel];
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
    }
    
    
    if ([_order_type isEqualToString:@"拼单购"]) {
        SOrderDetails * details = arr[btn.tag];
        if ([btn.titleLabel.text isEqualToString:@"已收货"] || [btn.titleLabel.text isEqualToString:@"确认收货"]) {
            if ([details.status integerValue] == 1) {
                [MBProgressHUD showError:@"此商品已收货" toView:self.view];
                return;
            }
            SPay_Pass * pass = [[SPay_Pass alloc] init];
            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:pass animated:YES completion:nil];
            pass.SPay_Pass_back = ^{
                //是否存在七天无理由退换货（0->不存在，1->存在）
                if ([details.sure_status isEqualToString:@"0"]) {
                    //拼单购确认收货
                    SGroupBuyOrderReceiving * receiving = [[SGroupBuyOrderReceiving alloc] init];
                    receiving.group_buy_order_id = _order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [receiving sGroupBuyOrderReceivingSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                    
                } else {
                    SOrderInfor_Come * come = [[SOrderInfor_Come alloc] init];
                    come.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    come.modalPresentationStyle = UIModalPresentationOverFullScreen;
                    [self.navigationController presentViewController:come animated:YES completion:nil];
                    come.server.text = details.server;
                    come.server_else.text = details.server_else;
                    come.SOrderInfor_Come_choice = ^(NSString *type) {
                        //拼单购确认收货
                        SGroupBuyOrderReceiving * receiving = [[SGroupBuyOrderReceiving alloc] init];
                        receiving.group_buy_order_id = _order_id;
                        if ([type isEqualToString:@"1"]) {
                            receiving.status = @"1";//2->放弃，1->确认
                        }
                        if ([type isEqualToString:@"2"]) {
                            receiving.status = @"2";//2->放弃，1->确认
                        }
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [receiving sGroupBuyOrderReceivingSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [self showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    };
                    
                    
                }
            };
            
        } else {
            //提醒发货
            SOrderRemind * remind = [[SOrderRemind alloc] init];
            remind.orderType = _order_type;
            remind.group_buy_order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [remind sOrderRemindSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self showModel];
                    });
                }
               else if ([code isEqualToString:@"200"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self showModel];
                    });
                }
                else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
    }
    if ([_order_type isEqualToString:@"赠品专区"]) {
        SOrderDetails * details = arr[btn.tag];
        if ([btn.titleLabel.text isEqualToString:@"已收货"] || [btn.titleLabel.text isEqualToString:@"确认收货"]) {
            if ([details.status integerValue] == 1) {
                [MBProgressHUD showError:@"此商品已收货" toView:self.view];
                return;
            }
            SPay_Pass * pass = [[SPay_Pass alloc] init];
            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:pass animated:YES completion:nil];
            pass.SPay_Pass_back = ^{
                //是否存在七天无理由退换货（0->不存在，1->存在）
                if ([details.sure_status isEqualToString:@"0"]) {
                    //拼单购确认收货
                    SgiftOderReceivingModel * receiving = [[SgiftOderReceivingModel alloc] init];
                    receiving.order_id = _order_id;
                    receiving.status=@"1";
                    
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [receiving SgiftOderReceivingModelSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"200"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                    
                } else {
                    SOrderInfor_Come * come = [[SOrderInfor_Come alloc] init];
                    come.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    come.modalPresentationStyle = UIModalPresentationOverFullScreen;
                    [self.navigationController presentViewController:come animated:YES completion:nil];
                    come.server.text = details.server;
                    come.server_else.text = details.server_else;
                    come.SOrderInfor_Come_choice = ^(NSString *type) {
                        //拼单购确认收货
                        SgiftOderReceivingModel * receiving = [[SgiftOderReceivingModel alloc] init];
                        receiving.order_id = _order_id;
                        if ([type isEqualToString:@"1"]) {
                            receiving.status = @"1";//2->放弃，1->确认
                        }
                        if ([type isEqualToString:@"2"]) {
                            receiving.status = @"2";//2->放弃，1->确认
                        }
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [receiving SgiftOderReceivingModelSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"200"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [self showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    };
                    
                    
                }
            };
            
        } else {
            //提醒发货
            SOrderRemind * remind = [[SOrderRemind alloc] init];
            remind.orderType = _order_type;
            remind.group_buy_order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [remind sOrderRemindSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            
                if ([code isEqualToString:@"200"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self showModel];
                    });
                }
                else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
    }
}
#pragma mark - 延时收货
- (void)againBtnClick:(UIButton *)btn {
    if ([_order_type isEqualToString:@"普通商品"] || [_order_type isEqualToString:@"无界商店"]) {
        SOrderDetails * details = arr[btn.tag];
        SOrderDelayReceiving * rec = [[SOrderDelayReceiving alloc] init];
        rec.orderType = _order_type;
        rec.order_goods_id = details.order_goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [rec sOrderDelayReceivingSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showModel];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }else if ([_order_type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderDetails * details = arr[btn.tag];
        SOrderDelayReceiving * rec = [[SOrderDelayReceiving alloc] init];
        rec.orderType = _order_type;
        rec.order_goods_id = details.order_goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [rec sOrderDelayReceivingSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showModel];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    else if ([_order_type isEqualToString:@"赠品专区"]) {
        SGroupBuyOrderDetails * details = arr[btn.tag];
        SgiftOrderdelayReceiving * rec = [[SgiftOrderdelayReceiving alloc] init];
        rec.order_goods_id = details.order_goods_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [rec SgiftOrderdelayReceivingSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"200"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showModel];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
#pragma mark - 物流信息
- (void)freightBtnClick {
    
    //测试大礼包：多物流
    SOrder_logistics * logistics = [[SOrder_logistics alloc] init];
    logistics.order_id = _order_id;
    logistics.order_goods_id = ((SOrderDetails *)arr[0]).order_goods_id;
    logistics.order_type = _order_type;
    [self.navigationController pushViewController:logistics animated:YES];
}
#pragma mark - 店铺详情
- (void)merchant_inforBtnClick {
    if (_IsInShop==NO) {
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = merchant_id;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
    }
   
}
@end
