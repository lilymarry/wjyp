//
//  SCoupons_OPEN.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCoupons_OPEN.h"
#import "SCoupons_OPENCell.h"
#import "SGoodsGoodsInfo.h"//普通商品详情、票券区
#import "SLimitBuyLimitBuyInfo.h"//限量购
#import "SGroupBuyGroupBuyInfo.h"//拼单购
#import "SPreBuyPreBuyInfo.h"//无界预购
#import "SIntegralBuyIntegralBuyInfo.h"//无界商店
#import "SGoodsGetTicket.h"

@interface SCoupons_OPEN () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * thisArr;
    NSString * thisType;
}
@end

@implementation SCoupons_OPEN

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SCoupons_OPENCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SCoupons_OPENCell"];
}
- (void)showModel:(NSArray *)arr andType:(NSString *)type {
    thisArr = arr;
    thisType = type;
    [_mCollect reloadData];
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return thisArr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置垂直间距,默认的垂直和水平间距都是10
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenW - 30)/2, (ScreenW - 30)/2/5*2);

}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SCoupons_OPENCell * cell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SCoupons_OPENCell" forIndexPath:indexPath];
    
    if (thisType == nil) {
        SGoodsGoodsInfo * infor = thisArr[indexPath.row];
//        cell.thisPrice.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
        cell.thisPrice.text = infor.value_replace;
        cell.thisContent.text = infor.ticket_name;
        if ([infor.get_receive isEqualToString:@"0"]) {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵"];
        } else {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵已领"];
        }
    }
    if ([thisType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * infor = thisArr[indexPath.row];
//        cell.thisPrice.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
        cell.thisPrice.text = infor.value_replace;
        cell.thisContent.text = infor.ticket_name;
        if ([infor.get_receive isEqualToString:@"0"]) {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵"];
        } else {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵已领"];
        }
    }
    if ([thisType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo * infor = thisArr[indexPath.row];
//        cell.thisPrice.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
        cell.thisPrice.text = infor.value_replace;
        cell.thisContent.text = infor.ticket_name;
        if ([infor.get_receive isEqualToString:@"0"]) {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵"];
        } else {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵已领"];
        }
    }
    if ([thisType isEqualToString:@"无界预购"]) {
        SPreBuyPreBuyInfo * infor = thisArr[indexPath.row];
//        cell.thisPrice.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
        cell.thisPrice.text = infor.value_replace;
        cell.thisContent.text = infor.ticket_name;
        if ([infor.get_receive isEqualToString:@"0"]) {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵"];
        } else {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵已领"];
        }
    }
    if ([thisType isEqualToString:@"无界商店"]) {
        SIntegralBuyIntegralBuyInfo * infor = thisArr[indexPath.row];
//        cell.thisPrice.text = [NSString stringWithFormat:@"￥%@ 优惠券",infor.value];
        cell.thisPrice.text = infor.value_replace;
        cell.thisContent.text = infor.ticket_name;
        if ([infor.get_receive isEqualToString:@"0"]) {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵"];
        } else {
            cell.groundImage.image = [UIImage imageNamed:@"优惠劵已领"];
        }
    }

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SGoodsGetTicket * get = [[SGoodsGetTicket alloc] init];
    if (thisType == nil) {
        SGoodsGoodsInfo * infor = thisArr[indexPath.row];
        get.ticket_id = infor.ticket_id;
    }
    if ([thisType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * infor = thisArr[indexPath.row];
        get.ticket_id = infor.ticket_id;

    }
    if ([thisType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo * infor = thisArr[indexPath.row];
        get.ticket_id = infor.ticket_id;

    }
    if ([thisType isEqualToString:@"无界预购"]) {
        SPreBuyPreBuyInfo * infor = thisArr[indexPath.row];
        get.ticket_id = infor.ticket_id;

    }
    if ([thisType isEqualToString:@"无界商店"]) {
        SIntegralBuyIntegralBuyInfo * infor = thisArr[indexPath.row];
        get.ticket_id = infor.ticket_id;

    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [get sGoodsGetTicketSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            if (thisType == nil) {
                SGoodsGoodsInfo * infor = thisArr[indexPath.row];
                infor.get_receive = @"1";
            }
            if ([thisType isEqualToString:@"限量购"]) {
                SLimitBuyLimitBuyInfo * infor = thisArr[indexPath.row];
                infor.get_receive = @"1";

            }
            if ([thisType isEqualToString:@"拼单购"]) {
                SGroupBuyGroupBuyInfo * infor = thisArr[indexPath.row];
                infor.get_receive = @"1";

            }
            if ([thisType isEqualToString:@"无界预购"]) {
                SPreBuyPreBuyInfo * infor = thisArr[indexPath.row];
                infor.get_receive = @"1";

            }
            if ([thisType isEqualToString:@"无界商店"]) {
                SIntegralBuyIntegralBuyInfo * infor = thisArr[indexPath.row];
                infor.get_receive = @"1";

            }
            [_mCollect reloadData];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (IBAction)backBtn:(UIButton *)sender {
    if (self.SCoupons_OPEN_Back) {
        self.SCoupons_OPEN_Back();
    }
}
@end
