//
//  SItemView.m
//  XibTest
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 科技沃天. All rights reserved.
//

#import "SItemView.h"
#import "CategoryItemView.h"

#define SCROLL_START_INDEX 5  //因为是从0开始的index,此处的5是第6个item的索引

@interface SItemView ()
{
    NSInteger CURRENT_SHOW_MAX_INDEX;
    NSInteger CURRENT_SHOW_MIN_INDEX;
}

@property (nonatomic, weak) UIScrollView * itemScrollView;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, strong) NSArray * btnArr;

@property (nonatomic, assign) BOOL isScroll;
@property (nonatomic, assign) BOOL isSelectItem;


/**
 点击下拉箭头后的提示label
 */
@property (nonatomic, weak) UILabel * AllGoodTitleLabel;
/**
 下拉展示分类按钮
 */
@property (nonatomic, weak) UIButton * dropDownBtn;


@property (nonatomic, weak)  CategoryItemView * categoryItemView;
@end

@implementation SItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreatSubView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self CreatSubView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.itemScrollView.frame = self.bounds;
    self.AllGoodTitleLabel.frame = self.bounds;
    self.dropDownBtn.frame = CGRectMake(self.bounds.size.width - 39, 0, 39, self.bounds.size.height);
}
-(void)CreatSubView{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.itemScrollView = scrollView;
    [self addSubview:scrollView];

    
    UILabel * AllGoodTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    AllGoodTitleLabel.backgroundColor = [UIColor whiteColor];
    AllGoodTitleLabel.alpha = 0;
    AllGoodTitleLabel.text = @"全部分类";
    AllGoodTitleLabel.textColor = [UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1];
    AllGoodTitleLabel.font = [UIFont systemFontOfSize:13];
    AllGoodTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.AllGoodTitleLabel = AllGoodTitleLabel;
    [self addSubview:AllGoodTitleLabel];


    UIButton *DropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    DropDownBtn.backgroundColor = [UIColor whiteColor];
    DropDownBtn.hidden = YES;
    DropDownBtn.frame = CGRectMake(self.bounds.size.width - 39, 0, 39, self.bounds.size.height);
    [DropDownBtn setImage:[UIImage imageNamed:@"返回拷贝"] forState:UIControlStateNormal];
    [DropDownBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateSelected];
    [DropDownBtn addTarget:self action:@selector(DropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
    self.dropDownBtn = DropDownBtn;
    [self addSubview:DropDownBtn];
    
    
}
-(void)DropDownMenu:(UIButton *)btn{
    btn.selected = !btn.selected;
    NSLog(@"66666");
    
    if (!self.categoryItemView) {
        
        CategoryItemView * categoryItemView = [[CategoryItemView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) + 1, self.bounds.size.width, self.superview.bounds.size.height - CGRectGetMaxY(self.frame) + 1)];
        categoryItemView.alpha = 0;
        categoryItemView.itemsArr = self.itemsArray;
        self.categoryItemView = categoryItemView;
        [self.superview insertSubview:categoryItemView belowSubview:self];
        
        //点击黑色空白区域,隐藏categoryItemView
        __weak typeof(self) WeakSelf = self;
        categoryItemView.TapToHiddenCategoryBlock = ^{
            __strong typeof(WeakSelf) StrongSelf = WeakSelf;
            [StrongSelf DropDownMenu:btn];
        };
        
        //categoryItemView在选中一个item后,SItemView中的分类也跟着滚动到相同的item
        categoryItemView.selectedItemBlock = ^(NSInteger index) {
            WeakSelf.isSelectItem = YES;
            WeakSelf.ScrollSelectItemBlock(index);
        };
        
    }
    
    //展示和隐藏分类弹出框
    if (self.categoryItemView.showCategoryItemBlock) {
        self.categoryItemView.showCategoryItemBlock(btn.selected);        
    }
    
    //按钮图片箭头的切换
    if (btn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            self.AllGoodTitleLabel.alpha = 1;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.AllGoodTitleLabel.alpha = 0;
        }];
    }
}

-(void)setShowArrow:(BOOL)showArrow{
    _showArrow = showArrow;
    if (showArrow) {
        self.dropDownBtn.hidden = NO;
    }else{
        self.dropDownBtn.hidden = YES;
    }
}
-(void)setItemsArray:(NSArray *)itemsArray{
    _itemsArray = itemsArray;
    
    for ( ItemButton * btn in  self.itemScrollView.subviews ) {
        [btn removeFromSuperview];
    }
    //设置scrollView的ContentSize
    CGFloat itemHeight = self.bounds.size.height;
    if (itemsArray.count <= 5) {
        self.itemWidth = self.bounds.size.width / itemsArray.count;
    }else{
        self.itemWidth = self.bounds.size.width / 6;
    }
    self.itemScrollView.contentSize = CGSizeMake(self.showArrow ? self.itemWidth * itemsArray.count + self.dropDownBtn.bounds.size.width : self.itemWidth *  itemsArray.count, itemHeight);
    
    //创建标题
    NSMutableArray * tempMutableArr = [NSMutableArray array];
    for (int i = 0; i < itemsArray.count; i++) {
        ItemButton * btn = [ItemButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.itemWidth * i, 0, self.itemWidth, itemHeight);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:itemsArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemScrollView addSubview:btn];
        [tempMutableArr addObject:btn];
    }
    self.btnArr = [tempMutableArr copy];
    
    
    if (self.btnArr.count != 0) {
        //默认选中第一个
        [self selectItem:self.btnArr.firstObject];
        
        //只有当btnArr的count大于5的时候,才有滚动动画
        if (self.btnArr.count <= 5) return;
        
        //初始化滚动选中item的block
        __weak typeof(self) WeakSelf = self;
        self.ScrollSelectItemBlock = ^(NSInteger index) {
            
            __strong typeof(WeakSelf) StrongSelf = WeakSelf;
            
            StrongSelf.isScroll = YES;
            
            if (index >= 0 && index < StrongSelf.btnArr.count) {
                
                [StrongSelf selectItem:StrongSelf.btnArr[index]];
                
                //当index小于显示的第6个item的索引时,不滚动
                if (index < SCROLL_START_INDEX) {
                    [StrongSelf.itemScrollView setContentOffset:CGPointZero animated:YES];
                }else{
                    if (StrongSelf.isSelectItem) {//判断是不是由categoryItemView点击跳转到此
                        if (index > StrongSelf.btnArr.count - 6) {
                            [StrongSelf.itemScrollView setContentOffset:CGPointMake(StrongSelf.itemWidth * ((StrongSelf.btnArr.count - 1) - 4.5), 0) animated:YES];//设置滚动的偏移量,4.5是为了让被dropDownBtn遮盖的item显示完全
                        }else{
                            [StrongSelf.itemScrollView setContentOffset:CGPointMake(StrongSelf.itemWidth * ((index - SCROLL_START_INDEX) + 2.5), 0) animated:YES];//设置滚动的偏移量,2.5是为了让item居于屏幕中间
                        }
                    }else{
                        [StrongSelf.itemScrollView setContentOffset:CGPointMake(StrongSelf.itemWidth * (index - SCROLL_START_INDEX), 0) animated:YES];
                    }
                    
                }
            }
            StrongSelf.isScroll = NO;
        };
    }
    
}

//标题选中的操作
-(void)selectItem:(ItemButton *)selectBtn{
    for (ItemButton * btn in self.btnArr) {
        if (selectBtn == btn) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    
    NSInteger selectItemIndex = [self.btnArr indexOfObject:selectBtn];
    if (self.SelectItemBlock) {
        self.SelectItemBlock(selectItemIndex);
    }
    
    if (self.btnArr.count <= 5) return;

    if (self.isScroll == NO) {
        if (selectItemIndex < SCROLL_START_INDEX) {
            CURRENT_SHOW_MIN_INDEX = 0;
            CURRENT_SHOW_MAX_INDEX = 5;
        }else if (selectItemIndex < self.btnArr.count && selectItemIndex >= self.btnArr.count - 6){
            CURRENT_SHOW_MIN_INDEX = self.btnArr.count - 6;
            CURRENT_SHOW_MAX_INDEX = self.btnArr.count;
        }else{
            CURRENT_SHOW_MIN_INDEX = selectItemIndex - 6;
            CURRENT_SHOW_MAX_INDEX = selectItemIndex - 1;
        }
    }
    
}

-(void)RecoverDefaultItem{
    [self selectItem:self.btnArr.firstObject];
}

/**第一次构思时的代码,留作参考
 //                NSLog(@"max - %ld",(long)StrongSelf->CURRENT_SHOW_MAX_INDEX);
 //                NSLog(@"min - %ld",(long)StrongSelf->CURRENT_SHOW_MIN_INDEX);
 
 //                if (index > StrongSelf->CURRENT_SHOW_MAX_INDEX) {
 //                    //修改当前屏幕显示的最大值和最小值
 //                    StrongSelf->CURRENT_SHOW_MAX_INDEX = index;
 //                    StrongSelf->CURRENT_SHOW_MIN_INDEX += 1;
 //
 //                    //向高index滚动
 //                    [StrongSelf.itemScrollView setContentOffset:CGPointMake(StrongSelf.itemWidth * (index - SCROLL_START_INDEX), 0) animated:YES];
 //                }else if (index < StrongSelf->CURRENT_SHOW_MIN_INDEX) {
 //                    StrongSelf->CURRENT_SHOW_MIN_INDEX = index;
 //                    StrongSelf->CURRENT_SHOW_MAX_INDEX -= 1;
 //
 //                    //向低index滚动
 //                    [StrongSelf.itemScrollView setContentOffset:CGPointMake(StrongSelf.itemWidth * index, 0) animated:YES];
 //                }else{
 //
 ////                    if (StrongSelf.isSelectItem) {
 ////                        StrongSelf->CURRENT_SHOW_MIN_INDEX = index;
 ////                        StrongSelf->CURRENT_SHOW_MAX_INDEX -= 1;
 //
 //                        //向低index滚动
 //                        [StrongSelf.itemScrollView setContentOffset:CGPointMake(StrongSelf.itemWidth * index, 0) animated:YES];
 ////                    }
 //
 //                }
 
 
 //    if (self.isScroll == NO) {
 //        if (selectItemIndex < SCROLL_START_INDEX) {
 //            CURRENT_SHOW_MIN_INDEX = 0;
 //            CURRENT_SHOW_MAX_INDEX = 5;
 //        }else if (selectItemIndex < self.btnArr.count && selectItemIndex >= self.btnArr.count - 6){
 //            CURRENT_SHOW_MIN_INDEX = self.btnArr.count - 6;
 //            CURRENT_SHOW_MAX_INDEX = self.btnArr.count;
 //        }else{
 //            CURRENT_SHOW_MIN_INDEX = selectItemIndex - 5;
 //            CURRENT_SHOW_MAX_INDEX = selectItemIndex;
 //        }
 //    }

 
 
 else if (index > StrongSelf.btnArr.count - 2) {//当显示倒数第
 NSLog(@"大");
 [StrongSelf.itemScrollView setContentOffset:CGPointMake(StrongSelf.itemWidth * (StrongSelf.btnArr.count - 6), 0) animated:YES];
 }
 */
@end



#pragma mark - =========================== 自定义的ItemButton =============================
@interface ItemButton ()

/**
 底部线条
 */
@property (nonatomic, weak) UIView * bottomLineView;

@end
@implementation ItemButton

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self CreatBottomLineView];
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.bottomLineView.hidden = !selected;
}
-(void)CreatBottomLineView{
    CGFloat LineWidth = self.bounds.size.width * 0.7;
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - LineWidth) * 0.5, self.bounds.size.height - 2, LineWidth, 2)];
    lineView.hidden = YES;
    lineView.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:31.0/255.0 blue:25.0/255.0 alpha:1];;
    [self addSubview:lineView];
    self.bottomLineView = lineView;
}


@end
