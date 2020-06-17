//
//  SHyphenateList.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SHyphenateList.h"
#import "SHyphenateListCell.h"
#import "SEasemobBind.h"

@interface SHyphenateList () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * thisARR;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UIView *groundView;
/*
 *mTableView到客服标题的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTableToTopCons;
/*
 *拨打电话
 */
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@end

@implementation SHyphenateList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /*
     *当客服电话没有的时候,隐藏客服电话
     */
    if (_merchant_phone == nil || [_merchant_phone isEqualToString:@""]) {
        self.mTableToTopCons.constant = 0;
        [self.phoneBtn setTitle:nil forState:UIControlStateNormal];
    }else{
        [self.phoneBtn setTitle:[NSString stringWithFormat:@"客服电话 : %@",_merchant_phone] forState:UIControlStateNormal];
    }
    
    
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 3;
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SHyphenateListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHyphenateListCell"];
    
    SEasemobBind * bind = [[SEasemobBind alloc] init];
    bind.merchant_id = _merchant_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [bind sEasemobBindSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SEasemobBind * bind = (SEasemobBind *)data;
        thisARR = bind.data.easemob_account;
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (thisARR.count == 0) {
        _mTable.hidden = YES;
    } else {
        _mTable.hidden = NO;
    }
    return thisARR.count;
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
    SHyphenateListCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SHyphenateListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SEasemobBind * bind = thisARR[indexPath.row];
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:bind.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.thisContent.text = [NSString stringWithFormat:@"%@ %@ %@",bind.nickname,bind.department_name,bind.position];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:^{
        SEasemobBind * bind = thisARR[indexPath.row];
        if (self.SHyphenateList_choice) {
            self.SHyphenateList_choice(bind.head_pic,bind.nickname,bind.hx);
        }
    }];
    
}
- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
 *拨打客服电话
 */
- (IBAction)CalliPhone:(UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",self.merchant_phone];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }

}



@end
