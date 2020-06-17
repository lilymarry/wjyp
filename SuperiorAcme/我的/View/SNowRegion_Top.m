//
//  SNowRegion_Top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/10.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SNowRegion_Top.h"
#import "SShopCar_editViewCell.h"
#import "SAddressGetRegion.h"

@interface SNowRegion_Top () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * thisArr;
}
@property (weak, nonatomic) IBOutlet UILabel *nowCity;
@end
@implementation SNowRegion_Top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SNowRegion_Top" owner:self options:nil];
        [self addSubview:_thisView];
        
        UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 10;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 10;//用于控制单元格之间最小 行间距
        mFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        mFlowLayout.itemSize = CGSizeMake((ScreenW - 50 - 30)/3, 40);//设置单元格的宽和高
        mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);//各分区上下左右空白区域大小
        
        [_mCollect setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _mCollect.showsVerticalScrollIndicator = NO;
        //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
        [_mCollect registerNib:[UINib nibWithNibName:@"SShopCar_editViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SShopCar_editViewCell"];
        [_mCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"] == nil) {
            _nowCity.text = [NSString stringWithFormat:@"当前-%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"]];
        } else {
            _nowCity.text = [NSString stringWithFormat:@"当前-%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"]];
        }
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
    if (section == 0 || section == 1) {
        return 1;
    }
    return thisArr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = {0.01,50};
    return size;
}
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        UILabel * thisTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 100, 50)];
        [header addSubview:thisTitle];
        thisTitle.font = [UIFont systemFontOfSize:15];

        CGSize titleSize;
        if (indexPath.section == 0) {
            thisTitle.text = @"已定位城市";
            titleSize = [@"已定位城市" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
        } else if (indexPath.section == 1) {
            thisTitle.text = @"最近访问的城市";
            titleSize = [@"最近访问的城市" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];

        } else if (indexPath.section == 2) {
            thisTitle.text = @"热门城市";
            titleSize = [@"热门城市" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
        }
        thisTitle.frame = CGRectMake(10, 0, ScreenW - 20 - titleSize.width, 50);

        thisTitle.textColor = WordColor;
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10 + titleSize.width + 10, 24.5, ScreenW - 20 - titleSize.width, 0.5)];
        [header addSubview:line];
        line.backgroundColor = WordColor_sub_sub_sub;
        
        reusableview = header;
        
    }// header;
    return reusableview;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SShopCar_editViewCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SShopCar_editViewCell" forIndexPath:indexPath];
    mCell.thisTitle.layer.masksToBounds = YES;
    mCell.thisTitle.layer.cornerRadius = 3;
    mCell.thisTitle.layer.borderWidth = 0.5;
    mCell.thisTitle.layer.borderColor = MyLine.CGColor;
    
    if (indexPath.section == 0) {
        mCell.thisTitle.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"];
    }
    if (indexPath.section == 1) {
        mCell.thisTitle.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"];
    }
    if (indexPath.section == 2) {
        SAddressGetRegion * list = thisArr[indexPath.row];
        mCell.thisTitle.text = list.region_name;
    }
    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.SNowRegion_Top_myChoice) {
            self.SNowRegion_Top_myChoice([[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"]);
        }
    }
    if (indexPath.section == 1) {
        if (self.SNowRegion_Top_myChoice) {
            self.SNowRegion_Top_myChoice([[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"]);
        }
    }
    if (indexPath.section == 2) {
        SAddressGetRegion * list = thisArr[indexPath.row];
        if (self.SNowRegion_Top_myChoice) {
            self.SNowRegion_Top_myChoice(list.region_name);
        }
    }
    
}
@end
