//
//  SCodePackage.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#define QIQUANQUANURL [NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/User/myTicket/status/3/p/1/type/1.html",[Url_header isEqualToString:@"api"] ? @"www" : Url_header]

#import "SCodePackage.h"
#import "SGoodsInfor_nav.h"
#import "SCodePackage_oneCell.h"
#import "SCodePackage_twoCell.h"

#import "SUserMyTicket.h"
#import "CQPlaceholderView.h"
#import<WebKit/WebKit.h>

@interface SCodePackage () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate,WKNavigationDelegate,WKUIDelegate>
{
    SGoodsInfor_nav * nav;
    
    NSArray * arr;//未使用
    NSArray * brr;//已失效
    CQPlaceholderView *placeholderView;

}
@property (strong, nonatomic) IBOutlet UITableView *oneTable;
@property (strong, nonatomic) IBOutlet UITableView *twoTable;
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation SCodePackage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    [_oneTable registerNib:[UINib nibWithNibName:@"SCodePackage_oneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SCodePackage_oneCell"];
    _oneTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_twoTable registerNib:[UINib nibWithNibName:@"SCodePackage_twoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SCodePackage_twoCell"];
    _twoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //默认加载会员卡列表
    _oneTable.hidden = NO;
    _twoTable.hidden = YES;
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _twoTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_twoTable addSubview:placeholderView];
    placeholderView.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_oneTable, self);
    adjustsScrollViewInsets_NO(_twoTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
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
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    nav = [[SGoodsInfor_nav alloc] initWithFrame:CGRectMake(0, 0, 210, 44)];
    self.navigationItem.titleView = nav;
    nav.twoBtn_WWW.constant = 70;
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    
    //会员卡
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.oneBtn setTitle:@"会员卡" forState:UIControlStateNormal];
    [nav.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //优惠券
    [nav.twoBtn setTitle:@"优惠券" forState:UIControlStateNormal];
    [nav.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //期权券
    [nav.threeBtn setTitle:@"期权" forState:UIControlStateNormal];
    [nav.threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 会员卡
- (void)oneBtnClick {
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    _oneTable.hidden = NO;
    _twoTable.hidden = YES;
    _webView.hidden =!NO;
}
#pragma mark - 优惠券
- (void)twoBtnClick {
    [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    nav.oneLine.hidden = YES;
    nav.twoLine.hidden = NO;
    nav.threeLine.hidden = YES;
    _oneTable.hidden = YES;
    _twoTable.hidden = NO;
    _webView.hidden =!NO;
    
    SUserMyTicket * myTicket = [[SUserMyTicket alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [myTicket sUserMyTicketSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        SUserMyTicket * myTicket = (SUserMyTicket *)data;
        arr = myTicket.data.normal;
        brr = myTicket.data.out;
        [_twoTable reloadData];
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    [self twoBtnClick];
}
#pragma mark - 期权券
- (void)threeBtnClick {
    [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    nav.oneLine.hidden = YES;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = NO;
    _oneTable.hidden = YES;
    _twoTable.hidden = YES;
    _webView.hidden =NO;

    
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_webView];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:QIQUANQUANURL]]];
        [MBProgressHUD showMessage:@"" toView:self.webView];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [MBProgressHUD hideHUDForView:webView];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
     NSMutableURLRequest *mutableRequest = [navigationAction.request mutableCopy];
    NSDictionary *requestHeaders = navigationAction.request.allHTTPHeaderFields;
    //我们项目使用的token同步的，cookie的话类似
    if (requestHeaders[@"token"]){
         decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
    }else{
        //这里添加请求头，把需要的都添加进来
        [mutableRequest setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token
              forHTTPHeaderField:@"token"];
        [webView loadRequest:mutableRequest];
        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
    }
    
}

- (void)backBtnClick:(UIButton *)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _twoTable) {
        if (arr.count == 0 && brr.count == 0) {
            placeholderView.hidden = NO;
        } else {
            placeholderView.hidden = YES;
        }
        if (section == 0) {
            return arr.count;
        } else {
            return brr.count;
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        
        UIButton * footerBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2 - 50, 0, 100, 50)];
        [footer addSubview:footerBtn];
        if (tableView == _oneTable) {
            [footerBtn setTitle:@"未激活会员卡" forState:UIControlStateNormal];
        } else if (tableView == _twoTable) {
            [footerBtn setTitle:@"已失效优惠券" forState:UIControlStateNormal];
//            [footerBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        }
        
        footerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [footerBtn setTitleColor:WordColor forState:UIControlStateNormal];
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(15, 25, (ScreenW - 100 - 30)/2, 1)];
        [footer addSubview:line1];
        line1.backgroundColor = MyLine;
        
        UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenW/2 + 40 + 15, 25, (ScreenW - 50 - 30)/2, 1)];
        [footer addSubview:line2];
        line2.backgroundColor = MyLine;
        
        return footer;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _oneTable) {
        return ScreenW/1146*539 + 10;
    }
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _oneTable) {
        SCodePackage_oneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCodePackage_oneCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            cell.groundImage.image = [UIImage imageNamed:@"卡券包背景"];
            cell.price.text = @"777.00";
        } else {
            cell.groundImage.image = [UIImage imageNamed:@"卡券包背景灰"];
            cell.price.text = @"0.00";
        }
        
        return cell;
    }
    
    SCodePackage_twoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCodePackage_twoCell" forIndexPath:indexPath];
    cell.showTimeView.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.rigthImageR.image = [UIImage imageNamed:@"优惠券有效"];
        cell.rightImageR_sub.image = [UIImage imageNamed:@"优惠券有效R"];
        cell.thisTitle.textColor = WordColor;
        cell.thisContent.textColor = [UIColor redColor];
        cell.oneT.backgroundColor = MyPowder;
        cell.twoT.backgroundColor = MyGreen;
        
        SUserMyTicket * myTicket = arr[indexPath.row];
        cell.thisTitle.text = myTicket.ticket_name;
        cell.thisContent.text = [NSString stringWithFormat:@"%@ %@",myTicket.value,myTicket.ticket_desc];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:myTicket.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        
        cell.twoT.text = @"满折";
        if ([myTicket.ticket_type isEqualToString:@"1"]) {
            cell.oneT.hidden = NO;
            cell.twoT.hidden = YES;
            cell.threeT.hidden = YES;
        }
        if ([myTicket.ticket_type isEqualToString:@"2"]) {
            cell.oneT.hidden = YES;
            cell.twoT.hidden = NO;
            cell.threeT.hidden = YES;
        }
        if ([myTicket.ticket_type isEqualToString:@"3"]) {
            cell.oneT.hidden = YES;
            cell.twoT.hidden = YES;
            cell.threeT.hidden = NO;
        }
        
    } else {
        cell.rigthImageR.image = [UIImage imageNamed:@"优惠券失效"];
        cell.rightImageR_sub.image = [UIImage imageNamed:@"优惠券失效R"];
        cell.thisTitle.textColor = WordColor_sub_sub;
        cell.thisContent.textColor = WordColor_sub_sub;
        cell.oneT.backgroundColor = WordColor_sub_sub;
        cell.twoT.backgroundColor = WordColor_sub_sub;
        cell.threeT.backgroundColor = WordColor_sub_sub;
        
        SUserMyTicket * myTicket = brr[indexPath.row];
        cell.thisTitle.text = myTicket.ticket_name;
        cell.thisContent.text = myTicket.ticket_desc;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:myTicket.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        
        
        cell.twoT.text = @"满折";
        if ([myTicket.ticket_type isEqualToString:@"1"]) {
            cell.oneT.hidden = NO;
            cell.twoT.hidden = YES;
            cell.threeT.hidden = YES;
        }
        if ([myTicket.ticket_type isEqualToString:@"2"]) {
            cell.oneT.hidden = YES;
            cell.twoT.hidden = NO;
            cell.threeT.hidden = YES;
        }
        if ([myTicket.ticket_type isEqualToString:@"3"]) {
            cell.oneT.hidden = YES;
            cell.twoT.hidden = YES;
            cell.threeT.hidden = NO;
        }
        
    }
    
    return cell;    
    
}
@end
