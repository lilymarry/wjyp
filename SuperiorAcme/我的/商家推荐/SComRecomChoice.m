//
//  SComRecomChoice.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SComRecomChoice.h"
#import "SComRecomChoiceCell.h"
#import "SUserGetRange.h"

@interface SComRecomChoice () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SComRecomChoice

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SComRecomChoiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SComRecomChoiceCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    SUserGetRange * range = [[SUserGetRange alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [range sUserGetRangeSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserGetRange * range = (SUserGetRange *)data;
            arr = range.data;
            if (_submit_range_id != nil) {
                NSArray * choiceArr = [_submit_range_id componentsSeparatedByString:@","];
                for (SUserGetRange * range_choice in range.data) {
                    for (int i = 0; i < choiceArr.count; i++) {
                        if ([range_choice.cate_id isEqualToString:choiceArr[i]]) {
                            range_choice.isno = YES;
                        }
                    }
                }
            }
            [_mTable reloadData];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
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
    
    self.title = @"选择经营范围";
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
    
    [rigthBtn setTitle:@"确定" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    if ([self isno] == YES) {
        [MBProgressHUD showError:@"请至少选择一种经营范围" toView:self.view];
        return;
    }
    NSMutableArray * id_arr = [[NSMutableArray alloc] init];
    NSMutableArray * name_arr = [[NSMutableArray alloc] init];
    for (SUserGetRange * range in arr) {
        if (range.isno == YES) {
            [id_arr addObject:range.cate_id];
            [name_arr addObject:range.short_name];
        }
    }
    if (self.SComRecomChoiceSuccess) {
        self.SComRecomChoiceSuccess([id_arr componentsJoinedByString:@","],[name_arr componentsJoinedByString:@","]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)isno {
    for (SUserGetRange * range in arr) {
        if (range.isno == YES) {
            return NO;
        }
    }
    return YES;
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
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SComRecomChoiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SComRecomChoiceCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SUserGetRange * range = arr[indexPath.row];
    cell.thisTitle.text = range.short_name;
    if (range.isno == NO) {
        cell.thisR.image = [UIImage imageNamed:@"R默认"];
    } else {
        cell.thisR.image = [UIImage imageNamed:@"R选中"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SUserGetRange * range = arr[indexPath.row];
    if (range.isno == NO) {
        range.isno = YES;
    } else {
        range.isno = NO;
    }
    [_mTable reloadData];
    
}
@end
