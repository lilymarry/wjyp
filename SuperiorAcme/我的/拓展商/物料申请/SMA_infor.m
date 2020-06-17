//
//  SMA_infor.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMA_infor.h"
#import "SEB_VAInforCell.h"
#import "SMaterielNumCell.h"
#import "SMA_infor_top.h"
#import "SMA_inforPhoto.h"
#import "SEV_window.h"

@interface SMA_infor () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SMA_infor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    SMA_infor_top * top = [[SMA_infor_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    _mTable.tableHeaderView = top;
    if (_isno == NO) {
        top.statusContent.hidden = YES;
        top.oneBtn.hidden = YES;
        [top.twoBtn setTitle:@"上传照片" forState:UIControlStateNormal];
    } else {
        top.statusContent.hidden = YES;
    }
    
    [top.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [top.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SEB_VAInforCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SEB_VAInforCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"SMaterielNumCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SMaterielNumCell"];
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
    if (_isno == NO) {
        SMA_inforPhoto * photo = [[SMA_inforPhoto alloc] init];
        [self.navigationController pushViewController:photo animated:YES];
    } else {
        SEV_window * win = [[SEV_window alloc] init];
        win.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        win.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:win animated:YES completion:nil];
    }
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * thisTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 40)];
    [header addSubview:thisTitle];
    thisTitle.font = [UIFont systemFontOfSize:14];
    thisTitle.textColor = WordColor_sub;
    if (section == 0) {
        thisTitle.text = @"审核信息";
    } else {
        thisTitle.text = @"申请详情";
    }
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
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
    SMaterielNumCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SMaterielNumCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.thisNum.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.numTF.text = @"x10";
    cell.numTF.userInteractionEnabled = NO;
    cell.numTF.textAlignment = NSTextAlignmentRight;
    
    return cell;
}

@end
