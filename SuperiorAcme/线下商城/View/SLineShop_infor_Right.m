//
//  SLineShop_infor_Right.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_infor_Right.h"
#import "SLineShop_infor_rightTop.h"
#import "SLineShop_infor_leftCell.h"
#import "SLineShop_infor_rightCell.h"

@interface SLineShop_infor_Right () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation SLineShop_infor_Right

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLineShop_infor_Right" owner:self options:nil];
        [self addSubview:_thisView];
        
        _car_num.layer.masksToBounds = YES;
        _car_num.layer.cornerRadius = 7.5;
        
        [_mTable_left registerNib:[UINib nibWithNibName:@"SLineShop_infor_leftCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SLineShop_infor_leftCell"];
        _mTable_left.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [_mTable_right registerNib:[UINib nibWithNibName:@"SLineShop_infor_rightCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SLineShop_infor_rightCell"];
        _mTable_right.separatorStyle = UITableViewCellSeparatorStyleNone;
        SLineShop_infor_rightTop * rigthTop = [[SLineShop_infor_rightTop alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 100, 80)];
        _mTable_right.tableHeaderView = rigthTop;
        [rigthTop.couponBtn addTarget:self action:@selector(couponBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
#pragma mark - 领券
- (void)couponBtnClick {
    if (self.SLineShop_infor_Right_coupon) {
        self.SLineShop_infor_Right_coupon();
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _mTable_left) {
        return 50;
    }
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _mTable_left) {
        SLineShop_infor_leftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SLineShop_infor_leftCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeTitle.text = [NSString stringWithFormat:@"类型 %ld",indexPath.row + 1];
        if (indexPath.row == 0) {
            cell.typeTitle.textColor = [UIColor redColor];
            cell.backgroundColor = [UIColor whiteColor];
            cell.line.hidden = NO;
        } else {
            cell.typeTitle.textColor = WordColor_sub;
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            cell.line.hidden = YES;
        }
        
        return cell;
    }
    SLineShop_infor_rightCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SLineShop_infor_rightCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.goodsTitle.text = [NSString stringWithFormat:@"商品 %ld",indexPath.row + 1];
    
    
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _mTable_left || scrollView == _mTable_right) {
        if (self.SLineShop_infor_Right_ScrollDelegate) {
            self.SLineShop_infor_Right_ScrollDelegate(scrollView.contentOffset.y);
        }
    }
}
#pragma mark - 前往购物车
- (IBAction)goCar:(UIButton *)sender {
    if (self.SLineShop_infor_Right_goCar) {
        self.SLineShop_infor_Right_goCar();
    }
}
#pragma mark - 去结算
- (IBAction)pay_submitBtn:(UIButton *)sender {
    if (self.SLineShop_infor_Right_Submit) {
        self.SLineShop_infor_Right_Submit();
    }
}
@end
