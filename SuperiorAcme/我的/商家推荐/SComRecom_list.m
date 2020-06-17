//
//  SComRecom_list.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SComRecom_list.h"
#import "SComRecom.h"
#import "SComRecom_listCell.h"
#import "SComRecom_listInfor.h"
#import "SUserReferList.h"
#import "CQPlaceholderView.h"

@interface SComRecom_list () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    NSArray * arr;
    CQPlaceholderView * placeholderView;

}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation SComRecom_list

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SComRecom_listCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SComRecom_listCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    [self showModel];
}
- (void)showModel {
    SUserReferList * list = [[SUserReferList alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sUserReferListSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SUserReferList * list = (SUserReferList *)data;
        arr = list.data;
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
    
    self.title = @"线上商城商家推荐";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)viewDidAppear:(BOOL)animated {
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
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)submitBtnClick {
    SComRecom * com = [[SComRecom alloc] init];
    [self.navigationController pushViewController:com animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SComRecom_listCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SComRecom_listCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SUserReferList * list = arr[indexPath.section];
    [cell.product_pic sd_setImageWithURL:[NSURL URLWithString:list.product_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.name.text = list.name;
    cell.create_time.text = list.create_time;
    
    if ([list.status isEqualToString:@"0"]) {
        cell.thisStatus.text = @"待客服审核";
    }
    if ([list.status isEqualToString:@"1"]) {
        cell.thisStatus.text = @"待招商审核";
    }
    if ([list.status isEqualToString:@"2"]) {
        cell.thisStatus.text = [NSString stringWithFormat:@"客服审核未通过"];
    }
    if ([list.status isEqualToString:@"3"]) {
        cell.thisStatus.text = [NSString stringWithFormat:@"招商审核未通过"];
    }
    if ([list.status isEqualToString:@"4"]) {
        cell.thisStatus.text = @"待入驻";
    }
    if ([list.status isEqualToString:@"5"]) {
        cell.thisStatus.text = [NSString stringWithFormat:@"入驻审核未通过"];
    }
    if ([list.status isEqualToString:@"6"]) {
        cell.thisStatus.text = @"入驻成功";
    }
    if ([list.status isEqualToString:@"7"]) {
        cell.thisStatus.text = @"入驻待审核";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SUserReferList * list = arr[indexPath.section];

    SComRecom_listInfor * infor = [[SComRecom_listInfor alloc] init];
    infor.refer_id = list.refer_id;
    [self.navigationController pushViewController:infor animated:YES];
}
@end
