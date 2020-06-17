//
//  DZMSegmentedControl.m
//  AnimationTest
//
//  Created by fxg on 2018/7/5.
//  Copyright © 2018年 fxg. All rights reserved.
//

#import "DZMSegmentedControl.h"

@interface DZMSegmentedControl()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

//设置动画时间
double DZMSCDuration = 0.2;

@implementation DZMSegmentedControl

- (instancetype)init{
    self = [super initWithFrame:CGRectZero];
    if (self) {}
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addsubviews];
    }
    return self;
}


#pragma mark- Method

- (void)reload:(NSArray *)titles
   selectIndex:(NSInteger)selectIndex
      animated:(BOOL)animated{
    
    [self.itemSizes removeAllObjects];
    [self.itemTitleSizes removeAllObjects];
    [self.itemSliderRects removeAllObjects];
    
    self.isClickSelect = YES;
    self.titles = titles;
    self.selectIndexPath = nil;
    [self setSelectSliderView:nil animated:animated];
    [self.collectionView reloadData];
    
    if (titles.count > 0) {
        [self reloadItemSizes];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectIndex inSection:0];
        
        self.selectIndexPath = indexPath;
         [self setSelectSliderView:indexPath animated:animated];
        
        [self.collectionView selectItemAtIndexPath:indexPath animated:animated scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        if (self.delegate && [_delegate respondsToSelector:@selector(segmentControl:clickIndex:)]) {
            [_delegate segmentControl:self clickIndex:indexPath.item];
        }
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DZMSegmentedControlItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DZMSCI" forIndexPath:indexPath];
    cell.itemInset = self.itemInset;
    cell.itemAttributedText = [[NSAttributedString alloc] initWithString:self.titles[indexPath.item] attributes:self.itemAttributes];
    if (self.itemSelectAttributes != nil) {
      cell.itemSelectAttributedText = [[NSAttributedString alloc] initWithString:self.titles[indexPath.item] attributes:self.itemSelectAttributes];
    }else{
        cell.itemSelectAttributedText = nil;
    }
    
    cell.isSelect = (self.selectIndexPath == indexPath);
    if (cell.isSelect) {
        self.selectItem = cell;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.isClickSelect = YES;
   
    [collectionView selectItemAtIndexPath:indexPath animated:true scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    self.selectIndexPath = indexPath;

     [self setSelectSliderView:indexPath animated:YES];
    
    if (self.delegate && [_delegate respondsToSelector:@selector(segmentControl:clickIndex:)]) {
        [_delegate segmentControl:self clickIndex:indexPath.item];
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSValue *sizeValue = self.itemSizes[indexPath.item];
    
    return [sizeValue CGSizeValue];
}

// 重新计算所有Item大小
- (void)reloadItemSizes{
    if (self.titles.count) {
        CGFloat sliderH = self.sliderHeight;
        CGFloat sliderY = self.frame.size.height - sliderH;
        CGFloat lastItemX = 0.0f;
        for (NSString *title in self.titles) {
            CGSize itemTitleSize = [self getItemTitleSize:title attribute:self.itemAttributes];
            if (self.itemSelectAttributes != nil) {
                CGSize itemSelectTitleSize = [self getItemTitleSize:title attribute:self.itemSelectAttributes];
                
                itemTitleSize = itemTitleSize.width >= itemSelectTitleSize.width ? itemTitleSize : itemSelectTitleSize;
            }
            
            CGSize itemSize = CGSizeMake(itemTitleSize.width + self.itemInset.left + self.itemInset.right, self.bounds.size.height);
            CGRect appendRect = CGRectMake(lastItemX + self.itemInset.left, sliderY, itemTitleSize.width, sliderH);
            [self.itemSliderRects addObject:[NSValue valueWithCGRect:appendRect]];
            [self.itemTitleSizes addObject:[NSValue valueWithCGSize:itemTitleSize]];
            [self.itemSizes addObject:[NSValue valueWithCGSize:itemSize]];
            lastItemX += itemSize.width;
        }
        
    }else{
        [self.itemSizes removeAllObjects];
        [self.itemTitleSizes removeAllObjects];
        [self.itemSliderRects removeAllObjects];
    }
}

// 获取单个Item的大小
- (CGSize)getItemTitleSize:(NSString *)title attribute:(NSDictionary*)attributes{
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    
  CGSize thisSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    return [string boundingRectWithSize:thisSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;
}
 // 设置滚动条到选中位置
- (void)setSelectSliderView:(NSIndexPath *)indexPath
                   animated:(BOOL)animated{
    if (indexPath != nil) {
        NSValue *rectValue = self.itemSliderRects[indexPath.item];
        CGRect rect = [rectValue CGRectValue];
        if (animated) {
            [UIView animateWithDuration:DZMSCDuration animations:^{
                self.sliderView.frame = rect;
            }];
        }else{
            self.sliderView.frame = rect;
        }
    }else{
        self.sliderView.frame = CGRectZero;
    }
}

// 记录选中Item
- (void)setSelectIndexPath:(NSIndexPath *)selectIndexPath{
    if (_selectIndexPath != selectIndexPath) {
        _selectIndexPath = selectIndexPath;
        
        if (selectIndexPath != nil) {
            self.selectItem.isSelect = NO;
            self.selectItem = (DZMSegmentedControlItem *)[self.collectionView cellForItemAtIndexPath:_selectIndexPath];

            self.selectItem.isSelect = YES;
        }else{
            self.selectItem = nil;
        }
    }
}

- (void)setRegisterScrollView:(UIScrollView *)scrollView{
    if (_registerScrollView != scrollView) {
        if (_registerScrollView != nil) {
            [_registerScrollView.panGestureRecognizer removeTarget:self
                                                            action:@selector(touchPan:)];
            [_registerScrollView removeObserver:self
                                     forKeyPath:@"contentOffset"];
        }
    }
    _registerScrollView = scrollView;
    [_registerScrollView.panGestureRecognizer addTarget:self
                                                 action:@selector(touchPan:)];
    
    [_registerScrollView addObserver:self
                          forKeyPath:@"contentOffset"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
    
    
    
}

// 开始拖拽
- (void)touchPan:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.isClickSelect = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (!_isClickSelect) {
        [self monitor:self.registerScrollView];
    }
}

- (void)monitor:(UIScrollView *)scrollView{
    if (self.titles.count && self.selectIndexPath != nil) {
        CGFloat page = scrollView.contentOffset.x / scrollView.frame.size.width;
        CGRect currentRect = [self.itemSliderRects[self.selectIndexPath.item] CGRectValue];
        NSInteger nextIndex = self.selectIndexPath.item + 1;
        NSInteger lastIndex = self.selectIndexPath.item - 1;
        
        if (page > self.selectIndexPath.item) {   //下一个
            if (nextIndex < self.titles.count) {  //防止越界
                CGRect nextRect = [self.itemSliderRects[nextIndex] CGRectValue];
                CGFloat spaceScale = page - self.selectIndexPath.row;
                if (spaceScale <= 0.5) {
                    CGFloat nextSpaceW = CGRectGetMaxX(nextRect) - CGRectGetMaxX(currentRect);
                    CGFloat spaceW = nextSpaceW * MIN((spaceScale * 2.0), 1.0);
               
                    self.sliderView.frame = CGRectMake(currentRect.origin.x, currentRect.origin.y, currentRect.size.width + spaceW, currentRect.size.height);
                }else{
                    CGFloat totalW = CGRectGetMaxX(nextRect) - CGRectGetMinX(currentRect);
                     CGFloat nextSpaceW = CGRectGetMinX(nextRect) - CGRectGetMinX(currentRect);
                    CGFloat spaceW = nextSpaceW * MIN(((spaceScale - 0.5) * 2.0), 1.0);
                    
                    self.sliderView.frame = CGRectMake(CGRectGetMinX(currentRect)+ spaceW, nextRect.origin.y, totalW - spaceW, nextRect.size.height);
                    
                }
                
                if (page >= nextIndex) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:nextIndex inSection:0];
                    [self.collectionView selectItemAtIndexPath:indexPath
                                                      animated:true
                                                scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
                    self.selectIndexPath  = indexPath;
                }
            }
        }else{ // 上 一 个
            if (lastIndex >= 0) {
                CGRect lastRect = [self.itemSliderRects[lastIndex] CGRectValue];
                
                CGFloat spaceScale = self.selectIndexPath.item - page;
                
                if (spaceScale <= 0.5) {
                    
                    CGFloat lastSpaceW = CGRectGetMinX(currentRect) - CGRectGetMinX(lastRect);
                    CGFloat spaceW = lastSpaceW * MIN((spaceScale * 2.0), 1.0);
                    
                    self.sliderView.frame = CGRectMake(currentRect.origin.x - spaceW, currentRect.origin.y, currentRect.size.width + spaceW, currentRect.size.height);
                }else{
                    CGFloat totalW = CGRectGetMaxX(currentRect) - CGRectGetMinX(lastRect);
                    CGFloat lastSpaceW = CGRectGetMaxX(currentRect) - CGRectGetMaxX(lastRect);
                    CGFloat spaceW = lastSpaceW * MIN(((spaceScale - 0.5) * 2.0), 1.0);
                    
                    self.sliderView.frame = CGRectMake(lastRect.origin.x, lastRect.origin.y, totalW - spaceW, lastRect.size.height);
                }
                
                if (page <= lastIndex) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastIndex inSection:0];
                    [self.collectionView selectItemAtIndexPath:indexPath
                                                      animated:true
                                                scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
                    self.selectIndexPath  = indexPath;
                }
                
            }
            
        }
        
    }
    
}

- (void)dealloc{
    [self.registerScrollView removeObserver:self
                                 forKeyPath:@"contentOffset"
                                    context:nil];
    
    [self.registerScrollView.panGestureRecognizer removeTarget:self
                                                    action:@selector(touchPan:)];
}


#pragma mark- UI
- (void)addsubviews{
    
    self.itemAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    self.itemInset = UIEdgeInsetsMake(5, 10, 5, 10);
    self.isClickSelect = YES;
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsZero;
    self.collectionView.contentInset = self.contentInset;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:NSClassFromString(@"DZMSegmentedControlItem") forCellWithReuseIdentifier:@"DZMSCI"];
    [self addSubview:self.collectionView];
    
    self.sliderView = [UIView new];
    self.sliderHeight = 3;
    self.sliderView.backgroundColor = [UIColor redColor];
    self.sliderView.frame = CGRectMake(0, self.bounds.size.height - self.sliderHeight, 0, self.sliderHeight);
    [self.collectionView addSubview:self.sliderView];
}


#pragma mark- 懒加载

- (NSMutableArray *)itemSizes{
    if (!_itemSizes) {
        _itemSizes = [NSMutableArray array];
    }
    return _itemSizes;
}

- (NSMutableArray *)itemTitleSizes{
    if (!_itemTitleSizes) {
        _itemTitleSizes = [NSMutableArray array];
    }
    return _itemTitleSizes;
}

- (NSMutableArray *)itemSliderRects{
    if (!_itemSliderRects) {
        _itemSliderRects = [NSMutableArray array];
    }
    return _itemSliderRects;
}

- (void)setContentInset:(UIEdgeInsets)contentInset{
    _contentInset = contentInset;
    if (self.collectionView) {
        self.collectionView.contentInset = _contentInset;
    }
    
}

- (void)setSliderHeight:(CGFloat)sliderHeight{
    _sliderHeight = sliderHeight;
    if (self.sliderView) {
        CGRect tempFrame = self.sliderView.frame;
        tempFrame.origin.x = 0;
        tempFrame.origin.y = tempFrame.size.height - _sliderHeight;
        tempFrame.size.width = tempFrame.size.width;
        tempFrame.size.height = _sliderHeight;
        self.sliderView.frame = tempFrame;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

#pragma mark - DZMSegmentedControlItem

@interface DZMSegmentedControlItem()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DZMSegmentedControlItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    self.label = [UILabel new];
    [self.contentView addSubview:self.label];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(self.itemInset.left , self.itemInset.top, self.frame.size.width - self.itemInset.left * 2, self.frame.size.height - self.itemInset.top * 2);
    
}


- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (_isSelect && self.itemSelectAttributedText != nil) {
        self.label.attributedText = self.itemSelectAttributedText;
    }else{
        self.label.attributedText = self.itemAttributedText;
    }
}

-(void)setItemInset:(UIEdgeInsets)itemInset{
    _itemInset = itemInset;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end

