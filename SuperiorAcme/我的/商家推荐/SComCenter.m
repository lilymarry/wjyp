//
//  SComCenter.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/29.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SComCenter.h"
#import "SComCenterCell.h"
#import "SComRecom_list.h"
#import "SAllianceMerchant.h"
#import "SExpandingBusiness.h"
#import "SRecommendingAdvertImg.h"

@interface SComCenter () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SComCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    if ([_type isEqualToString:@"1"]) {
        [self showModel];
    } else {
        UIView * top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*740)];
        _mTable.tableHeaderView = top;
        
        UIImageView * topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*740)];
        topImage.image = [UIImage imageNamed:@"轮播图样式1"];
        [top addSubview:topImage];
    }
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SComCenterCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SComCenterCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
//    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if ([_type isEqualToString:@"1"]) {
        self.title = @"商家推荐";
    } else {
        self.title = @"代理加盟";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)showModel {
    SRecommendingAdvertImg * img = [[SRecommendingAdvertImg alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [img sRecommendingAdvertImgSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SRecommendingAdvertImg * img = (SRecommendingAdvertImg *)data;
            arr = img.data;
            [_mTable reloadData];
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_type isEqualToString:@"1"]) {
        return arr.count;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_type isEqualToString:@"1"]) {
        if (indexPath.row == 0) {
            return ceil(ScreenW/750*1058);
        }
        if (indexPath.row == 1) {
            return ceil(ScreenW/750*783);
        }
        if (indexPath.row == 2) {
            return ceil(ScreenW/750*864);
        }
    }
    return ceil(ScreenW/1242*800);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SComCenterCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SComCenterCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([_type isEqualToString:@"1"]) {
        SRecommendingAdvertImg * img = arr[indexPath.row];
        [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:img.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    } else {
        if (indexPath.row == 0) {
            cell.thisImage.image = [UIImage imageNamed:@"Com3"];
        } else {
            cell.thisImage.image = [UIImage imageNamed:@"Com4"];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_type isEqualToString:@"1"]) {
        //商家推荐
        if (indexPath.row == 1) {
#pragma mark - 线上商城商家推荐
            SComRecom_list * com = [[SComRecom_list alloc] init];
            com.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:com animated:YES];
        } else if (indexPath.row == 2) {
#pragma mark - 线下店铺商家推荐
            SAllianceMerchant * am = [[SAllianceMerchant alloc] init];
            am.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:am animated:YES];
        }
    } else if ([_type isEqualToString:@"2"]) {
        //代理加盟
        if (indexPath.row == 0) {
#pragma mark - 拓展员管理中心
            SExpandingBusiness * eb = [[SExpandingBusiness alloc] init];
            eb.isno = @"2";
            eb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:eb animated:YES];
        } else {
#pragma mark - 拓展商管理中心
            SExpandingBusiness * eb = [[SExpandingBusiness alloc] init];
            eb.isno = @"1";
            eb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:eb animated:YES];
        }
    }

}
@end
