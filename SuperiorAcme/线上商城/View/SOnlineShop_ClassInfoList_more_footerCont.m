//
//  SOnlineShop_ClassInfoList_more_footerCont.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShop_ClassInfoList_more_footerCont.h"
#import "SOnlineShop_ClassInfoList_more_footerCell.h"
#import "SUserMyfooter.h"
#import "SGoodsCategoryCateIndex.h"
#import "SGoodsSearch.h"
#import "SUserCollectCollectList.h"
#import "SCarBuyCarInfo.h"
#import "SCarBuyCommentList.h"
#import "SHouseBuyCommentList.h"
#import "SHouseBuyHouseInfo.h"
#import "UBShopDetailModel.h"

@interface SOnlineShop_ClassInfoList_more_footerCont ()
{
    UICollectionViewFlowLayout * mFlowLayout;
    BOOL priceShow;//YES显示
    NSArray * thisArr;
    NSString * thisType;
}
@end

@implementation SOnlineShop_ClassInfoList_more_footerCont

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOnlineShop_ClassInfoList_more_footerCont" owner:self options:nil];
        [self addSubview:_thisView];
        
        mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 10;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 10;//用于控制单元格之间最小 行间距
        mFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        mFlowLayout.itemSize = CGSizeMake(60, 60);//设置单元格的宽和高
        mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//各分区上下左右空白区域大小
        
        [_mCollect setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _mCollect.showsHorizontalScrollIndicator = NO;
        //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
        [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassInfoList_more_footerCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShop_ClassInfoList_more_footerCell"];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showModel:(NSArray *)arr andPriceShow:(BOOL)show_isno andType:(NSString *)model_type{
    thisArr = arr;
    priceShow = show_isno;
    thisType = model_type;
    if ([model_type isEqualToString:@"SUserMyfooter"]||[model_type isEqualToString:@"SGoodsSearch"]||[model_type isEqualToString:@"SUserCollectCollectList"]||[model_type isEqualToString:@"UBShopDetailCommentModel"]) {
        mFlowLayout.itemSize = CGSizeMake(109, 109);//设置单元格的宽和高
        _mCollect_HHH.constant = 109;
    }
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
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShop_ClassInfoList_more_footerCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_ClassInfoList_more_footerCell" forIndexPath:indexPath];

    if (priceShow == YES) {
        mCell.thisPrice.hidden = NO;
        mCell.thisPriceGround.hidden = NO;
    } else {
        mCell.thisPrice.hidden = YES;
        mCell.thisPriceGround.hidden = YES;
    }
    if ([thisType isEqualToString:@"SUserMyfooter"]) {
        SUserMyfooter * myFooter = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:myFooter.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisPrice.text = [NSString stringWithFormat:@"￥%@",myFooter.shop_price];
    }
    if ([thisType isEqualToString:@"SGoodsCategoryCateIndex"]) {
        SGoodsCategoryCateIndex * myFooter = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:myFooter.brand_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisPrice.text = [NSString stringWithFormat:@"￥%@",myFooter.brand_name];
    }
    if ([thisType isEqualToString:@"SGoodsSearch"]) {
        SGoodsSearch * myFooter = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:myFooter.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisPrice.text = [NSString stringWithFormat:@"￥%@",myFooter.shop_price];
    }
    if ([thisType isEqualToString:@"SUserCollectCollectList"]) {
        SUserCollectCollectList * myFooter = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:myFooter.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisPrice.text = [NSString stringWithFormat:@"￥%@",myFooter.shop_price];
    }
    if ([thisType isEqualToString:@"SCarBuyCarInfo"]) {
        SCarBuyCarInfo * myFooter = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:myFooter.path] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    }
    if ([thisType isEqualToString:@"SCarBuyCommentList"]) {
        SCarBuyCommentList * myFooter = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:myFooter.path] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    }
    if ([thisType isEqualToString:@"SHouseBuyCommentList"]) {
        SHouseBuyCommentList * myFooter = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:myFooter.path] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    }
    if ([thisType isEqualToString:@"SHouseBuyHouseInfo"]) {
        SHouseBuyHouseInfo * myFooter = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:myFooter.path] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    }
    if ([thisType isEqualToString:@"UBShopDetailCommentModel"]) {
        NSDictionary* myFooter = thisArr[indexPath.row];
         [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:myFooter[@"path"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    }
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([thisType isEqualToString:@"SGoodsSearch"]) {
        SGoodsSearch * myFooter = thisArr[indexPath.row];
        if (self.SOnlineShop_ClassInfoList_more_footerCont_select) {
            self.SOnlineShop_ClassInfoList_more_footerCont_select(myFooter.goods_id);
        }
    }
    if ([thisType isEqualToString:@"SUserMyfooter"]) {
        SUserMyfooter * myFooter = thisArr[indexPath.row];
        if (self.SOnlineShop_ClassInfoList_more_footerCont_select) {
            self.SOnlineShop_ClassInfoList_more_footerCont_select(myFooter.goods_id);
        }
    }
    if ([thisType isEqualToString:@"SUserCollectCollectList"]) {
        SUserCollectCollectList * myFooter = thisArr[indexPath.row];
        if (self.SOnlineShop_ClassInfoList_more_footerCont_select) {
            self.SOnlineShop_ClassInfoList_more_footerCont_select(myFooter.goods_id);
        }
    }
}


@end
