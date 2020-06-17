//
//  GCustomerServiceType.m
//  SeaMonkey
//
//  Created by TXD_air on 16/10/31.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import "GCustomerServiceType.h"
#import "SAfterSaleBackApplyType.h"//类型列表
#import "SAfterSaleCause.h"//用户:售后服务原因列表

@interface GCustomerServiceType () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation GCustomerServiceType

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self showModel];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_tableView, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_type == 0) {
        //售后类型
        self.title = @"售后类型";
        
    } else if (_type == 1) {
        //货物状态 已收到货 未收到货
        self.title = @"货物状态";
    } else if (_type == 2) {
        //售后原因
        self.title = @"售后原因";

    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)showModel {
    if (_type == 0) {
        //售后类型
        arr = _modelArr;
        
    } else if (_type == 1) {
        //货物状态 已收到货 未收到货
        arr = _modelBrr;
        
    } else if (_type == 2) {
        //售后原因
        SAfterSaleCause * list = [[SAfterSaleCause alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sAfterSaleCauseSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SAfterSaleCause * list = (SAfterSaleCause *)data;
            arr = list.data;
            [_tableView reloadData];
        } andFailure:^(NSError *error) {
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
- (void)leftButtonPressed:(UIButton *)button {
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = WordColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_type == 0) {
        SAfterSaleBackApplyType * list = arr[indexPath.row];
        cell.textLabel.text = list.name;
    }
    if (_type == 1) {
        SAfterSaleBackApplyType * list = arr[indexPath.row];
        cell.textLabel.text = list.name;
    }
    if (_type == 2) {
        SAfterSaleCause * list = arr[indexPath.row];
        cell.textLabel.text = list.name;
    }
    

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.GCustomerServiceType_Type) {
        if (_type == 0) {
            SAfterSaleBackApplyType * list = arr[indexPath.row];
            self.GCustomerServiceType_Type(list.name,list.type_id);
        }
        if (_type == 1) {
            SAfterSaleBackApplyType * list = arr[indexPath.row];
            self.GCustomerServiceType_Type(list.name,list.type_id);
        }
        if (_type == 2) {
            SAfterSaleCause * list = arr[indexPath.row];
            self.GCustomerServiceType_Type(list.name,list.id);
        }

        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
