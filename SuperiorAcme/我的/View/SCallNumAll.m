//
//  SCallNumAll.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCallNumAll.h"
#import "SCallNumAllCell.h"
#import "SIntegralOrderDetails.h"

@interface SCallNumAll () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * thisArr;
}
@end
@implementation SCallNumAll

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SCallNumAll" owner:self options:nil];
        [self addSubview:_thisView];
        
        [_mTable registerNib:[UINib nibWithNibName:@"SCallNumAllCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SCallNumAllCell"];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _groundView.layer.masksToBounds = YES;
        _groundView.layer.cornerRadius = 3;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showModel:(NSArray *)arr {
    thisArr = arr;
    [_mTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return thisArr.count;
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
    SCallNumAllCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCallNumAllCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SIntegralOrderDetails * list = thisArr[indexPath.row];
    cell.num.text = list.number_list;
    return cell;
}

- (IBAction)closeBtn:(UIButton *)sender {
    if (self.SCallNumAll_close) {
        self.SCallNumAll_close();
    }
}
- (IBAction)close_subBtn:(UIButton *)sender {
    if (self.SCallNumAll_close) {
        self.SCallNumAll_close();
    }
}
@end
