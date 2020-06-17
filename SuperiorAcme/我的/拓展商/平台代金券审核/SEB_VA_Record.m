//
//  SEB_VA_Record.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_VA_Record.h"
#import "SAM_MineCell.h"
#import "SEB_VA_Record_infor.h"

@interface SEB_VA_Record () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SEB_VA_Record

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SAM_MineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SAM_MineCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"代金券发放纪录";
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
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setImage:[UIImage imageNamed:@"商家列表-搜索"] forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
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
    return 180;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAM_MineCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SAM_MineCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.editBtn addTarget:self action:@selector(inforBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.editBtn setTitle:@"" forState:UIControlStateNormal];
    [cell.editBtn setImage:[UIImage imageNamed:@"灰色右箭头"] forState:UIControlStateNormal];
    
    return cell;
}
- (void)inforBtnClick:(UIButton *)btn {
    SEB_VA_Record_infor * infor = [[SEB_VA_Record_infor alloc] init];
    [self.navigationController pushViewController:infor animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SEB_VA_Record_infor * infor = [[SEB_VA_Record_infor alloc] init];
    [self.navigationController pushViewController:infor animated:YES];
}
@end
