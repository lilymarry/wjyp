//
//  SOnlineShop_ClassView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShop_ClassView.h"
#import "SOnlineShop_ClassViewCell.h"
#import "SIndexIndex.h"

@interface SOnlineShop_ClassView () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * thisArr;
    UICollectionViewFlowLayout * mFlowLayout;
}
@end

@implementation SOnlineShop_ClassView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOnlineShop_ClassView" owner:self options:nil];
        [self addSubview:_thisView];

        [self createUI];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (void)createUI {
    mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
    mFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    mFlowLayout.itemSize = CGSizeMake(70, 40);//设置单元格的宽和高
    mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//各分区上下左右空白区域大小
    
    [_mCollection setCollectionViewLayout:mFlowLayout];
    //隐藏滚轴
    _mCollection.showsHorizontalScrollIndicator = NO;
    //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
    [_mCollection registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShop_ClassViewCell"];
}
- (void)showModel:(NSArray *)arr {
    thisArr = arr;
    [_mCollection reloadData];
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
    
    SOnlineShop_ClassViewCell * mCell = [_mCollection dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_ClassViewCell" forIndexPath:indexPath];
    
    SIndexIndex * list = thisArr[indexPath.row];
    mCell.thisTitle.text = list.short_name;
    if (indexPath.row == 0) {
        mCell.thisTitle.textColor = [UIColor redColor];
        mCell.thisSelect.hidden = NO;
    } else {
        mCell.thisTitle.textColor = WordColor;
        mCell.thisSelect.hidden = YES;
    }
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SIndexIndex * list = thisArr[indexPath.row];

//    if (indexPath.row != 0) {
        if (self.SOnlineShop_ClassView_choiceType) {
            self.SOnlineShop_ClassView_choiceType(indexPath.row,list.cate_id);
        }
        [_mCollection setContentOffset:CGPointMake(0, 0) animated:NO];
//    }
//    if ([arr.firstObject isEqualToString:@"推荐"]) {
//        if (indexPath.row == 0) {
//            //推荐不用有反应
//        } else {
//            if (self.SOnlineShop_ClassView_choiceType) {
//                self.SOnlineShop_ClassView_choiceType(indexPath.row);
//            }
//        }
//        [_mCollection setContentOffset:CGPointMake(0, 0) animated:NO];
//    } else {
//        brr = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
//        for (int i = 0; i < brr.count; i++) {
//            if (i == indexPath.row) {
//                [brr replaceObjectAtIndex:i withObject:@"1"];
//            }
//        }
//        [_mCollection reloadData];
//        [_mCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//        
//        if (self.SOnlineShop_ClassView_Push) {
//            self.SOnlineShop_ClassView_Push();
//        }
//    }
    
}
@end
