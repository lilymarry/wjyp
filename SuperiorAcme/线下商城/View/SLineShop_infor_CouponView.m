//
//  SLineShop_infor_CouponView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_infor_CouponView.h"
#import "CircularProgressView.h"
#import "SCodePackage_twoCell.h"

#import "SMerchantMerIndex.h"

@interface SLineShop_infor_CouponView () <UITableViewDelegate,UITableViewDataSource>
{
    BOOL showNoci;
    NSString * announce_infor;
    NSArray * thisArr;
}
@end

@implementation SLineShop_infor_CouponView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLineShop_infor_CouponView" owner:self options:nil];
        [self addSubview:_thisView];

        _groundView.layer.masksToBounds = YES;
        _groundView.layer.cornerRadius = 15;
        [_mTable registerNib:[UINib nibWithNibName:@"SCodePackage_twoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SCodePackage_twoCell"];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showNotice:(NSString *)announce {
    showNoci = YES;
    _mTable.backgroundColor = [UIColor whiteColor];
    announce_infor = announce;
    [_mTable reloadData];
}
- (void)showModel:(NSArray *)arr {
    thisArr = arr;
    [_mTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (showNoci == YES) {
        return 1;
    }
    return thisArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (showNoci == YES) {
        return 0.01;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (showNoci == YES) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor = [UIColor redColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = announce_infor;
        cell.textLabel.numberOfLines = 0;
        return cell;
    }
    
    SCodePackage_twoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCodePackage_twoCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    SMerchantMerIndex * list = thisArr[indexPath.row];
    cell.thisTitle.text = list.ticket_name;
    cell.thisContent.text = list.ticket_desc;
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    cell.twoT.text = @"满折";
    if ([list.ticket_type isEqualToString:@"1"]) {
        cell.oneT.hidden = NO;
        cell.twoT.hidden = YES;
        cell.threeT.hidden = YES;
    }
    if ([list.ticket_type isEqualToString:@"2"]) {
        cell.oneT.hidden = YES;
        cell.twoT.hidden = NO;
        cell.threeT.hidden = YES;
    }
    if ([list.ticket_type isEqualToString:@"3"]) {
        cell.oneT.hidden = YES;
        cell.twoT.hidden = YES;
        cell.threeT.hidden = NO;
    }
    
    CircularProgressView * pro = [[CircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [cell.showTimeView addSubview:pro];
    pro.backgroundColor = [UIColor clearColor];
    pro.progress = [list.use_num floatValue]/[list.ticket_num floatValue];
    cell.showTime_num.text = [NSString stringWithFormat:@"%.0f%%",[list.use_num floatValue]/[list.ticket_num floatValue] * 100];
    
    if ([list.is_get isEqualToString:@"0"]) {
        cell.rightImageR_sub.image = [UIImage imageNamed:@"优惠券有效R"];
        cell.showTimeView.backgroundColor = [UIColor redColor];
        [cell.showTimeBtn setTitle:@"免费领取" forState:UIControlStateNormal];
        [cell.showTimeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else {
        cell.rightImageR_sub.image = [UIImage imageNamed:@"优惠券失效R"];
        cell.showTimeView.backgroundColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1.0];
        [cell.showTimeBtn setTitle:@"已领取" forState:UIControlStateNormal];
        [cell.showTimeBtn setTitleColor:[UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    [cell.showTimeBtn setTag:indexPath.row];
    [cell.showTimeBtn addTarget:self action:@selector(showTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (IBAction)backBtn:(UIButton *)sender {
    if (self.SLineShop_infor_CouponView_Back) {
        self.SLineShop_infor_CouponView_Back();
    }
}
- (void)showTimeBtnClick:(UIButton *)btn {
    SMerchantMerIndex * list = thisArr[btn.tag];
    if (self.SLineShop_infor_CouponView_get) {
        self.SLineShop_infor_CouponView_get(list.ticket_id);
    }
}
@end
