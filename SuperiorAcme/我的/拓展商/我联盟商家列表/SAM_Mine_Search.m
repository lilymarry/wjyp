//
//  SAM_Mine_Search.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/19.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAM_Mine_Search.h"
#import "SAM_MS_Nav.h"
#import "SAM_MineCell.h"
#import "CQPlaceholderView.h"
#import "SAM_M_Edit.h"

@interface SAM_Mine_Search () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    CQPlaceholderView *placeholderView;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation SAM_Mine_Search

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SAM_MineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SAM_MineCell"];
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
}
- (void)createNav  {
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
    
    [rigthBtn setTitle:@"搜索" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    SAM_MS_Nav * search = [[SAM_MS_Nav alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    self.navigationItem.titleView = search;
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    placeholderView.hidden = YES;
    return 7;
}
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    
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
    [cell.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}
- (void)editBtnClick:(UIButton *)btn {
    SAM_M_Edit * m_edit = [[SAM_M_Edit alloc] init];
    [self.navigationController pushViewController:m_edit animated:YES];
}
@end
