//
//  SWelfareAgencyCoupon.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareAgencyCoupon.h"
#import "SCodePackage_twoCell.h"
#import "SWelfareTicketList.h"
#import "CircularProgressView.h"
#import "CQPlaceholderView.h"

@interface SWelfareAgencyCoupon () <CQPlaceholderViewDelegate>
{
    NSArray * thisArr;
    CQPlaceholderView * placeholderView;
}
@end

@implementation SWelfareAgencyCoupon

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SWelfareAgencyCoupon" owner:self options:nil];
        [self addSubview:_thisView];
        
        [_mTable registerNib:[UINib nibWithNibName:@"SCodePackage_twoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SCodePackage_twoCell"];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
        [_mTable addSubview:placeholderView];
        placeholderView.hidden = YES;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showModel:(NSArray *)arr {
    thisArr = arr;
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    [_mTable reloadData];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    if (self.SWelfareAgencyCoupon_ShowModelAgain) {
        self.SWelfareAgencyCoupon_ShowModelAgain();
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return thisArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SCodePackage_twoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCodePackage_twoCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.rigthImageR.image = [UIImage imageNamed:@"优惠券有效"];
    cell.thisTitle.textColor = WordColor;
    cell.thisContent.textColor = [UIColor redColor];
    cell.oneT.backgroundColor = MyPowder;
    cell.twoT.backgroundColor = MyGreen;
    
    SWelfareTicketList * list = thisArr[indexPath.row];
    
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
    [cell.showTimeBtn addTarget:self action:@selector(showTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.showTimeBtn setTag:indexPath.row];
    
    return cell;
}
- (void)showTimeBtnClick:(UIButton *)btn {
    SWelfareTicketList * list = thisArr[btn.tag];
    if (self.SWelfareAgencyCoupon_get) {
        self.SWelfareAgencyCoupon_get(list.ticket_id);
    }

}
@end
