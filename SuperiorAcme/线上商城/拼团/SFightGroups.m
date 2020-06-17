//
//  SFightGroups.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SFightGroups.h"
#import "SFightGroups_top.h"
#import "SFightGroupsCell.h"
#import "SGroupBuyOrderOffered.h"
#import "SOrderConfirm.h"
#import "SShopCar_editView.h"
#import "AShare.h"
#import "BaseShare.h"

@interface SFightGroups () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
    NSString * shop_price_buy;
    NSString *shareGoodsImage;
    NSString *shareGoodsName;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

/*
 *top视图属性,用于给top视图中的倒计时label和需要拼团的人数label赋值
 */
@property (nonatomic, strong) SFightGroups_top * top;

@end

@implementation SFightGroups

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            [self viewDidLoad];
        };
        return;
    }
    
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SFightGroupsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SFightGroupsCell"];
    
    SFightGroups_top * top = [[SFightGroups_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 380)];
    self.top = top;
    _mTable.tableHeaderView = top;
    [top.submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

/*
 *抽取网络请求的代码,实现页面显示就请求数据
 */
-(void)showModel{
    SGroupBuyOrderOffered * offered = [[SGroupBuyOrderOffered alloc] init];
    offered.group_buy_order_id = _group_buy_order_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [offered sGroupBuyOrderOfferedSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SGroupBuyOrderOffered * offered = (SGroupBuyOrderOffered *)data;
        
        //保存分享相关信息
        shareGoodsImage = offered.data.goods_img;
        shareGoodsName = offered.data.goods_name;
        
        /*
         *保存赠送的积分,传递给top视图
         */
        offered.givenIntegral = self.GivenIntegral;
        
        
        /*
         *给top视图传递参团数据的模型值
         */
        _top.offeredModel = offered;
        [_top.goods_img sd_setImageWithURL:[NSURL URLWithString:offered.data.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        _top.goods_name.text = offered.data.goods_name;
        _top.thisNum.text = [NSString stringWithFormat:@"已拼%@件( %@ )",offered.data.already,offered.data.number];
        shop_price_buy = offered.data.shop_price;
        _top.shop_price.text = [NSString stringWithFormat:@"￥%@",offered.data.shop_price];
        [_top.leftImage sd_setImageWithURL:[NSURL URLWithString:offered.data.colonel_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        
        if ([offered.data.status isEqualToString:@"0"]) {
            _top.status_title.text = @"还差1人";
        } else {
            _top.status_title.text = @"已成单";
        }
        if ([offered.data.is_colonel isEqualToString:@"1"]) {
            /*
             *修复是团长时,只显示团长本人的问题
             */
            //            top.rightImage.hidden = YES;
            //            top.thisImageView_WWW.constant = 40;
            [_top.submitBtn setTitle:@"我是拼主" forState:UIControlStateNormal];
            [_top.submitBtn setBackgroundColor:WordColor_sub_sub];
        }
        
        arr = offered.data.offered;
        /*
         *将获取的html字符串转换成NSAttributedString对象
         */
        for (SGroupBuyOrderOffered * list in arr) {
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[list.oneself dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            list.attrOneself = attrStr;
        }
        
        NSMutableArray * tempArr = [NSMutableArray array];
        for (int i = 1; i < offered.data.offered.count ; i++) {
            SGroupBuyOrderOffered * model = offered.data.offered[i];
            [tempArr addObject:model];
        }
        arr = [tempArr copy];
        SGroupBuyOrderOffered * model = offered.data.offered.firstObject;
        
        _top.groupIntroduceTitleLabel.attributedText = model.attrOneself;

        [_mTable reloadData];
        
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
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"拼单";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    /*
     *每次显示页面时,从新请求一次数据
     */
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
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
}
#pragma mark - 分享
- (void)rightBtnClick {
    BaseShare *share = [[BaseShare alloc]init];
    NSDictionary *parametersDit = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type",_group_buy_order_id,@"id",nil];
    NSDictionary *shareParameters = [NSDictionary dictionaryWithObjectsAndKeys:shareGoodsImage,@"shareGoodsImage",shareGoodsName,@"shareGoodsName",@"快来一起拼单吧",@"content",@"测试",@"id_val",@"6",@"type",nil];
    [share shareApi:ShareGroupBuyOrder andParameters:parametersDit andViewController:self andShareParameters:shareParameters];
}

- (void)lefthBtnClick {
    
    /*
     *控制器Pop时的通知,用来移除定时器
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QuitJoinGroup" object:nil userInfo:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50;
    SGroupBuyOrderOffered * list = arr[indexPath.row];
    return list.CellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFightGroupsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SFightGroupsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SGroupBuyOrderOffered * list = arr[indexPath.row];
//    cell.thisTitle.text = list.oneself;//旧代码
    /*
     *加载富文本
     */
    cell.thisTitle.attributedText = list.attrOneself;
    CGRect textRect = [cell.thisTitle.text boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : cell.thisTitle.font} context:nil];
    if (textRect.size.height < 35) {
        list.CellHeight = 35;
    }else{
        list.CellHeight = textRect.size.height + 20;
    }
    
    return cell;
}

- (void)submitBtnClick:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"我是拼主"]) {
        return;
    }
    SShopCar_editView * editView = [[SShopCar_editView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    /*
     *添加是否是一键参团的状态
     */
    editView.isOneKeyGroup = YES;
    [[[UIApplication sharedApplication] keyWindow] addSubview:editView];
    editView.scr_HHH.constant = ScreenH;
    editView.goods_id = _goods_id;
    editView.product_id = _product_id;
    editView.buy_goods_type = @"拼单购";
    if ([editView.buy_goods_type isEqualToString:@"拼单购"]) {
        editView.group_buy_type_status = @"2";//默认为拼单类型
        if ([_group_buy_type_status isEqualToString:@"1"]) {
            editView.group_buy_type_status = @"1";
        }
    }
    [editView showModel];
    [editView addBuy:@"确定"];//NO加入购物车 YES立即购买 | 确定
    editView.SShopCar_editView_back = ^{
        [editView removeFromSuperview];
    };
    editView.SShopCar_editView_showPrice = ^{
        editView.thisPrice.text = [NSString stringWithFormat:@"￥%@",shop_price_buy];
    };
    //立即购买
//    editView.SShopCar_editView_addBuy = ^(NSString *num, NSString *now_product_id) {
//        [editView removeFromSuperview];
//        SOrderConfirm * con = [[SOrderConfirm alloc] init];
//        con.merchant_id = _merchant_id;
//        con.goods_id = _goods_id;
//        con.num = num;
//        con.special_type = @"拼单购";
//        con.special_type_sub = @"3";//1直接购买 2拼单(开团) 3拼单(参团)
//        con.group_buy_id = _group_buy_id;
//        con.group_buy_order_id = _group_buy_order_id;
//        con.product_id = now_product_id;
//        [self.navigationController pushViewController:con animated:YES];
//    };
    
    /*
     *一键参团选择规格后的立即支付的回调
     */
    editView.SShopCar_editView_OneKeyGroupAddBuy = ^(NSString *num, NSString *now_product_id, NSString *now_group_buy_id) {
        [editView removeFromSuperview];
        SOrderConfirm * con = [[SOrderConfirm alloc] init];
        con.merchant_id = _merchant_id;
        con.goods_id = _goods_id;
        con.num = num;
        con.special_type = @"拼单购";
        con.special_type_sub = @"3";//1直接购买 2拼单(开团) 3拼单(参团)
        con.group_buy_id = now_group_buy_id;
        con.group_buy_order_id = _group_buy_order_id;
        con.product_id = now_product_id;
        [self.navigationController pushViewController:con animated:YES];
    };
}
@end
