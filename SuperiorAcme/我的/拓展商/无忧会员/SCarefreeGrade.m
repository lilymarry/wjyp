//
//  SCarefreeGrade.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCarefreeGrade.h"
#import "SCarefreeGradeCell.h"
#import "SCarefreeMember.h"
#import "SCarefreeGrade_top.h"
#import "SUserUserCard.h"
#import "SMemberOrderMess.h"
#import "GYChangeTextView.h"

@interface SCarefreeGrade () <UITableViewDelegate,UITableViewDataSource,GYChangeTextViewDelegate>
{
    NSArray * arr;
    GYChangeTextView * tView;
    SCarefreeGrade_top * top;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UIView *upView;
@end

@implementation SCarefreeGrade

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    
    
    top = [[SCarefreeGrade_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 90)];
    _mTable.tableHeaderView = top;
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SCarefreeGradeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SCarefreeGradeCell"];
//
//    SMemberOrderMess * mess = [[SMemberOrderMess alloc] init];
//    [mess sMemberOrderMessSuccess:^(NSString *code, NSString *message, id data) {
//
//        NSMutableArray * titleArr = [[NSMutableArray alloc] init];
//        NSMutableArray * subArr = [[NSMutableArray alloc] init];
//
//        SMemberOrderMess * mess = (SMemberOrderMess *)data;
//        for (SMemberOrderMess * mess_sub in mess.data) {
//            if ([mess_sub.type isEqualToString:@"1"]) {
//                [titleArr addObject:mess_sub.content];
//            } else {
//                [subArr addObject:mess_sub.content];
//            }
//        }
//
//        //1:
//        [tView removeFromSuperview];
//        tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(50, 0, ScreenW - 50 - 10, 50)];
//        tView.delegate = self;
//        [_upView addSubview:tView];
//        if (titleArr.count != 0) {
//            [tView animationWithTexts:titleArr];
//        }
//        //2:
//        top.thisTitle.text = subArr.firstObject;
//
//    } andFailure:^(NSError *error) {
//        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"会员等级";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidAppear:(BOOL)animated {
    SUserUserCard * user = [[SUserUserCard alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [user sUserUserCardSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SUserUserCard * user = (SUserUserCard *)data;
        arr = user.data.list;
        [_mTable reloadData];
        
        NSMutableArray * titleArr = [[NSMutableArray alloc] init];
        NSMutableArray * subArr = [[NSMutableArray alloc] init];
        
        for (SUserUserCard * mess_sub in user.data.advertisement) {
            if ([mess_sub.type isEqualToString:@"1"]) {
                [titleArr addObject:mess_sub.content];
            } else {
                [subArr addObject:mess_sub.content];
            }
        }
        
        //1:
        if(!tView){
            tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(50, 0, ScreenW - 50 - 10, 40)];
            tView.delegate = self;
            [_upView addSubview:tView];
        }
        if (titleArr.count != 0) {
            [tView animationWithTexts:titleArr];
        }
        //2:
        top.thisTitle.text = subArr.firstObject;
        
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (tView) {
        [tView stopAnimation];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ceil((ScreenW - 60)/606*404 + 20);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCarefreeGradeCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SCarefreeGradeCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    SUserUserCard * list = arr[indexPath.row];
    cell.rank_name.text = list.rank_name;
    cell.this_description.text = list.this_description;
    [cell.backImage sd_setImageWithURL:[NSURL URLWithString:list.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

    if ([list.is_get integerValue] == 0) {
//        cell.backImage.image = [UIImage imageNamed:@"卡2"];
        cell.rank_name.textColor = MyYellow;
        cell.this_description.textColor = MyYellow_sub;
        cell.thisR.layer.borderColor = MyYellow.CGColor;
        cell.thisR.textColor = MyYellow;
        cell.is_get.text = [NSString stringWithFormat:@"点击查看%@权益详情",list.rank_name];
        cell.is_get.textColor = MyYellow;
    } else {
//        cell.backImage.image = [UIImage imageNamed:@"卡1"];
        cell.rank_name.textColor = WordColor;
        cell.this_description.textColor = WordColor_sub;
        cell.thisR.layer.borderColor = WordColor_sub.CGColor;
        cell.thisR.textColor = WordColor_sub;
        if ([list.over_time integerValue] == 0) {
            cell.is_get.text = @"永久有效";
        } else {
            cell.is_get.text = [NSString stringWithFormat:@"%@ 到期",list.over_time];
        }
        cell.is_get.textColor = WordColor;

    }
    if ([list.is_discount integerValue] == 0) {
        cell.is_discount.hidden = YES;
    } else if ([list.is_discount integerValue] == 1) {
        cell.is_discount.image = [UIImage imageNamed:@"会员等级-惠"];
        cell.is_discount.hidden = NO;
    } else {
        cell.is_discount.image = [UIImage imageNamed:@"会员等级-推"];
        cell.is_discount.hidden = NO;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SUserUserCard * list = arr[indexPath.row];

    SCarefreeMember * member = [[SCarefreeMember alloc] init];
    member.sale_status = list.sale_status;
    member.score_status = list.score_status;
    member.rank_id = list.rank_id;
    member.member_coding = list.member_coding;
    member.rank_name = list.rank_name;
    member.bannerArr = list.abs_url;
    member.thisMoney = list.money;
    member.is_get = list.is_get;
    member.hidesBottomBarWhenPushed = YES;
    member.grade = self;
    [self.navigationController pushViewController:member animated:YES];
}
@end
