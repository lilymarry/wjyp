//
//  SOnlineShop_InfoListView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShop_InfoListView.h"
#import "SOnlineShop_ClassCell.h"
#import "STicketBuyTicketBuyIndex.h"//1
#import "SGroupBuyGroupBuyIndex.h"//2
#import "SIntegralBuyIntegralBuyIndex.h"//3
#import "SPreBuyPreBuyIndex.h"//4
#import "SCountryCountryGoods.h"//5
#import "SGoodsGoodsList.h"//6

/*
 *文字滚动视图
 */
#import "GYChangeTextView.h"

#import "BCCollectionViewHorizontalLayout.h"
#import "PagingCollectionViewLayout.h"

@interface SOnlineShop_InfoListView () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString * type;
    NSArray * thisArr;
    GYChangeTextView * tView;
}
@end

@implementation SOnlineShop_InfoListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOnlineShop_InfoListView" owner:self options:nil];
        [self addSubview:_thisView];
        [self createUI];
        /*
         *根据屏幕计算bannerview和noticeview的高度
         */
        self.bannerViewHeightCons.constant *= ScreenW/414.0;
        self.noticeViewHeightCons.constant *= ScreenW/414.0;
        /*
         *监听退出,停止或者开始动画
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GroupGoodListNoticeAnimatStatus:) name:@"GroupGoodListNoticeAnimatStatus" object:nil];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)createUI {
    PagingCollectionViewLayout * mFlowLayout = [[PagingCollectionViewLayout alloc]init];
//    mFlowLayout.itemCountPerRow = 5;
//    mFlowLayout.rowCount = 2;
    mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
//    mFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    mFlowLayout.itemSize = CGSizeMake(ScreenW/5, 100);//设置单元格的宽和高
    mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//各分区上下左右空白区域大小
    
    [_mCollect setCollectionViewLayout:mFlowLayout];
    _mCollect.pagingEnabled = YES;
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShop_ClassCell"];
}
- (void)showModel:(NSArray *)arr andMyType:(NSString *)myType {
    type = myType;
    thisArr = arr;
    [_mCollect reloadData];
    if (arr.count == 0) {
        _groView.hidden = NO;
    } else {
        _groView.hidden = YES;
    }
    /*
     *当是拼单购时,显示noticeView
     */
    if ([type isEqualToString:@"2"]) {
        self.noticeView.hidden = NO;
    }else{
        self.noticeView.hidden = YES;
    }
}

/*
 *NSNoticefication监听的回调
 */
-(void)GroupGoodListNoticeAnimatStatus:(NSNotification *)noti{
    BOOL GroupGoodListNoticeAnimatStatus = [noti.userInfo[@"GroupGoodListNoticeAnimatStatus"] boolValue];
    if (GroupGoodListNoticeAnimatStatus) {
        //开始通知消息轮播
        if (self.noticeArr!=nil&&self.noticeArr.count>0) {
            self.noticeArr = self.noticeArr;            
        }
    }else{
        //关闭通知消息轮播
        [tView stopAnimation];
    }
}
/*
 *根绝设置的显示的消息添加滚动的文字视图
 */
-(void)setNoticeArr:(NSArray *)noticeArr{
    _noticeArr = noticeArr;
    if ([type isEqualToString:@"2"]) {
        [self ShowNoticeWithNoriceMsgArr:noticeArr];        
    }
}
/*
 *加载文字滚动视图
 */
-(void)ShowNoticeWithNoriceMsgArr:(NSArray *)noticeArr;{
    //展示头条轮播
    NSMutableArray * headlinesArr = [[NSMutableArray alloc] init];
    for (NSString * notice in noticeArr) {
        [headlinesArr addObject:notice];
    }
    
    [tView removeFromSuperview];

    tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.noticeTipImageView.frame) + 10, 0, ScreenW - CGRectGetWidth(self.noticeTipImageView.frame) - 30, self.noticeViewHeightCons.constant - 20)];
    tView.textLabel.font = [UIFont systemFontOfSize:13];
    tView.textLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    [self.changeTextView addSubview:tView];
    if (headlinesArr.count != 0) {
        [tView animationWithTexts:headlinesArr];
    }
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
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShop_ClassCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_ClassCell" forIndexPath:indexPath];
    
    if ([type isEqualToString:@"1"]) {
        STicketBuyTicketBuyIndex * list = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.cate_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisContent.text = list.short_name;
    }
    if ([type isEqualToString:@"2"]) {
        SGroupBuyGroupBuyIndex * list = thisArr[indexPath.row];
        
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.cate_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisContent.text = list.short_name;
    }
    if ([type isEqualToString:@"3"]) {
        SIntegralBuyIntegralBuyIndex * list = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.cate_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisContent.text = list.short_name;
    }
    if ([type isEqualToString:@"4"]) {
        SIntegralBuyIntegralBuyIndex * list = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.cate_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisContent.text = list.short_name;
    }
    if ([type isEqualToString:@"5"]) {
        SCountryCountryGoods * list = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.cate_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisContent.text = list.short_name;
    }
    if ([type isEqualToString:@"6"]||[type isEqualToString:@"10"]||[type isEqualToString:@"11"]) {
        SGoodsGoodsList * list = thisArr[indexPath.row];
        [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.cate_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.thisContent.text = list.short_name;
    }
    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([type isEqualToString:@"1"]) {
        STicketBuyTicketBuyIndex * list = thisArr[indexPath.row];
        if (self.SOnlineShop_InfoListView_select) {
            self.SOnlineShop_InfoListView_select(list.two_cate_id,list.short_name);
        }
    }
    if ([type isEqualToString:@"2"]) {
        SGroupBuyGroupBuyIndex * list = thisArr[indexPath.row];
        if (self.SOnlineShop_InfoListView_select) {
            self.SOnlineShop_InfoListView_select(list.two_cate_id,list.short_name);
        }

    }
    if ([type isEqualToString:@"3"]) {
        SIntegralBuyIntegralBuyIndex * list = thisArr[indexPath.row];
        if (self.SOnlineShop_InfoListView_select) {
            self.SOnlineShop_InfoListView_select(list.two_cate_id,list.short_name);
        }

    }
    if ([type isEqualToString:@"4"]) {
        SIntegralBuyIntegralBuyIndex * list = thisArr[indexPath.row];
        if (self.SOnlineShop_InfoListView_select) {
            self.SOnlineShop_InfoListView_select(list.two_cate_id,list.short_name);
        }

    }
    if ([type isEqualToString:@"5"]) {
        SCountryCountryGoods * list = thisArr[indexPath.row];
        if (self.SOnlineShop_InfoListView_select) {
            self.SOnlineShop_InfoListView_select(list.two_cate_id,list.short_name);
        }

    }
    if ([type isEqualToString:@"6"]||[type isEqualToString:@"10"]||[type isEqualToString:@"11"]) {
        SGoodsGoodsList * list = thisArr[indexPath.row];
        if (self.SOnlineShop_InfoListView_select) {
            self.SOnlineShop_InfoListView_select(list.two_cate_id,list.short_name);
        }

    }
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
