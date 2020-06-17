//
//  SRecommend.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRecommend.h"
#import "SRecommendCell.h"

#import "SUserMyRecommend.h"
#import "CQPlaceholderView.h"
/*
 *变更推荐界面内容的布局
 */
#import "SRecommendVersionOneCell.h"

@interface SRecommend () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView *placeholderView;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end
/*
 *添加新Cell的ID
 */
static NSString * RecommendNewCellID = @"RecommendNewCellID";

@implementation SRecommend

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    
//    [_mTable registerNib:[UINib nibWithNibName:@"SRecommendCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRecommendCell"];
    /*
     *通过nib文件,注册新的Cell
     */
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([SRecommendVersionOneCell class]) bundle:nil] forCellReuseIdentifier:RecommendNewCellID];
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
    __block SRecommend * blockSelf = self;
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
    SUserMyRecommend * list = [[SUserMyRecommend alloc] init];
    if (_type == NO) {
        list.parent_id = @"";
    } else {
        list.parent_id = _parent_id;
    }
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sUserMyRecommendSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SUserMyRecommend * list = (SUserMyRecommend *)data;
        
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
    
    if (_type == NO) {
        self.title = @"我推荐的人";
    } else {
        self.title = [NSString stringWithFormat:@"%@推荐的人",_name];
    }
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 70;
    return 184;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    SRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SRecommendCell" forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    SUserMyRecommend * list = arr[indexPath.row];
//    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
//    cell.nickname.text = list.nickname;
//    cell.phone.text = list.phone;
//    cell.create_time.text = [NSString stringWithFormat:@"推荐时间\n%@",list.create_time];
//    cell.recommend_num.text = [NSString stringWithFormat:@"成功推荐%@人",list.recommend_num];
    
    
    /*
     *变更推荐的人界面的Cell的UI布局
     *自定义 SRecommendVersionOneCell 类
     */
    SRecommendVersionOneCell * cell = [tableView dequeueReusableCellWithIdentifier:RecommendNewCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userRecommend = arr[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     *添加是否有权限无线查看代码
     */
    if (_infinite.integerValue == 0) {//当_infinite值为0时,无权限无线查看
        return;
    }
    SUserMyRecommend * list = arr[indexPath.row];
    if (list.id != nil && ![list.id isEqualToString:@""]) {
        SRecommend * recom = [[SRecommend alloc] init];
        recom.name = list.nickname;
        recom.parent_id = list.id;
        recom.type = YES;
        [self.navigationController pushViewController:recom animated:YES];
    }
    
}
@end
