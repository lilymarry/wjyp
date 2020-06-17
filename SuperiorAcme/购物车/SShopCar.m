//
//  SShopCar.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopCar.h"
#import "SShopCar_header.h"
#import "SShopCarCell.h"
#import "SShopCar_editView.h"
#import "STicketFight.h"
#import "SOrderConfirm.h"
#import "SWelfareAgency.h"
#import "SListedIncubation.h"
#import "SCartCartList.h"
#import "SCartEditCart.h"
#import "SCartDelCart.h"
#import "SCartAddCollect.h"
#import "CQPlaceholderView.h"
#import "SOnlineShopInfor.h"

@interface SShopCar () <UITableViewDelegate,UITableViewDataSource,SShopCarCellDelegate,CQPlaceholderViewDelegate>
{
    BOOL edit_isno;//NO默认 YES编辑
    UIButton * rigthBtn;
    NSArray * arr;
    CQPlaceholderView *placeholderView;

}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *down_HHH;
@property (strong, nonatomic) IBOutlet UIButton *allBtn;
@property (strong, nonatomic) IBOutlet UILabel *allPrice;//总金额
@property (strong, nonatomic) IBOutlet UILabel *allPrice_sub;//配送费
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;//去结算
@property (strong, nonatomic) IBOutlet UIButton *submitBtn_sub;//移到收藏夹

@end

@implementation SShopCar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SShopCarCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SShopCarCell"];
    //默认隐藏 全选 移到收藏夹
    _allBtn.hidden = YES;
    _submitBtn_sub.hidden = YES;
    
    //全选
    [_allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //移到收藏夹
    [_submitBtn_sub addTarget:self action:@selector(submitBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    //去结算、删除
    [_submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self initRefresh];
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    //tabBar-->重置、防止重影
    for (id obj in self.tabBarController.tabBar.subviews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj removeFromSuperview];
        }
    }
    
    self.title = @"购物车";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    /*
     * 修复点击更多按钮后,窗口无内容显示的问题(是因为keyWindow被修改的原因)
     * 重新设置应用的keyWindow
     */
    if (![UIApplication sharedApplication].windows.firstObject.keyWindow) {
        [[UIApplication sharedApplication].windows.firstObject makeKeyWindow];
    }
    
    //开始侧滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //判断侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    [self showModel];
    
    UIViewController * vc = self.tabBarController.viewControllers[3];
    vc.tabBarItem.badgeValue = 0;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {

    [self showModel];
}
- (void)initRefresh
{
    __block SShopCar * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [blockSelf showModel];
    }];
}
- (void)showModel {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        self.view.window.rootViewController = landNav;
    } else {
        SCartCartList * list = [[SCartCartList alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sCartCartListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SCartCartList * list = (SCartCartList *)data;
            arr = list.data;
            _allPrice.hidden = YES;
            _allPrice_sub.hidden = YES;
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [_mTable.mj_header endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
- (void)createNav {
    
    if (_type == YES) {
        _down_HHH.constant = 0;
        
        UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lefthBtn.frame = CGRectMake(0, 0, 44, 50);
        UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
        self.navigationItem.leftBarButtonItem = leftBtnItem;
        
        [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
        lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
        
        [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    if (edit_isno == NO) {
        [rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
        edit_isno = YES;
        _allBtn.hidden = NO;
        _allPrice.hidden = YES;
        _allPrice_sub.hidden = YES;
        _submitBtn_sub.hidden = NO;
        [_submitBtn setTitle:@"删除" forState:UIControlStateNormal];
        
        [_mTable reloadData];

    } else {
        [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
        edit_isno = NO;
        _allBtn.hidden = YES;
        _allPrice.hidden = NO;
        _allPrice_sub.hidden = NO;
        _submitBtn_sub.hidden = YES;
        [_submitBtn setTitle:@"去结算" forState:UIControlStateNormal];
        
        SCartEditCart * editCart = [[SCartEditCart alloc] init];
        NSMutableArray * carArr = [[NSMutableArray alloc] init];
        for (SCartCartList * list in arr) {
            for (SCartCartList * list_sub in list.goods) {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                [dic setValue:list_sub.cart_id forKey:@"cart_id"];
                [dic setValue:list_sub.goods_id forKey:@"goods_id"];
                [dic setValue:list_sub.product_id forKey:@"product_id"];
                [dic setValue:list_sub.num forKey:@"num"];
                [carArr addObject:dic];
            }
        }
        editCart.cart_json = [carArr mj_JSONString];
        [MBProgressHUD showMessage:nil toView:self.view];
        [editCart sCartEditCartSuccess:^(NSString *code, NSString *message) {
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (arr.count == 0) {
        rigthBtn.hidden = YES;
        placeholderView.hidden = NO;
        edit_isno = NO;
        _allBtn.hidden = YES;
        _allPrice.hidden = YES;
        _allPrice_sub.hidden = YES;
        _submitBtn_sub.hidden = YES;
        [_submitBtn setTitle:@"去结算" forState:UIControlStateNormal];
    } else {
        rigthBtn.hidden = NO;
        placeholderView.hidden = YES;
        
    }
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SCartCartList * list = arr[section];
    return list.goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SShopCar_header * header = [[SShopCar_header alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    
    SCartCartList * list = arr[section];
    header.nickname.text = list.merchant_name;
    if ([self RAll:list.goods] == NO) {
        [header.RBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    } else {
        [header.RBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    }
    [header.RBtn setTag:section];
    [header.RBtn addTarget:self action:@selector(RBtnAllClick:) forControlEvents:UIControlEventTouchUpInside];
    [header.inforBtn setTag:section];
    [header.inforBtn addTarget:self action:@selector(inforBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return header;
}
- (BOOL)RAll:(NSArray *)rArr {
    for (SCartCartList * list_sub in rArr) {
        if (list_sub.RBtn_BOOL == NO) {
            return NO;
        }
    }
    return YES;
}
- (void)inforBtnClick:(UIButton *)btn {
    SCartCartList * list = arr[btn.tag];
    SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
    infor.merchant_id = list.merchant_id;
    infor.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infor animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SShopCarCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SShopCarCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    SCartCartList * list = arr[indexPath.section];
    SCartCartList * list_sub = list.goods[indexPath.row];
    [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list_sub.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.goods_name.text = list_sub.goods_name;
    
    //规格 + 赠送积分
    if (list_sub.return_integral == nil || [list_sub.return_integral isEqualToString:@""]||[list_sub.return_integral doubleValue]==0) {
        cell.attr_group.text = [list_sub.goods_attr_name stringByReplacingOccurrencesOfString:@"+" withString:@""];
    } else {
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",[list_sub.goods_attr_name stringByReplacingOccurrencesOfString:@"+" withString:@""],list_sub.return_integral]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange([list_sub.goods_attr_name stringByReplacingOccurrencesOfString:@"+" withString:@""].length , 7 + list_sub.return_integral.length)];
        cell.attr_group.attributedText = AttributedStr;
    }
    
    cell.shop_price.text = [NSString stringWithFormat:@"￥%@",list_sub.shop_price];
    cell.num.text = [NSString stringWithFormat:@"x%@",list_sub.num];
    cell.numTF.text = list_sub.num;
    cell.attr_group_edit.text = [NSString stringWithFormat:@"%@(库存:%@)",[list_sub.goods_attr_name stringByReplacingOccurrencesOfString:@"+" withString:@""] == nil ? @"" : [list_sub.goods_attr_name stringByReplacingOccurrencesOfString:@"+" withString:@""],list_sub.goods_num];
    if (list_sub.RBtn_BOOL == NO) {
        [cell.RBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    } else {
        [cell.RBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    }

    if (edit_isno == NO) {
        cell.editView.hidden = YES;
    } else {
        cell.editView.hidden = NO;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SCartCartList * list = arr[indexPath.section];
    SCartCartList * list_sub = list.goods[indexPath.row];
    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
    info.goods_id = list_sub.goods_id;
    info.overType = NULL;
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
}
#pragma mark - 减
- (void)leftCell:(SShopCarCell *)cell leftBtn:(UIButton *)btn {
    NSIndexPath * indexPath = [_mTable indexPathForCell:cell];
    SCartCartList * list = arr[indexPath.section];
    SCartCartList * list_sub = list.goods[indexPath.row];
    if ([list_sub.num integerValue] > 1) {
        list_sub.num = [NSString stringWithFormat:@"%ld",[list_sub.num integerValue] - 1];
    }
    [_mTable reloadData];
}
#pragma mark - 加
- (void)rightCell:(SShopCarCell *)cell rightBtn:(UIButton *)btn {
    NSIndexPath * indexPath = [_mTable indexPathForCell:cell];
    SCartCartList * list = arr[indexPath.section];
    SCartCartList * list_sub = list.goods[indexPath.row];
    if ([cell.numTF.text integerValue] < [list_sub.goods_num integerValue]) {
        list_sub.num = [NSString stringWithFormat:@"%ld",[list_sub.num integerValue] + 1];
    }
    [_mTable reloadData];
}
#pragma mark - 数量编辑
- (void)editNumCell:(SShopCarCell *)cell editNumTF:(UITextField *)numTF {
    NSIndexPath * indexPath = [_mTable indexPathForCell:cell];
    SCartCartList * list = arr[indexPath.section];
    SCartCartList * list_sub = list.goods[indexPath.row];
    if ([list_sub.goods_num integerValue] - [numTF.text integerValue] <= 0) {
        list_sub.num = list_sub.goods_num;
        cell.numTF.text = list_sub.goods_num;
    } else if ([numTF.text isEqualToString:@""]) {
        list_sub.num = @"1";
        cell.numTF.text = @"1";
    } else {
        list_sub.num = numTF.text;
        cell.numTF.text = numTF.text;
    }
    [_mTable reloadData];

}
#pragma mark - 编辑
- (void)editCell:(SShopCarCell *)cell editBtn:(UIButton *)btn {
    NSIndexPath * indexPath = [_mTable indexPathForCell:cell];
    SCartCartList * list = arr[indexPath.section];
    SCartCartList * list_sub = list.goods[indexPath.row];
    
    SShopCar_editView * editView = [[SShopCar_editView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:editView];
    editView.scr_HHH.constant = ScreenH;
    editView.goods_id = list_sub.goods_id;
    [editView showModel];
    [editView addBuy:@"完成"];

    editView.SShopCar_editView_carEdit = ^(NSString *num, NSString *product_id, NSString *product_id_name, NSString * goods_num) {
        list_sub.product_id = product_id;
        list_sub.num = num;
        list_sub.goods_attr_name = product_id_name;
        list_sub.goods_num = goods_num;
        [editView removeFromSuperview];
        [_mTable reloadData];
    };
    editView.SShopCar_editView_back = ^{
        [editView removeFromSuperview];
    };
    
}
- (void)RBtnCell:(SShopCarCell *)cell RBtn:(UIButton *)btn {
    NSIndexPath * indexPath = [_mTable indexPathForCell:cell];
    SCartCartList * list = arr[indexPath.section];
    SCartCartList * list_sub = list.goods[indexPath.row];
    if (list_sub.RBtn_BOOL == NO) {
        list_sub.RBtn_BOOL = YES;
    } else {
        list_sub.RBtn_BOOL = NO;
    }
    [_mTable reloadData];
    [self showAllPrice];
    if ([self All_isno] == NO) {
        [_allBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    } else {
        [_allBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    }
}
- (void)RBtnAllClick:(UIButton *)btn {
    SCartCartList * list = arr[btn.tag];
    if ([self RAll:list.goods] == NO) {
        for (SCartCartList * list_sub in list.goods) {
            list_sub.RBtn_BOOL = YES;
        }
    } else {
        for (SCartCartList * list_sub in list.goods) {
            list_sub.RBtn_BOOL = NO;
        }
    }
    [_mTable reloadData];
    [self showAllPrice];
    if ([self All_isno] == NO) {
        [_allBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];

    } else {
        [_allBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    }
}
#pragma mark - 总金额
- (void)showAllPrice {
    if (edit_isno == NO) {
        _allPrice.hidden = NO;
        _allPrice_sub.hidden = NO;
    } else {
        _allPrice.hidden = YES;
        _allPrice_sub.hidden = YES;
    }
    CGFloat price_num = 0;
    for (SCartCartList * list in arr) {
        for (SCartCartList * list_sub in list.goods) {
            if (list_sub.RBtn_BOOL == YES) {
                price_num += [list_sub.shop_price floatValue] * [list_sub.num integerValue];
            }
        }
    }
    _allPrice.text = [NSString stringWithFormat:@"￥%.2f",price_num];
    
}
#pragma mark - 全选判定
- (BOOL)All_isno {
    for (SCartCartList * list in arr) {
        for (SCartCartList * list_sub in list.goods) {
            if (list_sub.RBtn_BOOL == NO) {
                return NO;
            }
        }
    }
    return YES;
}
#pragma mark - 全选
- (void)allBtnClick {
    if ([self All_isno] == NO) {[_allBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
        for (SCartCartList * list in arr) {
            for (SCartCartList * list_sub in list.goods) {
                list_sub.RBtn_BOOL = YES;
            }
        }
       
    } else {
        [_allBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
        for (SCartCartList * list in arr) {
            for (SCartCartList * list_sub in list.goods) {
                list_sub.RBtn_BOOL = NO;
            }
        }
    }
    [_mTable reloadData];
}
#pragma mark - 移到收藏夹
- (void)submitBtn_subClick {
    SCartAddCollect * addCollect = [[SCartAddCollect alloc] init];
    NSMutableArray * delArr = [[NSMutableArray alloc] init];
    for (SCartCartList * list in arr) {
        for (SCartCartList * list_sub in list.goods) {
            if (list_sub.RBtn_BOOL == YES) {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                [dic setValue:list_sub.cart_id forKey:@"cart_id"];
                [delArr addObject:dic];
            }
        }
    }
    addCollect.cart_id_json = [delArr mj_JSONString];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [addCollect sCartAddCollectSuccess:^(NSString *code, NSString *message) {
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
#pragma mark - 去结算、删除
- (void)submitBtnClick:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"去结算"]) {
        NSMutableArray * car_arr = [[NSMutableArray alloc] init];
        NSMutableArray * merchant_id_arr = [[NSMutableArray alloc] init];
        SOrderConfirm * con = [[SOrderConfirm alloc] init];
        
        /*
         *添加购物车还没有商品时的判断,并显示购物车没有商品的提示信息
         */
        if (arr.count == 0 || arr == nil) {
            [MBProgressHUD showError:@"您的购物车还没有商品,快去添加吧~" toView:self.view];
            return;
        }
        
        for (SCartCartList * list in arr) {
            for (SCartCartList * list_sub in list.goods) {
                if (list_sub.RBtn_BOOL == YES) {
                    [car_arr addObject:list_sub.cart_id];
                    [merchant_id_arr addObject:list.merchant_id];
                }
            }
        }
        if (merchant_id_arr.count == 0) {
            //未选择结算商品，请选择
            /*
             *显示购物车有商品,但是没有选择商品点击去结算的提示信息
             */
            [MBProgressHUD showError:@"您还没有选择商品哦~" toView:self.view];
            return;
        }
        for (NSString * str in merchant_id_arr) {
            if (![merchant_id_arr.firstObject isEqualToString:str]) {
                [MBProgressHUD showError:@"请选择同商店的商品" toView:self.view];
                return;
            }
        }
        con.cart_id = [car_arr componentsJoinedByString:@","];
        con.merchant_id = merchant_id_arr.firstObject;
        con.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:con animated:YES];
    } else {
        //删除
        SCartDelCart * delCart = [[SCartDelCart alloc] init];
        
        NSMutableArray * delArr = [[NSMutableArray alloc] init];
        for (SCartCartList * list in arr) {
            for (SCartCartList * list_sub in list.goods) {
                if (list_sub.RBtn_BOOL == YES) {
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:list_sub.cart_id forKey:@"cart_id"];
                    [delArr addObject:dic];
                }
            }
        }
        delCart.cart_id_json = [delArr mj_JSONString];
        [MBProgressHUD showMessage:nil toView:self.view];
        [delCart sCartDelCartSuccess:^(NSString *code, NSString *message) {
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
        } ];
    }
}
@end
