//
//  SShopCouponUseCan.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopCouponUseCan.h"
#import "SShopCouponUseCanCell.h"
#import "SShopCouponUseCan_infor.h"
#import "SUserVouchersLog.h"
#import "CQPlaceholderView.h"
#import "SUserUserDevelopLog.h"
#import "SUserBalanceBalanceLog.h"
#import "SUserIntegralLog.h"
#import "SUserBalanceUnderMoneys.h"//线下充值列表
#import "SOrderInfor.h"
#import "SMemberOrderInfor.h"
#import "UBShopDetailController.h"
#import "ApplyYellowListModel.h"
#import "YinLiangWebInfo.h"
@interface SShopCouponUseCan () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView *placeholderView;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SShopCouponUseCan

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SShopCouponUseCanCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SShopCouponUseCanCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
  

    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if ([_type isEqualToString:@"1"]) {
        self.title = @"代金券使用明细";
    } else if ([_type isEqualToString:@"2"]) {
        self.title = @"积分明细";
    } else if ([_type isEqualToString:@"3"]) {
        self.title = @"余额明细";
    } else if ([_type isEqualToString:@"4"]) {
        self.title = @"成长值明细";
    } else if ([_type isEqualToString:@"5"]) {
        self.title = @"线下充值明细";
    } else if ([_type isEqualToString:@"6"]) {
        self.title = @"赠送明细";
    } else if ([_type isEqualToString:@"7"]) {
        self.title = @"蓝券消费明细";
    }
    else if ([_type isEqualToString:@"8"]) {
        self.title = @"黄券发放明细";
    }
    else if ([_type isEqualToString:@"9"]) {
        self.title = @"银两明细";
    }
    else if ([_type isEqualToString:@"10"]) {
        self.title = @"兑换记录";
    }
    if (![_type isEqualToString:@"10"]) {
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:17],
           NSForegroundColorAttributeName:[UIColor blackColor]}];
    }
   
}
- (void)viewDidAppear:(BOOL)animated {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)initRefresh
{
    __block SShopCouponUseCan * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)showModel {
    if ([_type isEqualToString:@"1"] || [_type isEqualToString:@"6"]) {
        //购物券使用明细
        SUserVouchersLog * list = [[SUserVouchersLog alloc] init];
        list.p = [@(page) stringValue];
        
        if ([_type isEqualToString:@"6"]) {
            list.giveStatus = @"1";
        }
        
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserVouchersLogSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserVouchersLog * list = (SUserVouchersLog *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"2"]) {
        //积分明细
        SUserIntegralLog * list = [[SUserIntegralLog alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserIntegralLogSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserIntegralLog * list = (SUserIntegralLog *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"3"]) {
        //余额明细
        SUserBalanceBalanceLog * list = [[SUserBalanceBalanceLog alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserBalanceBalanceLogSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserBalanceBalanceLog * list = (SUserBalanceBalanceLog *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"4"]) {
        //成长值明细
        SUserUserDevelopLog * list = [[SUserUserDevelopLog alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserUserDevelopLogSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserUserDevelopLog * list = (SUserUserDevelopLog *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"5"]) {
        //线下充值列表
        SUserBalanceUnderMoneys * list = [[SUserBalanceUnderMoneys alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserBalanceUnderMoneysSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserBalanceUnderMoneys * list = (SUserBalanceUnderMoneys *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    if ([_type isEqualToString:@"7"]) {
        SUserBalanceUnderMoneys * list = [[SUserBalanceUnderMoneys alloc] init];
        list.p = [@(page) stringValue];
        list.voucher_id = _voucher_id;
        list.status_type = @"1";
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserBalanceUnderMoneysSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
         
            SUserBalanceUnderMoneys * list = (SUserBalanceUnderMoneys *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
         
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
         
                } else {
         
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    if( [_type isEqualToString:@"8"])
    {
        //黄券使用明细
        ApplyYellowListModel * list = [[ApplyYellowListModel alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list ApplyYellowListModelSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            ApplyYellowListModel * list = (ApplyYellowListModel *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
       
    if( [_type isEqualToString:@"9"]||[_type isEqualToString:@"10"])
    {
        //银两使用明细
        YinLiangWebInfo * list = [[YinLiangWebInfo alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list YinLiangWebInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            YinLiangWebInfo * list = (YinLiangWebInfo *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.info];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.info.count) {

                    [arr addObjectsFromArray:list.data.info];
                    [_mTable.mj_footer endRefreshing];

                } else {

                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_type isEqualToString:@"1"] || [_type isEqualToString:@"6"]) {
        SUserVouchersLog * list = arr[section];
        if (arr.count == 0) {
            placeholderView.hidden = NO;
        } else {
            placeholderView.hidden = YES;
        }
        return list.list.count;
    }
    if ([_type isEqualToString:@"2"]) {
        SUserIntegralLog * list = arr[section];
        if (arr.count == 0) {
            placeholderView.hidden = NO;
        } else {
            placeholderView.hidden = YES;
        }
        return list.list.count;
    }
    if ([_type isEqualToString:@"3"]) {
        SUserBalanceBalanceLog * list = arr[section];
        if (arr.count == 0) {
            placeholderView.hidden = NO;
        } else {
            placeholderView.hidden = YES;
        }
        return list.list.count;
    }
    if ([_type isEqualToString:@"5"]) {
        SUserBalanceUnderMoneys * list = arr[section];
        if (arr.count == 0) {
            placeholderView.hidden = NO;
        } else {
            placeholderView.hidden = YES;
        }
        return list.list.count;
    }
    if ([_type isEqualToString:@"7"]) {
        SUserBalanceUnderMoneys * list = arr[section];
        if (arr.count == 0) {
            placeholderView.hidden = NO;
        } else {
            placeholderView.hidden = YES;
        }
        return list.list.count;
    }
    if ([_type isEqualToString:@"8"]) {
        ApplyYellowListModel * list = arr[section];
        if (arr.count == 0) {
            placeholderView.hidden = NO;
        } else {
            placeholderView.hidden = YES;
        }
        return list.list.count;
    }
    if ([_type isEqualToString:@"9"]||[_type isEqualToString:@"10"]) {
      
        YinLiangWebInfo * list = arr[section];
        if (arr.count == 0) {
            placeholderView.hidden = NO;
        } else {
            placeholderView.hidden = YES;
        }
        return list.list.count;
    }
    SUserUserDevelopLog * list = arr[section];
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return list.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    timeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * time = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 40)];
    [timeView addSubview:time];
    
    if ([_type isEqualToString:@"1"] || [_type isEqualToString:@"6"] || [_type isEqualToString:@"7"]) {
        SUserVouchersLog * list = arr[section];
        time.text = list.time;
    }
    if ([_type isEqualToString:@"2"]) {
        SUserIntegralLog * list = arr[section];
        time.text = list.time;
    }
    if ([_type isEqualToString:@"3"]) {
        SUserBalanceBalanceLog * list = arr[section];
        time.text = list.time;
    }
    if ([_type isEqualToString:@"4"]) {
        SUserUserDevelopLog * list = arr[section];
        time.text = list.time;
    }
    if ([_type isEqualToString:@"5"]) {
        SUserBalanceUnderMoneys * list = arr[section];
        time.text = list.time;
    }
    if ([_type isEqualToString:@"8"]) {
        ApplyYellowListModel * list = arr[section];
        time.text = list.time;
    }
    if ([_type isEqualToString:@"9"]||[_type isEqualToString:@"10"]) {
        YinLiangWebInfo * list = arr[section];
        time.text = list.time;
    }
    time.textColor = WordColor;
    time.font = [UIFont systemFontOfSize:14];
    
    return timeView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SShopCouponUseCanCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SShopCouponUseCanCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([_type isEqualToString:@"1"] || [_type isEqualToString:@"6"]) {
//        cell.inforTitle.hidden = YES;//旧代码

        //购物券使用明细
        SUserVouchersLog * list = arr[indexPath.section];
        SUserVouchersLog * list_sub = list.list[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list_sub.img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.one.text = list_sub.reason;
        cell.two.text = list_sub.create_time;
        if ([list_sub.add_sub integerValue] == 0) {
            cell.three.text = [NSString stringWithFormat:@"+%@",list_sub.money];
        } else {
            cell.three.text = [NSString stringWithFormat:@"-%@",list_sub.money];
        }
        /*
         *查看详情提示文字的显示和隐藏
         */
        if ([_type isEqualToString:@"1"]) {
            if ([list_sub.act_type isEqualToString:@"1"] || [list_sub.act_type isEqualToString:@"2"] || [list_sub.act_type isEqualToString:@"3"] || [list_sub.act_type isEqualToString:@"9"]) {
                cell.inforTitle.hidden = NO;
            }else{
                cell.inforTitle.hidden = YES;
            }
        }
    }
    if ([_type isEqualToString:@"2"]) {
        cell.inforTitle.hidden = YES;

        //积分明细
        SUserIntegralLog * list = arr[indexPath.section];
        SUserIntegralLog * list_sub = list.list[indexPath.row];
        cell.one.text = list_sub.reason;
        cell.two.text = list_sub.create_time;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list_sub.img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list_sub.add_sub integerValue] == 1) {
            cell.three.text = [NSString stringWithFormat:@"+%@",list_sub.use_integral];
        } else {
            cell.three.text = [NSString stringWithFormat:@"-%@",list_sub.use_integral];
        }
        
    }
    if ([_type isEqualToString:@"3"]) {
        cell.inforTitle.hidden = YES;
        //余额明细
        SUserBalanceBalanceLog * list = arr[indexPath.section];
        SUserBalanceBalanceLog * list_sub = list.list[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list_sub.img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.one.text = list_sub.reason;
        cell.two.text = list_sub.create_time;
        if ([list_sub.act_type isEqualToString:@"1"]||[list_sub.act_type isEqualToString:@"17"]||[list_sub.act_type isEqualToString:@"3"]||
            [list_sub.act_type isEqualToString:@"5"]||
            [list_sub.act_type isEqualToString:@"10"]||
            [list_sub.act_type isEqualToString:@"13"]||
            [list_sub.act_type isEqualToString:@"15"]||
            [list_sub.act_type isEqualToString:@"16"]) {
            cell.inforTitle.hidden = NO;
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"查看详情"];
                [AttributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 4)];
            cell.inforTitle.attributedText = AttributedStr;
            
        }
        else
        {
               cell.inforTitle.hidden = YES;
            
        }
        if ([list_sub.add_sub integerValue] == 1) {
        cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
        } else {
        cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
        }
        if ([list_sub.act_type isEqualToString:@"19"]) {
            if ([list_sub.add_sub integerValue] == 1) {
                cell.three.text = [NSString stringWithFormat:@"+%@",list_sub.money];
            } else {
                cell.three.text = [NSString stringWithFormat:@"-%@",list_sub.money];
            }
        }
            
        
//        if ([list_sub.act_type isEqualToString:@"1"]||[list_sub.act_type isEqualToString:@"2"]||[list_sub.act_type isEqualToString:@"11"] || [list_sub.act_type isEqualToString:@"17"] || [list_sub.act_type isEqualToString:@"18"]||[list_sub.act_type isEqualToString:@"20"]||[list_sub.act_type isEqualToString:@"21"]) {
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
//            }
//
//        if ([list_sub.act_type isEqualToString:@"2"]) {
//                cell.inforTitle.hidden = NO;
//                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"查看详情"];
//                [AttributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 4)];
//                cell.inforTitle.attributedText = AttributedStr;
//            } else if ([list_sub.act_type isEqualToString:@"1"]){
//                /*
//                 *当act_type是@"1"的时候,显示查看详情提示文字
//                 */
//                cell.inforTitle.hidden = NO;
//            }else {
//                cell.inforTitle.hidden = YES;
//
//            }
//        }
//      else  if ([list_sub.act_type isEqualToString:@"3"]||[list_sub.act_type isEqualToString:@"4"]) {
//            /*
//             *当act_type是@"3"的时候,显示查看详情提示文字
//             */
//            if ([list_sub.act_type isEqualToString:@"3"]) {
//                cell.inforTitle.hidden = NO;
//            }else{
//                cell.inforTitle.hidden = YES;
//            }
//
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
//            }
//        }
//      else  if ([list_sub.act_type isEqualToString:@"5"]) {
//            /*
//             *当act_type是@"5"的时候,显示查看详情提示文字
//             */
//            cell.inforTitle.hidden = NO;
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
//            }
//        }
//      else  if ([list_sub.act_type isEqualToString:@"6"]) {
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
//            }
//        }
//     else   if ([list_sub.act_type isEqualToString:@"7"] || [list_sub.act_type isEqualToString:@"8"]) {
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
//            }
//        }
//    else    if ([list_sub.act_type isEqualToString:@"9"]) {
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
//            }
//        }
//   else     if ([list_sub.act_type isEqualToString:@"10"]) {
//            /*
//             *显示查看详情提示文字
//             */
//            cell.inforTitle.hidden = NO;
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
//            }
//        }
//        /*
//         *新增判断值13,15,16,又来判断是否是购买拼单购商品
//         *当act_type是"13"/"15"/"16"的时候,显示查看详情提示文字
//         */
//     else   if ([list_sub.act_type isEqualToString:@"13"] || [list_sub.act_type isEqualToString:@"15"] || [list_sub.act_type isEqualToString:@"16"] ) {
//            cell.inforTitle.hidden = NO;
//            /*
//             *设置显示使用的余额金额
//             */
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
//            }
//        }
//     else   if ([list_sub.act_type isEqualToString:@"19"] ) {
//            cell.inforTitle.hidden = YES;
//
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"-%@",list_sub.money];
//            }
//        }
//        else
//        {
//            cell.inforTitle.hidden = YES;
//
//            if ([list_sub.add_sub integerValue] == 1) {
//                cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
//            } else {
//                cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
//            }
//
//        }
        
        
    }
    if ([_type isEqualToString:@"4"]) {
        cell.inforTitle.hidden = YES;

        //成长明细
        SUserUserDevelopLog * list = arr[indexPath.section];
        SUserUserDevelopLog * list_sub = list.list[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list_sub.img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.one.text = list_sub.reason;
        cell.two.text = list_sub.create_time;
        cell.three.text = [NSString stringWithFormat:@"+%@",list_sub.get_point];
    }
    if ([_type isEqualToString:@"5"]) {
        //线下充值列表
        SUserBalanceUnderMoneys * list = arr[indexPath.section];
        SUserBalanceUnderMoneys * list_sub = list.list[indexPath.row];
        cell.one.text = @"线下充值";
        cell.two.text = list_sub.create_time;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list_sub.img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.three.text = [NSString stringWithFormat:@"+￥%@",list_sub.money];
        
        cell.inforTitle.hidden = NO;
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"查看详情"];
        [AttributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 4)];
        cell.inforTitle.attributedText = AttributedStr;
    }
    
    if ([_type isEqualToString:@"7"]) {
        cell.inforTitle.hidden = YES;
        
        //购物券使用明细
        SUserBalanceUnderMoneys * list = arr[indexPath.section];
        SUserBalanceUnderMoneys * list_sub = list.list[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list_sub.img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.one.text = list_sub.reason;
        cell.two.text = list_sub.create_time;
      
        cell.three.text = [NSString stringWithFormat:@"-%@",list_sub.voucher_price];
    }
    if ([_type isEqualToString:@"8"]) {
        cell.inforTitle.hidden = YES;
        
        //购物券使用明细
        ApplyYellowListModel * list = arr[indexPath.section];
        ApplyYellowListModel * list_sub = list.list[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list_sub.img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.one.text = list_sub.reason;
        cell.two.text = list_sub.create_time;
       
        if ([list_sub.add_sub integerValue] == 0) {
                            cell.three.text = [NSString stringWithFormat:@"￥+%@",list_sub.money];
                        } else {
                            cell.three.text = [NSString stringWithFormat:@"￥-%@",list_sub.money];
                        }
       if ([list_sub.act_type isEqualToString:@"2"] )
       {
           cell.inforTitle.hidden = NO;
           NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"查看详情"];
           [AttributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 4)];
           cell.inforTitle.attributedText = AttributedStr;
       }
        else
        {
             cell.inforTitle.hidden = YES;
        }
        
  
    }
    if ([_type isEqualToString:@"9"]||[_type isEqualToString:@"10"]) {
        cell.inforTitle.hidden = YES;
        YinLiangWebInfo * list = arr[indexPath.section];
        YinLiangWebInfo * list_sub = list.list[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list_sub.img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.one.text = list_sub.desc;
        cell.two.text = list_sub.create_time;
        if ([list_sub.sub_type isEqualToString:@"1"]) {
             cell.three.text = [NSString stringWithFormat:@"+%@",list_sub.money];
        }
        else
        {
              cell.three.text = [NSString stringWithFormat:@"-%@",list_sub.money];
        }
       
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_type isEqualToString:@"1"]) {
        
        //购物券使用明细
        SUserVouchersLog * list = arr[indexPath.section];
        SUserVouchersLog * list_sub = list.list[indexPath.row];
        if ([list_sub.chat isEqualToString:@""] || list_sub.chat == nil) {
            if ([list_sub.act_type isEqualToString:@"1"]) {
                //会员卡
                SMemberOrderInfor * infor = [[SMemberOrderInfor alloc] init];
                infor.order_id = list_sub.order_id;
                infor.order_status = list_sub.order_status;
                infor.member_coding = list_sub.member_coding;
                infor.type = @"会员卡";
                [self.navigationController pushViewController:infor animated:YES];
            }
            if ([list_sub.act_type isEqualToString:@"2"] || [list_sub.act_type isEqualToString:@"3"]) {
                SOrderInfor * infor = [[SOrderInfor alloc] init];
                infor.order_id = list_sub.order_id;
                infor.order_type = @"普通商品";
                [self.navigationController pushViewController:infor animated:YES];
            }
            /*
             *购物券用于拼单购时,也可以点击查看详情
             */
            else if ([list_sub.act_type isEqualToString:@"9"]) {
                SOrderInfor * infor = [[SOrderInfor alloc] init];
                infor.order_id = list_sub.order_id;
                infor.order_type = @"拼单购";
                [self.navigationController pushViewController:infor animated:YES];
            }
        } else {
            [MBProgressHUD showError:list_sub.chat toView:self.view];
        }
    }
    if ([_type isEqualToString:@"2"]) {
        return;
        //积分明细
//        SUserIntegralLog * list = arr[indexPath.section];
//        SUserIntegralLog * list_sub = list.list[indexPath.row];
//        if ([list_sub.chat isEqualToString:@""] || list_sub.chat == nil) {
//            SOrderInfor * infor = [[SOrderInfor alloc] init];
//            if (list_sub.order_id == nil || [list_sub.order_id isEqualToString:@""] || [list_sub.order_id isEqualToString:@"0"]) {
//                return;
//            }
//            infor.order_id = list_sub.order_id;
//            infor.order_type = @"普通商品";
//            [self.navigationController pushViewController:infor animated:YES];
//        } else {
//            [MBProgressHUD showError:list_sub.chat toView:self.view];
//        }
    }
    if ([_type isEqualToString:@"3"]) {
        
        //余额明细
        SUserBalanceBalanceLog * list = arr[indexPath.section];
        SUserBalanceBalanceLog * list_sub = list.list[indexPath.row];
        
        if ([list_sub.chat isEqualToString:@""] || list_sub.chat == nil) {
            if ([list_sub.act_type isEqualToString:@"1"]) {
                //会员卡
                SMemberOrderInfor * infor = [[SMemberOrderInfor alloc] init];
                infor.order_id = list_sub.order_id;
                infor.order_status = list_sub.order_status;
                infor.member_coding = list_sub.member_coding;
                infor.type = @"充值";
                [self.navigationController pushViewController:infor animated:YES];
            }
            if ([list_sub.act_type isEqualToString:@"3"] || [list_sub.act_type isEqualToString:@"5"]) {
                SOrderInfor * infor = [[SOrderInfor alloc] init];
                infor.order_id = list_sub.order_id;
                infor.order_type = @"普通商品";
                [self.navigationController pushViewController:infor animated:YES];
            }else if ([list_sub.act_type isEqualToString:@"13"] || [list_sub.act_type isEqualToString:@"15"] || [list_sub.act_type isEqualToString:@"16"]){
                /*
                 *当act_type是@"13"时,即是购买的拼单购商品,可以查看订单详情
                 */
                SOrderInfor * infor = [[SOrderInfor alloc] init];
                infor.order_id = list_sub.order_id;
                infor.order_type = @"拼单购";
                [self.navigationController pushViewController:infor animated:YES];
            }
            if ([list_sub.act_type isEqualToString:@"10"]) {
                //会员卡
                SMemberOrderInfor * infor = [[SMemberOrderInfor alloc] init];
                infor.order_id = list_sub.order_id;
                infor.order_status = list_sub.order_status;
                infor.member_coding = list_sub.member_coding;
                infor.type = @"会员卡";
                [self.navigationController pushViewController:infor animated:YES];
            }
            
            if ([list_sub.act_type isEqualToString:@"17"]){ //线下详情
               
                SMemberOrderInfor * infor = [[SMemberOrderInfor alloc] init];
                infor.order_id = list_sub.order_id;
                infor.type = @"线下商铺";
                infor.pay_status = @"1";
                infor.common_status = 1;
                infor.status = @"10086";
                [self.navigationController pushViewController:infor animated:YES];
                
            }
            
        } else {
            [MBProgressHUD showError:list_sub.chat toView:self.view];
        }
        
        
    }
    if ([_type isEqualToString:@"5"]) {
        
        SUserBalanceUnderMoneys * list = arr[indexPath.section];
        SUserBalanceUnderMoneys * list_sub = list.list[indexPath.row];
        
        if ([list_sub.chat isEqualToString:@""] || list_sub.chat == nil) {
            SShopCouponUseCan_infor * infor = [[SShopCouponUseCan_infor alloc] init];
            infor.act_id = list_sub.id;
            [self.navigationController pushViewController:infor animated:YES];
        } else {
            [MBProgressHUD showError:list_sub.chat toView:self.view];
        }
        
    }
    
    if ([_type isEqualToString:@"6"]) {
        //选中赠送蓝券明细
        SUserVouchersLog * list = arr[indexPath.section];
        SUserVouchersLog * list_sub = list.list[indexPath.row];
        SShopCouponUseCan * useCan = [[SShopCouponUseCan alloc] init];
        useCan.type = @"7";
        useCan.voucher_id = list_sub.log_id;
        [self.navigationController pushViewController:useCan animated:YES];
    }
    if ([_type isEqualToString:@"8"]) {
        //选中赠送蓝券明细
        ApplyYellowListModel * list = arr[indexPath.section];
        ApplyYellowListModel * list_sub = list.list[indexPath.row];
        SOrderInfor * infor = [[SOrderInfor alloc] init];
        infor.order_id = list_sub.order_id;
        infor.order_type = @"普通商品";
        [self.navigationController pushViewController:infor animated:YES];
    }
    
}
@end
