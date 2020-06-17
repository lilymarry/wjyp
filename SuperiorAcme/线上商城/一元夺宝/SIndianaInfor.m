//
//  SIndianaInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIndianaInfor.h"
#import "SIndianaInfor_top.h"
#import "SNBannerView.h"
#import "SIndianaInforCell.h"
#import<WebKit/WebKit.h>
#import "SOneBuyOneBuyInfo.h"
#import "SIndianaInfor_threeCell.h"
#import "SShopCar_editView.h"
#import "SOrderConfirm.h"

@interface SIndianaInfor () <SNBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate>
{
    SIndianaInfor_top * top;
    UIView * line;
    WKWebView * wk_web;//极速web
    NSString * type;//1参与记录 2图文详情 3往期揭晓 4规则说明
    
    NSArray * oneBuyLog_arr;
    NSArray * outTime_log_arr;
    NSString * goods_desc;//"图文详情",
    NSString * rules;//"规则说明"
    
    NSString * goods_id;//"商品id",
    NSString * product_id;//属性id
    NSString * merchant_id;//商家id
    
    NSString * model_balance_num;//金额
    NSString * model_pic;//图片
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation SIndianaInfor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    top = [[SIndianaInfor_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW + 200)];
    _mTable.tableHeaderView = top;
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 49, ScreenW/4, 1)];
    [top.typeView addSubview:line];
    
    //默认参与记录
    type = @"1";
    line.backgroundColor = [UIColor redColor];
    [top.typeView_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //参与记录
    [top.typeView_oneBtn addTarget:self action:@selector(typeView_oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //图文详情
    [top.typeView_twoBtn addTarget:self action:@selector(typeView_twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //往期揭晓
    [top.typeView_threeBtn addTarget:self action:@selector(typeView_threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //规则说明
    [top.typeView_fourBtn addTarget:self action:@selector(typeView_fourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SIndianaInforCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SIndianaInforCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"SIndianaInfor_threeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SIndianaInfor_threeCell"];
    
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    wk_web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) configuration:wkWebConfig];
    wk_web.userInteractionEnabled = NO;
    wk_web.navigationDelegate = self;
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    
    SOneBuyOneBuyInfo * infor = [[SOneBuyOneBuyInfo alloc] init];
    infor.one_buy_id = _one_buy_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sOneBuyOneBuyInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SOneBuyOneBuyInfo * infor = (SOneBuyOneBuyInfo *)data;
            
            goods_desc = infor.data.goods_desc;
            rules = infor.data.rules;
            goods_id = infor.data.oneBuyInfo.goods_id;
            product_id = infor.data.oneBuyInfo.product_id;
            merchant_id = infor.data.oneBuyInfo.merchant_id;
            model_balance_num = infor.data.oneBuyInfo.balance_num;
            model_pic = infor.data.oneBuyInfo.pic;
            
            SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.goodsGallery URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
            [top.bannerView addSubview:banner];
            
            top.goods_name.text = infor.data.oneBuyInfo.goods_name;
            top.showTitle.text = infor.data.oneBuyInfo.t_status;
            top.integral.text = infor.data.oneBuyInfo.integral;
            [top.thisRedPro setProgress:[infor.data.oneBuyInfo.add_num floatValue]/[infor.data.oneBuyInfo.person_num floatValue]];
            top.time_num.text = [NSString stringWithFormat:@"期号%@",infor.data.oneBuyInfo.time_num];
            top.person_num.text = [NSString stringWithFormat:@"总需%@人/",infor.data.oneBuyInfo.person_num];
            top.add_num.text = [NSString stringWithFormat:@"%ld",[infor.data.oneBuyInfo.person_num integerValue] - [infor.data.oneBuyInfo.add_num integerValue]];
            
            oneBuyLog_arr = infor.data.oneBuyLog;
            outTime_log_arr = infor.data.outTime_log;
            [_mTable reloadData];
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        if ([type isEqualToString:@"1"]||[type isEqualToString:@"3"]) {
            return;
        }
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
//        NSLog(@"图文详情高度:%f",heightStr.floatValue);
        
        wk_web.frame = CGRectMake(0, 0, ScreenW, heightStr.floatValue + 15);
        _mTable.tableFooterView = wk_web;
        
    }];
}
#pragma mark - 参与记录
- (void)typeView_oneBtnClick {
    type = @"1";
    line.frame = CGRectMake(0, 49, ScreenW/4, 1);
    [top.typeView_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [top.typeView_twoBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [top.typeView_threeBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [top.typeView_fourBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [_mTable reloadData];
    
    [wk_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    wk_web.frame = CGRectMake(0, 0, ScreenW, 0);
    _mTable.tableFooterView = wk_web;
}
#pragma mark - 图文详情
- (void)typeView_twoBtnClick {
    type = @"2";
    line.frame = CGRectMake(ScreenW/4, 49, ScreenW/4, 1);
    [top.typeView_oneBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [top.typeView_twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [top.typeView_threeBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [top.typeView_fourBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [wk_web loadHTMLString:goods_desc baseURL:nil];
    [_mTable reloadData];
}
#pragma mark - 往期揭晓
- (void)typeView_threeBtnClick {
    type = @"3";
    line.frame = CGRectMake(ScreenW/4 * 2, 49, ScreenW/4, 1);
    [top.typeView_oneBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [top.typeView_twoBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [top.typeView_threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [top.typeView_fourBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [_mTable reloadData];
    [wk_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    wk_web.frame = CGRectMake(0, 0, ScreenW, 0);
    _mTable.tableFooterView = wk_web;
}
#pragma mark - 规则说明
- (void)typeView_fourBtnClick {
    type = @"4";
    line.frame = CGRectMake(ScreenW/4 * 3, 49, ScreenW/4, 1);
    [top.typeView_oneBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [top.typeView_twoBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [top.typeView_threeBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [top.typeView_fourBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [wk_web loadHTMLString:rules baseURL:nil];
    [_mTable reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"积分抽奖";
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([type isEqualToString:@"2"] || [type isEqualToString:@"4"]) {
        return 0;
    }
    if ([type isEqualToString:@"1"]) {
        return oneBuyLog_arr.count;
    }
    return outTime_log_arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([type isEqualToString:@"1"]) {
        return 25;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([type isEqualToString:@"1"]) {
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 25)];
        header.backgroundColor = [UIColor whiteColor];
        UIImageView * timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        [header addSubview:timeImage];
        timeImage.image = [UIImage imageNamed:@"灰色时间"];
        
        return header;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([type isEqualToString:@"3"]) {
        return 125;
    }
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([type isEqualToString:@"1"]) {
        SIndianaInforCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SIndianaInforCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        SOneBuyOneBuyInfo * list = oneBuyLog_arr[indexPath.row];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"参与%@人次",list.count]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, list.count.length)];
        cell.thisNUm.attributedText = AttributedStr;
        
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.time_num.text = [NSString stringWithFormat:@"%@ (%@)",list.time_num,list.phone];
        cell.bid_time.text = list.bid_time;
        
        return cell;
    } else {
        SIndianaInfor_threeCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"SIndianaInfor_threeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SOneBuyOneBuyInfo * list = outTime_log_arr[indexPath.row];
        [cell.head_pic sd_setImageWithURL:[NSURL URLWithString:list.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.add_num.text = [NSString stringWithFormat:@"获   得   者：%@",list.add_num];
        cell.time_num.text = [NSString stringWithFormat:@"期          号：%@",list.time_num];
        cell.end_true_time.text = [NSString stringWithFormat:@"揭 晓 时 间：%@",list.end_true_time];
        cell.winer_code.text = [NSString stringWithFormat:@"幸 运 号 码：%@",list.winer_code];
        cell.count.text = [NSString stringWithFormat:@"本 期 参 与：%@人次",list.count];
        
        
        return cell;
    }
    
}
- (IBAction)submitBtn:(UIButton *)sender {
    
    SShopCar_editView * editView = [[SShopCar_editView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:editView];
    editView.scr_HHH.constant = ScreenH;
    editView.goods_id = goods_id;
    editView.product_id = product_id;
    [editView showModel];
    [editView addBuy:@"立即购买"];//立即购买

    editView.goods_id = goods_id;
    editView.SShopCar_editView_back = ^{
        [editView removeFromSuperview];
    };
    //立即购买
    editView.SShopCar_editView_addBuy = ^(NSString *num, NSString *now_product_id) {
        [editView removeFromSuperview];
        SOrderConfirm * con = [[SOrderConfirm alloc] init];
        con.merchant_id = merchant_id;
        con.num = num;
        con.integral_id = _one_buy_id;
        con.special_type = @"积分抽奖";
        con.goods_id = @"";//这样传值是为了防止走普通商品的添加订单接口，只有积分抽奖这样写了，别的还是之前的样子
        con.product_id = now_product_id;
        [self.navigationController pushViewController:con animated:YES];
    };
}
@end
