//
//  SSuperPreOrderView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SSuperPreOrderView.h"
#import "SOnlineShop_ClassCell.h"
#import "SCountryCountryIndex.h"
#import "PagingCollectionViewLayout.h"

@interface SSuperPreOrderView () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * thisArr;
}
@end

@implementation SSuperPreOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SSuperPreOrderView" owner:self options:nil];
        [self addSubview:_thisView];
        
        PagingCollectionViewLayout * mFlowLayout = [[PagingCollectionViewLayout alloc]init];
        //    mFlowLayout.itemCountPerRow = 5;
        //    mFlowLayout.rowCount = 2;
        mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
        //    mFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        mFlowLayout.itemSize = CGSizeMake(ScreenW/5, 100);//设置单元格的宽和高
        mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//各分区上下左右空白区域大小
        
        [_mCollect setCollectionViewLayout:mFlowLayout];
        _mCollect.pagingEnabled = YES;
        //隐藏滚轴
        _mCollect.showsHorizontalScrollIndicator = NO;
        //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
        [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShop_ClassCell"];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showModel:(NSArray *)arr {
    thisArr = arr;
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
    
    SOnlineShop_ClassCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_ClassCell" forIndexPath:indexPath];
    mCell.thisContent.hidden = YES;

    SCountryCountryIndex * list = thisArr[indexPath.row];
    [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.house_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    mCell.thisImageHHH.constant = 0;
    mCell.thisImage_leftWWW.constant = 0;
    mCell.thisImage_rightWWW.constant = 0;
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SCountryCountryIndex * list = thisArr[indexPath.row];
    if (self.SSuperPreOrderViewSuccess) {
        self.SSuperPreOrderViewSuccess(list.country_id,list.country_name);
    }
}
@end
