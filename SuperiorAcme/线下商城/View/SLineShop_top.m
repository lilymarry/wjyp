//
//  SLineShop_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_top.h"
#import "ELCVFlowLayout.h"

@implementation SLineShop_top

-(void)awakeFromNib{
    [super awakeFromNib];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLineShop_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        ELCVFlowLayout * mFlowLayout = [[ELCVFlowLayout alloc]init];
      //  mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
      //  mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
      //  mFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        mFlowLayout.itemSize = CGSizeMake(ScreenW/5, 100);//设置单元格的宽和高
    //    mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//各分区上下左右空白区域大小
    
        [_collectionView setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [UBTypeCell xibWithCollectionView:_collectionView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    [_collectionView reloadData];
}


#pragma mark 返回值决定UICollectionView分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UBTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UBTypeCell cellIdentifier] forIndexPath:indexPath];
    UBTypeModel *model = self.datas[indexPath.row];
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:model.cate_img]
                 placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    cell.subTitleLab.text = model.type;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    [MBProgressHUD showSuccess:@"程序员努力开发中..." toView:collectionView.window];
//    return;
    if (self.typyEntryBlcok) {
        UBTypeModel *model = self.datas[indexPath.row];
        self.typyEntryBlcok(model);
    }
}


@end
