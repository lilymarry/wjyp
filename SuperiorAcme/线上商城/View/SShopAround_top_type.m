//
//  SShopAround_top_type.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopAround_top_type.h"
#import "SShopCar_editViewCell.h"

@implementation SShopAround_top_type

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SShopAround_top_type" owner:self options:nil];
        [self addSubview:_thisView];

        
        UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 10;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 10;//用于控制单元格之间最小 行间距
        mFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        mFlowLayout.itemSize = CGSizeMake((ScreenW - 50)/4, 40);//设置单元格的宽和高
        mFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//各分区上下左右空白区域大小
        
        [_mCollect setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _mCollect.showsVerticalScrollIndicator = NO;
        //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
        [_mCollect registerNib:[UINib nibWithNibName:@"SShopCar_editViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SShopCar_editViewCell"];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SShopCar_editViewCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SShopCar_editViewCell" forIndexPath:indexPath];
    mCell.thisTitle.layer.masksToBounds = YES;
    mCell.thisTitle.layer.cornerRadius = 3;
    mCell.thisTitle.layer.borderWidth = 0.5;
    mCell.thisTitle.layer.borderColor = MyLine.CGColor;
    mCell.thisTitle.text = @"类型";
    
    
    return mCell;
}
@end
