//
//  SAM_MA_infor.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAM_MA_infor.h"
#import "SEB_VAInforCell.h"
#import "SAM_MA_infor_top.h"
#import "SEV_window.h"
#import "SAM_MA_infor_donw.h"

@interface SAM_MA_infor () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SAM_MA_infor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    SAM_MA_infor_top * top = [[SAM_MA_infor_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 290)];
    _mTable.tableHeaderView = top;
    top.statusContent.hidden = YES;
    [top.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [top.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    SAM_MA_infor_donw * down = [[SAM_MA_infor_donw alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 760.5)];
    _mTable.tableFooterView = down;
    
    [_mTable registerNib:[UINib nibWithNibName:@"SEB_VAInforCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SEB_VAInforCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"审核详情";
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
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEB_VAInforCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SEB_VAInforCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        cell.thisImage.image = [UIImage imageNamed:@"时间轴红"];
        cell.thisOne.textColor = [UIColor redColor];
        cell.thisTwo.textColor = [UIColor redColor];
        cell.line_one.hidden = YES;
        cell.line_two.hidden = NO;
    } else if (indexPath.row == 4) {
        cell.thisImage.image = [UIImage imageNamed:@"时间轴灰"];
        cell.thisOne.textColor = WordColor_sub;
        cell.thisTwo.textColor = WordColor_sub;
        cell.line_one.hidden = NO;
        cell.line_two.hidden = YES;
    } else {
        cell.thisImage.image = [UIImage imageNamed:@"时间轴灰"];
        cell.thisOne.textColor = WordColor_sub;
        cell.thisTwo.textColor = WordColor_sub;
        cell.line_one.hidden = NO;
        cell.line_two.hidden = NO;
    }
    
    return cell;
}

- (void)oneBtnClick {
    SEV_window * win = [[SEV_window alloc] init];
    win.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    win.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:win animated:YES completion:nil];
    win.twoView_topHHH.constant = 10;
    win.status.text = @"拒绝通过";
    win.twoViewTF.text = @"输入拒绝理由";
}
- (void)twoBtnClick {
    SEV_window * win = [[SEV_window alloc] init];
    win.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    win.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:win animated:YES completion:nil];
}
@end
