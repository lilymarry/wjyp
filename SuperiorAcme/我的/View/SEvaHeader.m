//
//  SEvaHeader.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaHeader.h"
#import "SOnlineShop_ClassInfoList_more_footerCell.h"
#import "SUserMyCommentList.h"

@interface SEvaHeader ()
{
    NSArray * thisArr;
}
@end

@implementation SEvaHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SEvaHeader" owner:self options:nil];
        [self addSubview:_thisView];
        
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;

        UICollectionViewFlowLayout * mFlowLayout;
        mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 15;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 15;//用于控制单元格之间最小 行间距
        mFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        mFlowLayout.itemSize = CGSizeMake(80, 80);//设置单元格的宽和高
        mFlowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);//各分区上下左右空白区域大小
        
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
    
    SOnlineShop_ClassInfoList_more_footerCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_ClassInfoList_more_footerCell" forIndexPath:indexPath];
    mCell.thisPrice.hidden = YES;
    mCell.thisPriceGround.hidden = YES;
    SUserMyCommentList * com = thisArr[indexPath.row];
    [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:com.path] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    return mCell;
}
@end
