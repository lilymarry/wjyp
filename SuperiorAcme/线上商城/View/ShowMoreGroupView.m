//
//  ShowMoreGroupView.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "ShowMoreGroupView.h"
#import "QGoodsInfor_first_groupCell.h"


@interface ShowMoreGroupView ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionFlowLayout;
@property (weak, nonatomic) IBOutlet UIView *ContainerView;
//高度约束,用于设置底部最多只显示10个拼单信息的文字的显示和隐藏
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MaxTenGroupLabelHeightCons;

//最多只显示10个拼单信息
@property (nonatomic, strong) NSMutableArray * lessTenGroupArr;

@end

static NSString * GroupCellID = @"GroupCellID";

@implementation ShowMoreGroupView

+(instancetype)CreatShowMoreGroupView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];

    //初始化子控件
    [self initializeSubView];
    
}

//初始化子控件
-(void)initializeSubView{
    
    _ContainerView.layer.cornerRadius = 5;
    _ContainerView.layer.masksToBounds = YES;
    
    [_MoreGroupCollection registerNib:[UINib nibWithNibName:NSStringFromClass([QGoodsInfor_first_groupCell class]) bundle:nil] forCellWithReuseIdentifier:GroupCellID];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionFlowLayout = layout;
    
    //添加手势
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenMoreGroupView:)];
    tapGes.delegate = self;
    [self addGestureRecognizer:tapGes];
}
//从父控件中移除
-(void)hiddenMoreGroupView:(UITapGestureRecognizer *)TapGes{
    self.hidden = YES;
    [self removeFromSuperview];
}

//重写groupArr的setter
-(void)setGroupArr:(NSArray *)groupArr{
    _groupArr = groupArr;
    if (groupArr.count < 10) {
        _MaxTenGroupLabelHeightCons.constant = 0;
        [self.lessTenGroupArr addObjectsFromArray:groupArr];
    }else{
        _MaxTenGroupLabelHeightCons.constant = 50;
        for (int i = 0; i < 10 ; i++) {
            SGroupBuyGroupBuyInfo * list = groupArr[i];
            [self.lessTenGroupArr addObject:list];
        }
    }
    
    [_MoreGroupCollection reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.lessTenGroupArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QGoodsInfor_first_groupCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:GroupCellID forIndexPath:indexPath];
    
    //显示cell中的分割线的
    cell.topSeparatorLineView.hidden = YES;
    cell.bottomSeparatorLineView.hidden = NO;
    
    //显示cell中的数据
    SGroupBuyGroupBuyInfo * list = self.lessTenGroupArr[indexPath.row];
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.head_user.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.nickname.text = list.head_user.nickname;
    cell.model = list;
    
    return cell;
    
}

#pragma mark 定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width, 85);
}
#pragma mark 定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark 定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark 点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self hiddenMoreGroupView:nil];
    if (self.jumpFightGroupBlock) {
        self.jumpFightGroupBlock(self.lessTenGroupArr[indexPath.row]);
    }
}

#pragma mark 设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//控制可点击的范围
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[ShowMoreGroupView class]]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 重写getter方法
-(NSMutableArray *)lessTenGroupArr{
    if (!_lessTenGroupArr) {
        _lessTenGroupArr = [NSMutableArray array];
    }
    return _lessTenGroupArr;
}
@end
