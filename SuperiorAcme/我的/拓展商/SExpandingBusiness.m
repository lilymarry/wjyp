//
//  SExpandingBusiness.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/16.
//  Copyright © 2018年 GYM. All rights reserved.
//
#define NAVBAR_CHANGE_POINT 50

#import "SExpandingBusiness.h"
#import "SEBApply.h"//拓展商申请
#import "SEBPay.h"//拓展商支付
#import "SEBCell.h"
#import "SEB_top.h"
#import "SEB_CouponApply.h"//代金券申请
#import "SEB_VA_Record.h"//代金券发放纪录
#import "SEB_VoucherAudit.h"//平台代金券审核
#import "SEB_VoucherMine.h"
#import "SDeveloperAdministration.h"
#import "SAM_Mine.h"//我的联盟商家列表
#import "SAM_MineApply.h"//推荐商家审核
#import "SMateriel.h"//物料申请
#import "SMaterielApply.h"//平台物料申请
#import "SMaterielApply_sub.h"//下级物料审核
#import "SAM_Recommend.h"//联盟商家申请
#import "SEB_VM_Record.h"//联盟商家代金券发放记录
#import "SUnPostStation.h"//无界驿站申请
#import "SEB_VA_Record_PushList.h"//发放代金券

@interface SExpandingBusiness () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *applyStatus;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SExpandingBusiness

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    /*
     * 1.未审核 注意：标题——>拓展商说明  其他状态 标题——>拓展商
     * 2.审核中 拓展商申请信息\n正在审核中\n不要着急哦~    注意：隐藏按钮
     * 3.审核通过 审核通过~\n支付拓展商会费￥10,0000.00\n成为拓展商!       注意：￥xx金额是红色  提交按钮文字更新：支付成为拓展商
     */
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 5;
    
    //~！测试状态3
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"审核通过~\n支付拓展商会费￥10,0000.00\n成为拓展商!"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13, 11)];
    _applyStatus.attributedText = AttributedStr;
    [_submitBtn setTitle:@"支付成为拓展商" forState:UIControlStateNormal];
    
    SEB_top * top = [[SEB_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/125*71)];
    _mTable.tableHeaderView = top;
    if (![_isno isEqualToString:@"1"]) {
        top.groundImage.image = [UIImage imageNamed:@"个人中心蓝色背景"];
    }
    if ([_isno isEqualToString:@"3"]) {
        top.upBtn.hidden = NO;
    }
    [top.upBtn addTarget:self action:@selector(upBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SEBCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SEBCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - 无界驿站申请
- (void)upBtnClick {
    SUnPostStation * unPS = [[SUnPostStation alloc] init];
    [self.navigationController pushViewController:unPS animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白
    adjustsScrollViewInsets_NO(_mTable, self);
    [self scrollViewDidScroll:_mTable];
    
    if ([_isno isEqualToString:@"1"]) {
        self.title = @"拓展商管理中心";
    }
    if ([_isno isEqualToString:@"2"]) {
        self.title = @"拓展员管理中心";
    }
    if ([_isno isEqualToString:@"3"]) {
        self.title = @"联盟商家管理中心";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor redColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        //        home_search.thisSearchView.backgroundColor = [UIColor whiteColor];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        //        home_search.thisSearchView.backgroundColor = [UIColor colorWithRed:239/255.0 green:244/255.0 blue:244/255.0 alpha:0.5];
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(300-64)&&contentOffsety>=0) {
        _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=300-64){
        _mTable.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    }
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submitBtn:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"申请成为拓展商"] || [sender.titleLabel.text isEqualToString:@"申请成为拓展员"]) {
        SEBApply * apply = [[SEBApply alloc] init];
        [self.navigationController pushViewController:apply animated:YES];
    }
    if ([sender.titleLabel.text isEqualToString:@"申请成为联盟商家"]) {
        SAM_Recommend * apply = [[SAM_Recommend alloc] init];
        apply.isno = YES;
        [self.navigationController pushViewController:apply animated:YES];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"支付成为拓展商"]) {
        SEBPay * pay = [[SEBPay alloc] init];
        pay.type = @"1";
        [self.navigationController pushViewController:pay animated:YES];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_isno isEqualToString:@"1"]) {
        return 5;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#pragma mark - 拓展商
    if ([_isno isEqualToString:@"1"]) {
        if (section == 0) {
            return 3;
        }
        if (section == 1) {
            return 2;
        }
        if (section == 2) {
            return 2;
        }
        if (section == 3) {
            return 1;
        }
        if (section == 4) {
            return 3;
        }
    }
    if ([_isno isEqualToString:@"2"]) {
#pragma mark - 拓展员
        if (section == 0) {
            return 3;
        }
        if (section == 1) {
            return 2;
        }
        if (section == 2) {
            return 2;
        }
    }
#pragma mark - 联盟商家
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEBCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SEBCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([_isno isEqualToString:@"1"]) {
        NSArray * arr = @[@[@"代金券申请",@"平台代金券审核",@"我的代金券"],@[@"代金券审核",@"代金券发放记录"],@[@"联盟商家列表",@"推荐商家审核"],@[@"拓展员管理"],@[@"物料申请",@"平台物料审核",@"下级物料审核"]];
        cell.thisTItle.text = arr[indexPath.section][indexPath.row];
    }
    if ([_isno isEqualToString:@"2"]) {
        NSArray * arr = @[@[@"代金券申请",@"代金券审核",@"代金券发放记录"],@[@"联盟商家列表",@"推荐商家审核"],@[@"物料申请",@"物料审核"]];
        cell.thisTItle.text = arr[indexPath.section][indexPath.row];
    }
    if ([_isno isEqualToString:@"3"]) {
        NSArray * arr = @[@[@"代金券申请",@"代金券审核"],@[@"发放代金券",@"发放记录"],@[@"物料申请",@"物料审核"]];
        cell.thisTItle.text = arr[indexPath.section][indexPath.row];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//拓展商
    if ([_isno isEqualToString:@"1"]) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
#pragma mark - 代金券申请
                SEB_CouponApply * eb_ca = [[SEB_CouponApply alloc] init];
                [self.navigationController pushViewController:eb_ca animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 平台代金券审核
                SEB_VoucherAudit * ev_va = [[SEB_VoucherAudit alloc] init];
                ev_va.type = @"1";
                [self.navigationController pushViewController:ev_va animated:YES];
            }
            if (indexPath.row == 2) {
#pragma mark - 我的代金券
                SEB_VoucherMine * eb_vm = [[SEB_VoucherMine alloc] init];
                [self.navigationController pushViewController:eb_vm animated:YES];
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
#pragma mark - 代金券审核
                SEB_VoucherAudit * ev_va = [[SEB_VoucherAudit alloc] init];
                ev_va.type = @"2";
                [self.navigationController pushViewController:ev_va animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 代金券发放纪录
                SEB_VA_Record * va_record = [[SEB_VA_Record alloc] init];
                [self.navigationController pushViewController:va_record animated:YES];
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
#pragma mark - 联盟商家列表
                SAM_Mine * am_mine = [[SAM_Mine alloc] init];
                [self.navigationController pushViewController:am_mine animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 推荐商家审核
                SAM_MineApply * am_ma = [[SAM_MineApply alloc] init];
                [self.navigationController pushViewController:am_ma animated:YES];
            }
        }
        if (indexPath.section == 3) {
#pragma mark - 拓展员管理
            SDeveloperAdministration * da = [[SDeveloperAdministration alloc] init];
            da.s_eb = self;
            [self.navigationController pushViewController:da animated:YES];
        }
        if (indexPath.section == 4) {
            if (indexPath.row == 0) {
#pragma mark - 物料申请
                SMateriel * mater = [[SMateriel alloc] init];
                [self.navigationController pushViewController:mater animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 平台物料审核
                SMaterielApply * ma = [[SMaterielApply alloc] init];
                [self.navigationController pushViewController:ma animated:YES];
            }
            if (indexPath.row == 2) {
#pragma mark - 下级物料审核
                SMaterielApply_sub * ma_sub = [[SMaterielApply_sub alloc] init];
                [self.navigationController pushViewController:ma_sub animated:YES];
            }
        }
    }
//拓展员
    if ([_isno isEqualToString:@"2"]) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
#pragma mark - 代金券申请
                SEB_CouponApply * eb_ca = [[SEB_CouponApply alloc] init];
                [self.navigationController pushViewController:eb_ca animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 代金券审核
                SEB_VoucherAudit * ev_va = [[SEB_VoucherAudit alloc] init];
                ev_va.type = @"2";
                [self.navigationController pushViewController:ev_va animated:YES];
            }
            if (indexPath.row == 2) {
#pragma mark - 代金券发放纪录
                SEB_VA_Record * va_record = [[SEB_VA_Record alloc] init];
                [self.navigationController pushViewController:va_record animated:YES];
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
#pragma mark - 联盟商家列表
                SAM_Mine * am_mine = [[SAM_Mine alloc] init];
                [self.navigationController pushViewController:am_mine animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 推荐商家审核
                SAM_MineApply * am_ma = [[SAM_MineApply alloc] init];
                [self.navigationController pushViewController:am_ma animated:YES];
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
#pragma mark - 物料申请
                SMateriel * mater = [[SMateriel alloc] init];
                [self.navigationController pushViewController:mater animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 平台物料审核
                SMaterielApply * ma = [[SMaterielApply alloc] init];
                ma.isno = _isno;
                [self.navigationController pushViewController:ma animated:YES];
            }
        }
    }
//联盟商家
    if ([_isno isEqualToString:@"3"]) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
#pragma mark - 代金券申请
                SEB_CouponApply * eb_ca = [[SEB_CouponApply alloc] init];
                [self.navigationController pushViewController:eb_ca animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 代金券审核
                SEB_VoucherAudit * ev_va = [[SEB_VoucherAudit alloc] init];
                ev_va.type = @"2";
                [self.navigationController pushViewController:ev_va animated:YES];
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
#pragma mark - 发放代金券
                SEB_VA_Record_PushList * ev_va_rp = [[SEB_VA_Record_PushList alloc] init];
                [self.navigationController pushViewController:ev_va_rp animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 发放记录
                SEB_VM_Record * record = [[SEB_VM_Record alloc] init];
                [self.navigationController pushViewController:record animated:YES];
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
#pragma mark - 物料申请
                SMateriel * mater = [[SMateriel alloc] init];
                [self.navigationController pushViewController:mater animated:YES];
            }
            if (indexPath.row == 1) {
#pragma mark - 平台物料审核
                SMaterielApply * ma = [[SMaterielApply alloc] init];
                ma.isno = _isno;
                [self.navigationController pushViewController:ma animated:YES];
            }
        }
    }
}
@end
