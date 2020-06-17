//
//  SLimited_NewContent.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimited_NewContent.h"
#import "SNBannerView.h"
#import "SOnlineShopCell.h"

#import "SLimitBuyLimitBuyIndex.h"
#import "CQPlaceholderView.h"

@interface SLimited_NewContent () <SNBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CQPlaceholderViewDelegate>
{
//    NSString * myType;
    UILabel * topTitle;
    NSArray * thisArr;
    CQPlaceholderView * placeholderView;

}
@end

@implementation SLimited_NewContent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLimited_NewContent" owner:self options:nil];
        [self addSubview:_thisView];
        
        UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
        _mCollect.collectionViewLayout = mFlowLayout;
        
        //隐藏滚轴
        _mCollect.showsHorizontalScrollIndicator = NO;
        [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
        
        placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
        [_mCollect addSubview:placeholderView];
        placeholderView.hidden = YES;
        
        topTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,  ScreenW/1242*400, ScreenW, 50)];
        [_mCollect addSubview:topTitle];
        topTitle.font = [UIFont systemFontOfSize:13];
        topTitle.textAlignment = NSTextAlignmentCenter;

        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)thisType:(NSString *)type {
//    myType = type;
//    if ([type isEqualToString:@"1"]) {
//        topTitle.text = @"已经开始";
//        topTitle.textColor = WordColor_sub;
//    } else if ([type isEqualToString:@"2"]) {
//        topTitle.text = @"距离本场结束 00:37:43";
//        topTitle.textColor = WordColor_sub;
//    } else if ([type isEqualToString:@"3"]) {
//        topTitle.text = @"21:00准时开抢";
//        topTitle.textColor = [UIColor redColor];
//    }
//    [_mCollect reloadData];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    if (self.SLimited_NewContent_showModel) {
        self.SLimited_NewContent_showModel();
    }
}
- (void)showModel:(NSArray *)arr andBanner:(NSArray *)bannerArr andContent:(NSString *)content{
    SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*400) delegate:self model:bannerArr URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
    [_mCollect addSubview:banner];
    topTitle.text = content;
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    thisArr = arr;
    [_mCollect reloadData];
}
- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index {
    if (self.SLimited_NewContent_bannerView) {
        self.SLimited_NewContent_bannerView();
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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake( ScreenW/1242*400 + 50, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 30 + 40);
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    mCell.choiceBtn.hidden = YES;
    
    mCell.top_oneView.hidden = NO;
    mCell.top_oneView_HHH.constant = 0;//0
    mCell.goodsImage_HHH.constant = 40;//40;
    mCell.top_twoView_HHH.constant = 40;//40;
    mCell.top_twoView.hidden = YES;
    mCell.integral_num.hidden = YES;//已售xx件
    
    mCell.goods_PriceView.hidden = NO;
    mCell.goods_priceHHH.constant = 30;//30
    
    mCell.carView.hidden = YES;
    mCell.carView_HHH.constant = 0;//70
    
    mCell.houseView.hidden = YES;
    mCell.houseView_HHH.constant = 0;//90
    
    mCell.redView.hidden = YES;
    mCell.redView_HHH.constant = 0;//30
    
    
    
//    mCell.blue_Num.text = @"已抢购19件";
    mCell.timeView.hidden = NO;
    mCell.timeView_HHH.constant = 30;//30
    mCell.blueView.hidden = NO;
    mCell.blueView_HHH.constant = 30;//30
    
    SLimitBuyLimitBuyIndex * list = thisArr[indexPath.row];
    NSLog(@"end_time:%@",list.end_time);

    [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    if ([list.ticket_buy_discount integerValue] == 0) {
        mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
        mCell.top_oneTitle.text = @"不可使用代金券";
    } else {
        mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
        mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
    }
    [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    mCell.goodsTitle.text = list.goods_name;
    mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.limit_price];
    mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
    mCell.integral_price.text = list.integral;
    mCell.blue_Num.text = [NSString stringWithFormat:@"已抢购%@件",list.sell_num];
    if ([list.end_time integerValue] < time(NULL)) {
        mCell.timeOver.hidden = NO;
    } else {
        mCell.timeOver.hidden = YES;
    }
    mCell.model = thisArr[indexPath.row];
    [mCell.blue_pro setProgress:[list.sell_num floatValue]/([list.sell_num floatValue] + [list.limit_store floatValue])];
    mCell.blue_proNum.text = [NSString stringWithFormat:@"%.0f%%",[list.sell_num floatValue]/([list.sell_num floatValue] + [list.limit_store floatValue]) * 100];
    if ([list.is_remind isEqualToString:@"3"]) {
        mCell.time_submit.hidden = NO;//提醒我
    } else {
        mCell.time_submit.hidden = YES;//提醒我
    }
    [mCell.time_submit addTarget:self action:@selector(time_submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [mCell.time_submit setTag:indexPath.row];
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SLimitBuyLimitBuyIndex * list = thisArr[indexPath.row];
    if (self.SLimited_NewContent_infor) {
        self.SLimited_NewContent_infor(list.limit_buy_id);
    }
}
- (void)time_submitClick:(UIButton *)btn {
    SLimitBuyLimitBuyIndex * list = thisArr[btn.tag];
    if (self.SLimited_NewContent_set) {
        self.SLimited_NewContent_set(list.limit_buy_id);
    }
}
@end
