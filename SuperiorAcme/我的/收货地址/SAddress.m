//
//  SAddress.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddress.h"
#import "SAddressCell.h"
#import "SAddressSafe.h"
#import "SAddress_Top.h"
#import "SAddressAddressList.h"
#import "CQPlaceholderView.h"
#import "SAddressSetDefault.h"
#import "SAddressDelAddress.h"

@interface SAddress () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView *placeholderView;
    SAddress_Top * top;
    BOOL def_isno;//是否有默认地址
    NSString * top_address_id;//默认地址id
    
    NSString * def_province;
    NSString * def_city;
    NSString * def_area;
    NSString * def_address;
    NSString * def_address_id;
    NSString * def_receiver;
    NSString * def_phone;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation SAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SAddressCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SAddressCell"];
    top = [[SAddress_Top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 160)];
    [top.top_oneBtn addTarget:self action:@selector(top_oneBtn) forControlEvents:UIControlEventTouchUpInside];
    [top.top_twoBtn addTarget:self action:@selector(top_twoBtn) forControlEvents:UIControlEventTouchUpInside];
    [top.choiceBtn addTarget:self action:@selector(choiceBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if (_choice_isno == NO) {
        top.choiceBtn.hidden = YES;
    }


    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    
    
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)viewDidAppear:(BOOL)animated {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)initRefresh
{
    __block SAddress * blockSelf = self;
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
- (void)choiceBackBtnClick {
    if (_choice_isno == YES) {
        if (self.SAddress_Choice) {
            self.SAddress_Choice(def_province,def_city,def_area,def_address,def_address_id,def_receiver,def_phone);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)showModel {
    SAddressAddressList * list = [[SAddressAddressList alloc] init];
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sAddressAddressListSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SAddressAddressList * list = (SAddressAddressList *)data;
        
        def_province = list.data.default_address.province;
        def_city = list.data.default_address.city;
        def_area = list.data.default_address.area;
        def_address = list.data.default_address.address;
        def_address_id = list.data.default_address.address_id;
        def_receiver = list.data.default_address.receiver;
        def_phone = list.data.default_address.phone;
        
        top_address_id = list.data.default_address.address_id;
    
        top.receiver.text = list.data.default_address.receiver;
        top.phone.text = list.data.default_address.phone;
        top.address.text = [NSString stringWithFormat:@"%@%@%@%@ %@",list.data.default_address.province,list.data.default_address.city,list.data.default_address.area,list.data.default_address.street,list.data.default_address.address];
        if ([list.data.default_address.receiver isEqualToString:@""]) {
            def_isno = NO;
            top.hidden = YES;
        } else {
            def_isno = YES;
            top.hidden = NO;
        }
        
        
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data.common_address];
            [_mTable.mj_footer resetNoMoreData];
        } else {
            if (list.data.common_address.count) {
                
                [arr addObjectsFromArray:list.data.common_address];
                [_mTable.mj_footer endRefreshing];
                
            } else {
                
                [_mTable.mj_footer endRefreshingWithNoMoreData];
            }
        }
        if (arr.count != 0 || ![list.data.default_address.receiver isEqualToString:@""]) {
            placeholderView.hidden = YES;
        } else {
            placeholderView.hidden = NO;
        }
        [_mTable.mj_header endRefreshing];
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];

    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"收货地址";
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
//       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }

    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        if (def_isno == NO) {
            return 0.01;
        }
        return 160;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {

        return top;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SAddressCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        [cell.choiceBtn setImage:[UIImage imageNamed:@"方选中"] forState:UIControlStateNormal];
        cell.line.hidden = NO;
    } else {
        [cell.choiceBtn setImage:[UIImage imageNamed:@"方默认"] forState:UIControlStateNormal];
        cell.line.hidden = YES;
    }
    
    //默认
    [cell.choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.choiceBtn setTag:indexPath.row];
    //编辑
    [cell.oneBtn addTarget:self action:@selector(oneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.oneBtn setTag:indexPath.row];
    //删除
    [cell.twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.twoBtn setTag:indexPath.row];
    
    SAddressAddressList * list = arr[indexPath.row];
    cell.receiver.text = list.receiver;
    cell.phone.text = list.phone;
    cell.address.text = [NSString stringWithFormat:@"%@%@%@%@ %@",list.province,list.city,list.area,list.street,list.address];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_choice_isno == YES) {
        SAddressAddressList * list = arr[indexPath.row];
        if (self.SAddress_Choice) {
            self.SAddress_Choice(list.province,list.city,list.area,list.address,list.address_id,list.receiver,list.phone);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - 默认地址
- (void)choiceBtnClick:(UIButton *)btn {
    SAddressAddressList * list = arr[btn.tag];

    SAddressSetDefault * setDef = [[SAddressSetDefault alloc] init];
    setDef.address_id = list.address_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [setDef sAddressSetDefaultSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                page = 1;
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
#pragma mark - 默认地址编辑
- (void)top_oneBtn {
    SAddressSafe * safe = [[SAddressSafe alloc] init];
    safe.type = YES;
    safe.address_id = top_address_id;
    [self.navigationController pushViewController:safe animated:YES];
}
#pragma mark - 默认地址删除
- (void)top_twoBtn {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除本条地址?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        
        SAddressDelAddress * del = [[SAddressDelAddress alloc] init];
        del.address_id = top_address_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [del sAddressDelAddressSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    page = 1;
                    [self showModel];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 编辑
- (void)oneBtnClick:(UIButton *)btn {
    SAddressSafe * safe = [[SAddressSafe alloc] init];
    safe.type = YES;
    SAddressAddressList * list = arr[btn.tag];
    safe.address_id = list.address_id;
    [self.navigationController pushViewController:safe animated:YES];
}
#pragma mark - 删除
- (void)twoBtnClick:(UIButton *)btn {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除本条地址?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        SAddressAddressList * list = arr[btn.tag];
        
        SAddressDelAddress * del = [[SAddressDelAddress alloc] init];
        del.address_id = list.address_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [del sAddressDelAddressSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    page = 1;
                    [self showModel];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark - 新增
- (void)submitBtnClick {
    SAddressSafe * safe = [[SAddressSafe alloc] init];
    [self.navigationController pushViewController:safe animated:YES];
}
@end
