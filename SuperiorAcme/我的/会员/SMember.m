//
//  SMember.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//
#define NAVBAR_CHANGE_POINT 50

#import "SMember.h"
#import "SMemberCell.h"
#import "SMember_top.h"
#import "SPay.h"

#import "SUserUserDevelop.h"
#import "SShopCouponUseCan.h"
#import "SUserUserRank.h"

@interface SMember () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SMember

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SMemberCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SMemberCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    SMember_top * top = [[SMember_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/414*251 + ScreenW/69*13 + 10)];
    _mTable.tableHeaderView = top;
    
    top.memberR_Image.layer.masksToBounds = YES;
    top.memberR_Image.layer.cornerRadius = top.memberR_Image.frame.size.width/2;
    
    if (_type == NO) {
        
        SUserUserRank * rank = [[SUserUserRank alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [rank sUserUserRankSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserUserRank * rank = (SUserUserRank *)data;
            [top.headerImage sd_setImageWithURL:[NSURL URLWithString:rank.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            [top.memberR_Image sd_setImageWithURL:[NSURL URLWithString:rank.data.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            
            top.memberR_title.text = rank.data.my_rank;
            top.num.text = [NSString stringWithFormat:@"%@",rank.data.end_time];
            arr = rank.data.rank_list;
            [_mTable reloadData];
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];

    } else {
        
        UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rigthBtn.frame = CGRectMake(0, 0, 44, 50);
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        [rigthBtn setTitle:@"明细" forState:UIControlStateNormal];
        rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rigthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        SUserUserDevelop * deve = [[SUserUserDevelop alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [deve sUserUserDevelopSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        
            SUserUserDevelop * deve = (SUserUserDevelop *)data;
            [top.headerImage sd_setImageWithURL:[NSURL URLWithString:deve.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            [top.memberR_Image sd_setImageWithURL:[NSURL URLWithString:deve.data.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            
            top.memberR_title.text = deve.data.level;
            top.num.text = [NSString stringWithFormat:@"%@年年度成长值%@",deve.data.year,deve.data.my_point];
            arr = deve.data.level_list;
            [_mTable reloadData];
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
#pragma mark - 成长值明细
- (void)rigthBtnClick {
    SShopCouponUseCan * useCan = [[SShopCouponUseCan alloc] init];
    useCan.type = @"4";
    [self.navigationController pushViewController:useCan animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白
    [self scrollViewDidScroll:_mTable];
    
    if (_type == NO) {
        self.title = @"会员等级";
    } else {
        self.title = @"会员成长";
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
    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
        _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=200-64){
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SMemberCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SMemberCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_type == NO) {
        SUserUserRank * list = arr[indexPath.row];
        cell.level_name.text = list.rank_name;
        cell.points.text = list.desc;
        if (indexPath.row == 0 || indexPath.row == 1) {
            if ([list.is_get isEqualToString:@"0"]) {
                cell.is_get.text = @"未获得";
                cell.is_get.textColor = [UIColor redColor];
            } else {
                cell.is_get.text = @"已获得";
                cell.is_get.textColor = WordColor;
            }
        } else {
            cell.is_get.text = list.fee;
            cell.is_get.textColor = [UIColor redColor];
        }
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    } else {
        SUserUserDevelop * list = arr[indexPath.row];
        cell.level_name.text = list.level_name;
        if (list.min_points == nil || list.max_points == nil) {
            cell.points.text = @"无";
        } else {
            cell.points.text = [NSString stringWithFormat:@"%@-%@成长值",list.min_points,list.max_points];
        }
        if ([list.is_get isEqualToString:@"0"]) {
            cell.is_get.text = @"未获得";
            cell.is_get.textColor = [UIColor redColor];
        } else {
            cell.is_get.text = @"已获得";
            cell.is_get.textColor = WordColor;
        }
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    SPay * pay = [[SPay alloc] init];
//    pay.type = YES;
//    [self.navigationController pushViewController:pay animated:YES];
}
@end
