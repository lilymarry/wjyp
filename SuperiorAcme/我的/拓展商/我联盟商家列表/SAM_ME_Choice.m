//
//  SAM_ME_Choice.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/19.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAM_ME_Choice.h"
#import "SAM_ME_ChoiceCell.h"

@interface SAM_ME_Choice () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SAM_ME_Choice

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SAM_ME_ChoiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SAM_ME_ChoiceCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"选择所属拓展员";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * lefthBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn_sub.frame = CGRectMake(0, 0, 44, 50);
    [lefthBtn_sub setImage:[UIImage imageNamed:@"商家列表-关闭"] forState:UIControlStateNormal];
    lefthBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    [lefthBtn_sub setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn_sub addTarget:self action:@selector(lefthBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    if (_next_isno == NO) {
        lefthBtn_sub.hidden = YES;
    }
    
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    UIBarButtonItem * leftBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn_sub];
    self.navigationItem.leftBarButtonItems = @[leftBtnItem,leftBtnItem_sub];
    
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setImage:[UIImage imageNamed:@"商家列表-搜索"] forState:UIControlStateNormal];
    [rigthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)lefthBtn_subClick {
    [self.navigationController popToViewController:_m_edit animated:YES];
}
- (void)rigthBtnClick {
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAM_ME_ChoiceCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SAM_ME_ChoiceCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)choiceBtnClick:(UIButton *)btn {
    [self.navigationController popToViewController:_m_edit animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAM_ME_Choice * choice = [[SAM_ME_Choice alloc] init];
    choice.next_isno = YES;
    choice.m_edit = _m_edit;
    [self.navigationController pushViewController:choice animated:YES];
}
@end
