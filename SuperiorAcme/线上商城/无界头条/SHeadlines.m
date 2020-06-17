//
//  SHeadlines.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/20.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHeadlines.h"
#import "SHeadlinesCell.h"
#import "SHeadlines_infor.h"
#import "SIndexHeadLineList.h"
#import "CQPlaceholderView.h"

@interface SHeadlines () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView *placeholderView;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SHeadlines

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SHeadlinesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHeadlinesCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)initRefresh
{
    __block SHeadlines * blockSelf = self;
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
    SIndexHeadLineList * list = [[SIndexHeadLineList alloc] init];
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sIndexHeadLineListSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SIndexHeadLineList * list = (SIndexHeadLineList *)data;
        
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"无界头条";
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
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (arr.count != 0) {
        placeholderView.hidden = YES;
    } else {
        placeholderView.hidden = NO;
    }
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHeadlinesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SHeadlinesCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SIndexHeadLineList * list = arr[indexPath.section];
    cell.thisTitle.text = list.title;
    cell.source.text = [NSString stringWithFormat:@"来源：%@",list.source];
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:list.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SIndexHeadLineList * list = arr[indexPath.section];

    SHeadlines_infor * info = [[SHeadlines_infor alloc] init];
    info.headlines_id = list.headlines_id;
    [self.navigationController pushViewController:info animated:YES];
}
@end
