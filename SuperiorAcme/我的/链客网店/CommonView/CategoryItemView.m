//
//  CategoryItemView.m
//  XibTest
//
//  Created by 科技沃天 on 2018/6/8.
//  Copyright © 2018年 科技沃天. All rights reserved.
//

#import "CategoryItemView.h"

#define ADAPTER_SCALE ScreenW / 414.0;

@interface CategoryItemView ()

@property (nonatomic, weak) UIScrollView * containScrollView;

@property (nonatomic, strong) UIButton * previousBtn;

@property (nonatomic, strong) NSArray * btnArr;

@end

@implementation CategoryItemView

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


-(void)CreatSubView{
    //设置背景色
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    CGFloat height = 261 * (ScreenW / 414.0);
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -height, self.bounds.size.width, height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.containScrollView = scrollView;
    [self addSubview:scrollView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToHiddenCategoryPopView:)];
    [self addGestureRecognizer:tapGesture];
    
    //初始化block回调
    __weak typeof(self) WeakSelf = self;
    self.showCategoryItemBlock = ^(BOOL isShow) {
        __strong typeof(WeakSelf) StrongSelf = WeakSelf;
        if (isShow) {
            [UIView animateWithDuration:0.5 animations:^{
                StrongSelf.alpha = 1;
                CGRect rect = StrongSelf.containScrollView.frame;
                rect.origin.y = 0;
                StrongSelf.containScrollView.frame = rect;
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                StrongSelf.alpha = 0;
                CGRect rect = StrongSelf.containScrollView.frame;
                rect.origin.y = -CGRectGetHeight(StrongSelf.containScrollView.frame);
                StrongSelf.containScrollView.frame = rect;
            }];
            
        }
    };
}

-(void)tapToHiddenCategoryPopView:(UITapGestureRecognizer *)tapGes{
    NSLog(@"888888");
    
    if (self.TapToHiddenCategoryBlock) {
        self.TapToHiddenCategoryBlock();
    }
}

-(void)setItemsArr:(NSArray *)itemsArr{
    _itemsArr = itemsArr;
    
    //创建点击的item
    [self AddSelectBtnForViewWithItemArr:itemsArr];
}

#pragma mark - =========================== 九宫格布局 =============================
-(void)AddSelectBtnForViewWithItemArr:(NSArray *)itemArr{
    //设置边距
    CGFloat marginToTop = 13 * ADAPTER_SCALE;//第一行到superView顶部的边距
    CGFloat marginToSide = 10 * ADAPTER_SCALE;//item到superView两边的距离
    CGFloat marginToItemX = 12 * ADAPTER_SCALE;//item到item间的水平间距
    CGFloat marginToItemY = 20 * ADAPTER_SCALE;//item到item间的垂直间距
    
    //每行列数
    NSInteger rank = 4;//每行显示的列数
    //计算按钮的宽高
    CGFloat btnW = (self.bounds.size.width - 2 * marginToSide - (rank - 1) * marginToItemX) / rank;
    CGFloat btnH = btnW * (30.0 / 89.0);//(30.0是默认的高度, 89.0是默认的宽度)

    NSMutableArray * tempMutableArr = [NSMutableArray array];
    UIButton * lastOneBtn = nil;//用于保存最后一个按钮,以计算scrollView的contentSize
    //遍历创建按钮
    for (int i = 0; i < itemArr.count; i++) {
        //Item X轴
        CGFloat X = marginToSide + (i % rank) * (btnW + marginToItemX);
        //Item Y轴
        NSUInteger Y = marginToTop + (i / rank) * (btnH + marginToItemY);
        //创建btn的frame
        CGRect frame = CGRectMake(X, Y, btnW, btnH);
        UIButton * btn = [self CreatItemButtonWithTitle:itemArr[i] andFrame:frame];
        //创建UIButton
        [self.containScrollView addSubview:btn];
        
        //保存第一个和最后一个按钮
        if (i == 0) {
            self.previousBtn = btn;
        }else if (i == itemArr.count - 1) {
            lastOneBtn = btn;
        }
        
        [tempMutableArr addObject:btn];
        self.btnArr = [tempMutableArr copy];
    }
    
    //设置scrollView的contentSize
    self.containScrollView.contentSize = CGSizeMake(self.containScrollView.bounds.size.width, CGRectGetMaxY(lastOneBtn.frame) + 20);
    //设置默认选中第一个
    [self selectCategoryItem:self.previousBtn];
}

-(UIButton *)CreatItemButtonWithTitle:(NSString *)title andFrame:(CGRect)frame{

    //创建button
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //不需要状态改变的属性的设置
    btn.frame = frame;
    btn.layer.cornerRadius = 15 * ADAPTER_SCALE;
    btn.titleLabel.lineBreakMode = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    [btn setTitle:title forState:UIControlStateNormal];
    
    //根据状态设置 - 文字的颜色
    [btn setTitleColor:[UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:231.996/255.0 green:31.0029/255.0 blue:24.0006/255.0 alpha:1] forState:UIControlStateSelected];
    
    
    //默认状态
    btn.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
    btn.layer.borderColor = [UIColor colorWithRed:232.0/255.0 green:31.0/255.0 blue:24.0/255.0 alpha:1].CGColor;
    
    //按钮添加点击方法
    [btn addTarget:self action:@selector(selectCategoryItem:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(void)selectCategoryItem:(UIButton *)btn{
    
    //设置上一个按钮是未选中的状态
    self.previousBtn.selected = NO;
    self.previousBtn.layer.borderWidth = 0;
    self.previousBtn.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];

    //设置当前点击的按钮是选中的状态
    btn.selected = YES;
    btn.layer.borderWidth = 1;
    btn.backgroundColor = [UIColor whiteColor];

    //将当前按钮赋值给上一个按钮
    self.previousBtn = btn;
    
    NSLog(@"999999");
    
    //点击选中item后,隐藏弹出的分类框
    [self tapToHiddenCategoryPopView:nil];
    
    //点击item后的索引的回调
    if (self.selectedItemBlock) {
        self.selectedItemBlock([self.btnArr indexOfObject:btn]);
    }
}

@end
