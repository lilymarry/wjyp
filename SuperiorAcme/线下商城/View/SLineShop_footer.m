//
//  SLineShop_footer.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_footer.h"
#import "SLineShop_footerCell.h"

@implementation SLineShop_footer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLineShop_footer" owner:self options:nil];
        [self addSubview:_thisView];
        
        UICollectionViewFlowLayout * mFlowLayout;
        
        mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 10;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 10;//用于控制单元格之间最小 行间距
        mFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        mFlowLayout.itemSize = CGSizeMake(100, 130
                                          );//设置单元格的宽和高
        mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);//各分区上下左右空白区域大小
        
        [_mCollect setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _mCollect.showsHorizontalScrollIndicator = NO;
        //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
        [_mCollect registerNib:[UINib nibWithNibName:@"SLineShop_footerCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SLineShop_footerCell"];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SLineShop_footerCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SLineShop_footerCell" forIndexPath:indexPath];
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
