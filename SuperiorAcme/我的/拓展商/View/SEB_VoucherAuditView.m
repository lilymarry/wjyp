//
//  SEB_VoucherAuditView.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_VoucherAuditView.h"
#import "SEB_VoucherAuditViewCell.h"
#import "SEB_VoucherAuditView_top.h"
#import "SEB_VoucherAuditView_down.h"

@interface SEB_VoucherAuditView () <UITableViewDelegate,UITableViewDataSource>
{
    NSString * thisType;
    BOOL this_isno;
}
@end

@implementation SEB_VoucherAuditView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SEB_VoucherAuditView" owner:self options:nil];
        [self addSubview:_thisView];
        
        [_mTable registerNib:[UINib nibWithNibName:@"SEB_VoucherAuditViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SEB_VoucherAuditViewCell"];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showModel:(NSString *)type {
    thisType = type;
    [_mTable reloadData];
}
- (void)showModel_sub:(BOOL)isno {
    this_isno = isno;
    [_mTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (this_isno == YES) {
        return 2;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SEB_VoucherAuditView_top * header = [[SEB_VoucherAuditView_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    if (this_isno == NO) {
        if ([thisType isEqualToString:@"1"]) {
            header.status.text = @"审核中";
        }
        if ([thisType isEqualToString:@"2"]) {
            header.status.text = @"待审核";
        }
    } else {
        if ([thisType isEqualToString:@"2"]) {
            header.status.text = @"待审核";
        } else {
            header.status.text = @"已完成";
        }

    }
    
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SEB_VoucherAuditView_down * down = [[SEB_VoucherAuditView_down alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    if (this_isno == NO) {
        if ([thisType isEqualToString:@"1"]) {
            down.statusContent.hidden = NO;
            down.oneBtn.hidden = YES;
            down.twoBtn.hidden = YES;
        }
        if ([thisType isEqualToString:@"2"]) {
            down.statusContent.hidden = YES;
            down.oneBtn.hidden = NO;
            down.twoBtn.hidden = NO;
        }
    } else {
        if ([thisType isEqualToString:@"2"]) {
            down.statusContent.hidden = YES;
            down.oneBtn.hidden = NO;
            down.twoBtn.hidden = NO;
        } else {
            down.statusContent.hidden = YES;
            down.oneBtn.hidden = YES;
            down.twoBtn.hidden = NO;
            [down.twoBtn setTitle:@"上传照片" forState:UIControlStateNormal];
        }
        
    }
    [down.oneBtn addTarget:self action:@selector(oneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [down.twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return down;
}
- (void)oneBtnClick:(UIButton *)btn {
    if (self.SEB_VoucherAuditView_oneBtn) {
        self.SEB_VoucherAuditView_oneBtn(btn);
    }
}
- (void)twoBtnClick:(UIButton *)btn {
    if (self.SEB_VoucherAuditView_twoBtn) {
        self.SEB_VoucherAuditView_twoBtn(btn);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEB_VoucherAuditViewCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SEB_VoucherAuditViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.SEB_VoucherAuditView_Infor) {
        self.SEB_VoucherAuditView_Infor();
    }
}
@end
