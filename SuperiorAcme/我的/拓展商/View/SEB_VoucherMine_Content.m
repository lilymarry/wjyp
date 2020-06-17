//
//  SEB_VoucherMine_Content.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_VoucherMine_Content.h"
#import "SEB_VM_CCell.h"

@interface SEB_VoucherMine_Content () <UITableViewDelegate,UITableViewDataSource>
{
    NSString * thisType;//1黄 2蓝 3灰
}
@end

@implementation SEB_VoucherMine_Content

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SEB_VoucherMine_Content" owner:self options:nil];
        [self addSubview:_thisView];
        
        thisType = @"1";
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mTable registerNib:[UINib nibWithNibName:@"SEB_VM_CCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SEB_VM_CCell"];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)show:(NSString *)type {
    thisType = type;
    [_mTable reloadData];
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
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEB_VM_CCell * cell  = [_mTable dequeueReusableCellWithIdentifier:@"SEB_VM_CCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([thisType isEqualToString:@"1"]) {
        cell.thisR.backgroundColor = [UIColor colorWithRed:248/255.0 green:208/255.0 blue:80/255.0 alpha:1.0];
    }
    if ([thisType isEqualToString:@"2"]) {
        cell.thisR.backgroundColor = [UIColor colorWithRed:100/255.0 green:148/255.0 blue:251/255.0 alpha:1.0];
    }
    if ([thisType isEqualToString:@"3"]) {
        cell.thisR.backgroundColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1.0];
    }
    
    return cell;
}
@end
