//
//  SASegementControlView.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/16.
//  Copyright © 2018年 GYM. All rights reserved.
//

//#define BarHeight 50
#define ADAPTER_SCALE ScreenW / 414.0;

#import "SASegementControlView.h"
#import "SATotleKindsCell.h"

@interface SASegementControlView()<UIGestureRecognizerDelegate>
{
    UIButton *_arrowBtn;
}
/**
 数据源
 */
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) NSMutableArray *titles;

/**
 全部分类
 */
@property (nonatomic, strong) UILabel *totleKindsLab;

/**
 一条线
 */
@property (nonatomic, strong) UILabel *lineLab;

@end

@implementation SASegementControlView

-(instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas{
    self = [super initWithFrame:frame];
    if (self) {
        self.datas = datas;
        [self subViewSetting];
        self.isShowArrow = YES;
    }
    return self;
}

- (void)DropDownMenu:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    for (int i = 0; i < self.datas.count; i++) {
        SShopPickUpModel *model = self.datas[i];
        if (self.segmentedControl.selectIndexPath.item == i) {
            model.isClicked = YES;
        }else{
            model.isClicked = NO;
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.overView.collectionView reloadData];
    });
    
    [UIView animateWithDuration:.35 animations:^{
        self.totleKindsLab.alpha = btn.selected;
        self.overView.alpha = btn.selected;
        self.lineLab.alpha = btn.selected;
    }];
    
}

-(void)otherViewSettingWithSuperView:(UIView *)superView{
    CGFloat y = NAVIGATION_BAR_HEIGHT + [SASegementControlView barViewHeight];
    SASegementOverView *overView = [[SASegementOverView alloc] initWithFrame:CGRectMake(0, y, ScreenW, ScreenH - y) datas:self.datas];
    overView.alpha = 0;
    [superView addSubview:self.overView = overView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.overView.collectionView reloadData];
    });
    @weakify(self);
    self.overView.selectItemBlock = ^(NSInteger index) {
        [weak_self.segmentedControl reload:weak_self.titles
                               selectIndex:index
                                  animated:YES];
        [weak_self tapAction:nil];
    };
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [overView addGestureRecognizer:tap];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isMemberOfClass:[SASegementOverView class]] ) {
        return YES;
    }else{
        
        return NO;
    }
}


-(void)tapAction:(UITapGestureRecognizer *)tap{
   
    [self DropDownMenu:_arrowBtn];
}

#pragma mark - setter && getter

-(void)setIsShowArrow:(BOOL)isShowArrow{
    _isShowArrow = isShowArrow;
    if (_isShowArrow) {
       [self insertSubview:self.totleKindsLab aboveSubview:self.segmentedControl];
        [self addSubview:self.lineLab];
    }
}

+(CGFloat)barViewHeight{
    return 47;
}

- (UILabel *)lineLab{
    if (!_lineLab) {
        _lineLab = [UILabel new];
        _lineLab.backgroundColor = kLineColor;
        _lineLab.frame = CGRectMake(0, [SASegementControlView barViewHeight] - .5, CGRectGetWidth(self.bounds), .5);
        _lineLab.alpha = 0;
    }
    return _lineLab;
}

- (UILabel *)totleKindsLab{
    if (!_totleKindsLab) {
        _totleKindsLab = [UILabel new];
        // - CGRectGetHeight(self.bounds)
        _totleKindsLab.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        _totleKindsLab.text = @"全部分类";
        _totleKindsLab.textAlignment = 1;
        _totleKindsLab.backgroundColor = [UIColor whiteColor];
        _totleKindsLab.textColor = [UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1];
        _totleKindsLab.font = [UIFont systemFontOfSize:14];
        _totleKindsLab.alpha = 0;
    }
    return _totleKindsLab;
}

-(void)subViewSetting{
    
    self.segmentedControl = [[DZMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - self.bounds.size.height, self.bounds.size.height)];
    self.segmentedControl.itemAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorHex(0x333333)};
    
    self.segmentedControl.itemSelectAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
    //    self.segmentedControl.delegate = self;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.segmentedControl];
    
    self.segmentedControl.sliderHeight = 1.5;
    [self.segmentedControl reload:self.titles selectIndex:0 animated:NO];
    
    
    //添加箭头
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBtn.backgroundColor = [UIColor whiteColor];
    [arrowBtn setImage:[UIImage imageNamed:@"返回拷贝"] forState:UIControlStateNormal];
    [arrowBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateSelected];
    [arrowBtn addTarget:self action:@selector(DropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_arrowBtn = arrowBtn];
    
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.segmentedControl.mas_right);
        make.right.top.bottom.mas_equalTo(0);
    }];
    
}


- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    if(!_titles){
        _titles = [NSMutableArray array];
        for (SShopPickUpModel *model in _datas) {
            [_titles addObject:model.name];
        }
    }
    
}

@end


#pragma mark - 遮盖层

@interface SASegementOverView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



@property (assign,nonatomic)UIEdgeInsets edgeInset;

/**
 数据源
 */
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) NSMutableArray *titles;


@end

@implementation SASegementOverView

-(instancetype)initWithFrame:(CGRect)rect datas:(NSArray *)datas{
    self = [super initWithFrame:rect];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.25];
        self.edgeInset = UIEdgeInsetsMake(10, 5, 10, 5);
        self.datas = datas;
        [self addSubview:self.collectionView];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SATotleKindsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SATotleKindsCell" forIndexPath:indexPath];
    
    cell.pickUpModel = self.datas[indexPath.item];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.edgeInset;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectItemBlock) {
        self.selectItemBlock(indexPath.item);
    }
    
}

#pragma mark - setter && getter

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake((ScreenW - self.edgeInset.left * 5) / 4.0, 35);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SATotleKindsCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SATotleKindsCell class])];
        CGRect boundsRect = self.bounds;
        CGFloat height = 261 * (ScreenW / 414.0);
        boundsRect.size.height = height;
        _collectionView.frame = boundsRect;
    }
    return _collectionView;
}

- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    if(!_titles){
        _titles = [NSMutableArray array];
        for (SShopPickUpModel *model in _datas) {
            [_titles addObject:model.name];
        }
    }
    
}


@end
