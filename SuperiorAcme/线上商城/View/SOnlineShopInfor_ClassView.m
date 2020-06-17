//
//  SOnlineShopInfor_ClassView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShopInfor_ClassView.h"
#import "SSearchCell.h"

@interface SOnlineShopInfor_ClassView () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * titleArr;
    NSMutableArray * titleStatusArr;
}
@end
@implementation SOnlineShopInfor_ClassView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOnlineShopInfor_ClassView" owner:self options:nil];
        [self addSubview:_thisView];
        
        UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 10;//用于控制单元格之间最小 行间距
        mFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        mFlowLayout.itemSize = CGSizeMake((ScreenW - 40)/3, 40);//设置单元格的宽和高
        mFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//各分区上下左右空白区域大小
        
        [_mCollect setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _mCollect.showsVerticalScrollIndicator = NO;
        //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
        [_mCollect registerNib:[UINib nibWithNibName:@"SSearchCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SSearchCell"];
        
        titleArr = @[@"限量购",@"拼单购",@"无界预购",@"比价购",@"积分抽奖"];
        titleStatusArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SSearchCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SSearchCell" forIndexPath:indexPath];
    
    mCell.thisTitle.text = titleArr[indexPath.row];
    if ([titleStatusArr[indexPath.row] isEqualToString:@"0"]) {
        mCell.thisTitle.textColor = WordColor;
    } else {
        mCell.thisTitle.textColor = [UIColor redColor];
    }
    mCell.thisTitle.backgroundColor = [UIColor whiteColor];
    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    titleStatusArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
    for (int i = 0; i < titleStatusArr.count; i++) {
        if (i == indexPath.row) {
            [titleStatusArr replaceObjectAtIndex:i withObject:@"1"];
        }
    }
    [_mCollect reloadData];
    
    if (self.SOnlineShopInfor_ClassView_Choice) {
        self.SOnlineShopInfor_ClassView_Choice(titleArr[indexPath.row],indexPath.row);
    }
}
- (IBAction)backBtn:(UIButton *)sender {
    if (self.SOnlineShopInfor_ClassView_Back) {
        self.SOnlineShopInfor_ClassView_Back();
    }
}
@end
