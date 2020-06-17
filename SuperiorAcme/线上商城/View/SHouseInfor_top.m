//
//  SHouseInfor_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseInfor_top.h"
#import "SShopCar_editViewCell.h"
#import "SCarBuyCommentList.h"
#import "SHouseBuyCommentList.h"

@interface SHouseInfor_top () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * thisArr;
    NSString * now_label_id;
    NSString * thisType;
}
@end

@implementation SHouseInfor_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SHouseInfor_top" owner:self options:nil];
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
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 10;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 10;//用于控制单元格之间最小 行间距
    mFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    mFlowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);//各分区上下左右空白区域大小
    
    [_mCollect setCollectionViewLayout:mFlowLayout];
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SShopCar_editViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SShopCar_editViewCell"];
}
- (void)showModel:(NSArray *)arr andNow:(NSString *)label_id andType:(NSString *)type{
    thisType = type;
    thisArr = arr;
    now_label_id = label_id;
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
    SCarBuyCommentList * list = thisArr[indexPath.row];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGSize size = [[NSString stringWithFormat:@"%@(%@)",list.label_name,list.num] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return CGSizeMake(size.width + 20, 30);
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SShopCar_editViewCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SShopCar_editViewCell" forIndexPath:indexPath];
    mCell.thisTitle.layer.masksToBounds = YES;
    mCell.thisTitle.layer.cornerRadius = 3;
    mCell.thisTitle.layer.borderWidth = 0.5;
    mCell.thisTitle.layer.borderColor = MyLine.CGColor;
    
    if ([thisType isEqualToString:@"SCarBuyCommentList"]) {
        SCarBuyCommentList * list = thisArr[indexPath.row];
        mCell.thisTitle.text = [NSString stringWithFormat:@"%@(%@)",list.label_name,list.num];
        if ([list.label_id isEqualToString:now_label_id]) {
            mCell.thisTitle.backgroundColor = [UIColor redColor];
            mCell.thisTitle.textColor = [UIColor whiteColor];
        } else {
            mCell.thisTitle.backgroundColor = [UIColor whiteColor];
            mCell.thisTitle.textColor = WordColor_sub;
        }
        if ([now_label_id isEqualToString:@""]) {
            if (indexPath.row == 0) {
                mCell.thisTitle.backgroundColor = [UIColor redColor];
                mCell.thisTitle.textColor = [UIColor whiteColor];
            }
        }
    } else {
        SHouseBuyCommentList * list = thisArr[indexPath.row];
        mCell.thisTitle.text = [NSString stringWithFormat:@"%@(%@)",list.label_name,list.num];
        if ([list.label_id isEqualToString:now_label_id]) {
            mCell.thisTitle.backgroundColor = [UIColor redColor];
            mCell.thisTitle.textColor = [UIColor whiteColor];
        } else {
            mCell.thisTitle.backgroundColor = [UIColor whiteColor];
            mCell.thisTitle.textColor = WordColor_sub;
        }
        if ([now_label_id isEqualToString:@""]) {
            if (indexPath.row == 0) {
                mCell.thisTitle.backgroundColor = [UIColor redColor];
                mCell.thisTitle.textColor = [UIColor whiteColor];
            }
        }
    }
    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    SCarBuyCommentList * list = thisArr[indexPath.row];
    if (self.SHouseInfor_top_choice) {
        self.SHouseInfor_top_choice(list.label_id);
    }
}

@end
