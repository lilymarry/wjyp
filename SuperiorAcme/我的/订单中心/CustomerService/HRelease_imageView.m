//
//  HRelease_imageView.m
//  HouseCenter
//
//  Created by TXD_air on 16/8/29.
//  Copyright © 2016年 GYM. All rights reserved.
//

#import "HRelease_imageView.h"
#import "HRelease_imageViewCell.h"

@interface HRelease_imageView () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionViewFlowLayout * mFlowLayout;
    NSMutableArray * _thisArr;
}
@end

@implementation HRelease_imageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"HRelease_imageView" owner:self options:nil];
        [self createUI];
    }
    return self;
}

- (void)setChoiceImage:(NSMutableArray *)arr {
    _thisArr = arr;
    [_mCollectionView reloadData];
}

- (void)createUI {
    _thisContent.frame = CGRectMake(0, 0, ScreenW - 20, 100);
    [self addSubview:_thisContent];
    
    //布局
    _thisArr = [[NSMutableArray alloc] initWithObjects:@"照片默认", nil];
    mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
    mFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    mFlowLayout.itemSize = CGSizeMake(90, 100);//设置单元格的宽和高
    mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//各分区上下左右空白区域大小
    //    mFlowLayout.headerReferenceSize = CGSizeMake(ScreenW, 50);//设置头部View的宽、高
    //        mFlowLayout.footerReferenceSize = CGSizeMake(ScreenW, 50);//设置尾部View的宽、高
    
    _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW - 20, 100) collectionViewLayout:mFlowLayout];
    //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
    [_mCollectionView registerNib:[UINib nibWithNibName:@"HRelease_imageViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HRelease_imageViewCell"];
    
    _mCollectionView.dataSource = self;
    _mCollectionView.delegate = self;
    _mCollectionView.backgroundColor = [UIColor whiteColor];//默认是黑色
    [_thisContent addSubview:_mCollectionView];
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _thisArr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HRelease_imageViewCell *mCell = [_mCollectionView dequeueReusableCellWithReuseIdentifier:@"HRelease_imageViewCell" forIndexPath:indexPath];
    [mCell.choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mCell.closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [mCell.choiceBtn setContentMode:UIViewContentModeScaleAspectFit];
    //加载图片
    if ([_thisArr[indexPath.row] isKindOfClass:[NSString class]]) {
        if ([_thisArr[indexPath.row] hasSuffix:@"http"]) {
            [mCell.choiceImage sd_setImageWithURL:[NSURL URLWithString:_thisArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"无界优品默认空试图"]];
        } else {
            mCell.choiceImage.image = [UIImage imageNamed:_thisArr[indexPath.row]];
        }
    } else {
        mCell.choiceImage.image = _thisArr[indexPath.row];
    }
    //显示删除
    if (indexPath.row == 0) {
        mCell.closeBtn.hidden = YES;
    } else {
        mCell.closeBtn.hidden = NO;
    }
    return mCell;
}
- (void)choiceBtnClick:(UIButton *)btn {
    HRelease_imageViewCell * cell = (HRelease_imageViewCell *)btn.superview.superview;
    NSIndexPath * indexPath = [_mCollectionView indexPathForCell:cell];
    if (indexPath.row == 0) {
        if (self.HRelease_imageViewChoice) {
            self.HRelease_imageViewChoice(btn);
        }
    } else {
        if (self.HRelease_imageViewLook) {
            self.HRelease_imageViewLook(indexPath.row);
        }
    }
}
- (void)closeBtnClick:(UIButton *)btn {
    HRelease_imageViewCell * cell = (HRelease_imageViewCell *)btn.superview.superview;
    NSIndexPath * indexPath = [_mCollectionView indexPathForCell:cell];
    if (self.HRelease_imageViewClose) {
        
        self.HRelease_imageViewClose(indexPath.row);
    }
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}
@end
