//
//  QGoodsInfor_first_header3_evaCollect.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "QGoodsInfor_first_header3_evaCollect.h"
#import "QGoodsInfor_first_header3_evaCollectCell.h"
#import "SGoodsGoodsInfo.h"
#import "SGoodsGroupGoodsList.h"

@interface QGoodsInfor_first_header3_evaCollect() <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * thisArr;
    NSString * thisType;
}
@end

@implementation QGoodsInfor_first_header3_evaCollect

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"QGoodsInfor_first_header3_evaCollect" owner:self options:nil];
        [self addSubview:_thisView];
        
        
        UICollectionViewFlowLayout * mFlowLayout;
        mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
        mFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        mFlowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);//各分区上下左右空白区域大小
        
        [_mCollect setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _mCollect.showsHorizontalScrollIndicator = NO;
        //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
        [_mCollect registerNib:[UINib nibWithNibName:@"QGoodsInfor_first_header3_evaCollectCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"QGoodsInfor_first_header3_evaCollectCell"];
        _mCollect.delegate = self;
        _mCollect.dataSource = self;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showModel:(NSArray *)arr andType:(NSString *)type{
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == thisArr.count - 1) {
        return CGSizeMake(80, 80);
    }
    return CGSizeMake(120, 80);
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QGoodsInfor_first_header3_evaCollectCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"QGoodsInfor_first_header3_evaCollectCell" forIndexPath:indexPath];
    if (indexPath.row == thisArr.count - 1) {
        mCell.thisT.hidden = YES;
    } else {
        mCell.thisT.hidden = NO;
    }
    if ([thisType isEqualToString:@"搭配购"]) {
        
        SGoodsGroupGoodsList * infor = thisArr[indexPath.row];
        [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:infor.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.shop_price.text = [NSString stringWithFormat:@"￥%@",infor.shop_price];
    }
    SGoodsGoodsInfo * infor = thisArr[indexPath.row];
    [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:infor.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    mCell.shop_price.text = [NSString stringWithFormat:@"￥%@",infor.shop_price];
    return mCell;
}
@end
