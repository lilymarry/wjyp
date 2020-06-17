//
//  STicketFight_NewContent.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "STicketFight_NewContent.h"
#import "SOnlineShop_InfoListView.h"
#import "SNBannerView.h"
#import "SOnlineShopCell.h"
#import "SOnlineShopCell_2.h"
#import "SLineShop_infor_Left_subCon_R.h"

#import "CQPlaceholderView.h"
#import "STicketBuyTicketBuyIndex.h"//1
#import "SGroupBuyGroupBuyIndex.h"//2
#import "SIntegralBuyIntegralBuyIndex.h"//3
#import "SPreBuyPreBuyIndex.h"//4
#import "SCountryCountryGoods.h"//5
#import "SGoodsGoodsList.h"//6
#import "STicketBuyThreeList.h"//7-1
#import "SGroupBuyThreeList.h"//7-2
#import "SIntegralBuyThreeList.h"//7-3
#import "SPreBuyThreeList.h"//7-4
#import "SCountryThreeList.h"//7-5
#import "SGoodsThreeList.h"//7-7
#import "SOnlineShop_hotgoodsCell.h"


@interface STicketFight_NewContent () <SNBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,CQPlaceholderViewDelegate>
{
    SLineShop_infor_Left_subCon_R * rrr;
    SOnlineShop_InfoListView * top;
    NSString * myType;//1:票券区 2:拼团购 3:无界商店 4:无界预购 5:进口馆 6:推荐类型子类型（推荐、食品、生鲜、服饰、家具、进口、美食）7:6类型的子分类（只有列表）8:好收成超市  10: 爆款专区   11互清库存
    
    NSArray * thisArr;
    CQPlaceholderView * placeholderView;
    
    NSString * my_Cate_type;//零食分类（只有列表）需要判断接口
}


@end

@implementation STicketFight_NewContent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"STicketFight_NewContent" owner:self options:nil];
        [self addSubview:_thisView];
        
        UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
        _mCollect.collectionViewLayout = mFlowLayout;
        
        //隐藏滚轴
        _mCollect.showsHorizontalScrollIndicator = NO;
        [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
        [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell_2" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell_2"];
          [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShop_hotgoodsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShop_hotgoodsCell"];
        
        placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 + 15, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
        [_mCollect addSubview:placeholderView];
        placeholderView.hidden = YES;
        
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)thisType:(NSString *)type {
    myType = type;
    if ([type isEqualToString:@"7"]) {
        [top removeFromSuperview];
    }
    if (![type isEqualToString:@"8"]) {
        top = [[SOnlineShop_InfoListView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200 + 10 + 0.5 + ScreenW/1242*400 - 10)];
        [_mCollect addSubview:top];
        
        SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*400) delegate:self imageNames:@[@"首页header夏日冰爽",@"首页header夏日冰爽",@"首页header夏日冰爽"] currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
        [top.bannerView addSubview:banner];
        
//        top.SOnlineShop_InfoListView_select = ^{
//            if (self.STicketFight_NewContent_class) {
//                self.STicketFight_NewContent_class();
//            }
//        };
    }
    if ([type isEqualToString:@"8"]) {
        rrr = [[SLineShop_infor_Left_subCon_R alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 70)];
        [_mCollect addSubview:rrr];
        rrr.SLineShop_infor_Left_subCon_R_show = ^{
            if (self.STicketFight_NewContent_showR) {
                self.STicketFight_NewContent_showR();
            }
        };
    }
    [_mCollect reloadData];
}
- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index {
    if (self.STicketFight_NewContent_bannerView) {
        self.STicketFight_NewContent_bannerView();
    }
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    if (self.STicketFight_NewContent_ShowModelAgain) {
        self.STicketFight_NewContent_ShowModelAgain();
    }
}
- (void)showModel:(NSArray *)arr andTwo_cate_list:(NSArray *)cate_Arr andBanner:(NSArray *)bannerArr andMyType:(NSString *)type {
    myType = type;

    if (arr.count == 0) {
        placeholderView.hidden = NO;
        if ([type isEqualToString:@"2"]) {
            [placeholderView removeFromSuperview];
            placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 +110, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
            [_mCollect addSubview:placeholderView];
        }
        
        
    } else {
        placeholderView.hidden = YES;
    }
    thisArr = arr;
    top = [[SOnlineShop_InfoListView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200 + 10 + 0.5 + ScreenW/1242*400 - 10)];
    [_mCollect addSubview:top];
    [top showModel:cate_Arr andMyType:type];
    
    SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*400) delegate:self model:bannerArr URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
    [top.bannerView addSubview:banner];
    /*
     *当是拼单购时,重新计算top的frame
     */
    if ([type isEqualToString:@"2"]) {
        top.noticeViewToBannerCons.constant = -(top.bannerViewHeightCons.constant - banner.bounds.size.height);
        top.frame = CGRectMake(0, 0, ScreenW, 200 + 10 + 0.5 + ScreenW/1242*400 - 10 + top.noticeViewHeightCons.constant);
        
        /*
         *获取的通知消息数据
         */
        top.noticeArr = self.noticeArr;
    }
    
    top.SOnlineShop_InfoListView_select = ^(NSString *two_cate_id, NSString *short_name) {
        if (self.STicketFight_NewContent_class) {
            self.STicketFight_NewContent_class(two_cate_id,short_name);
        }
    };
    [_mCollect reloadData];
}
- (void)showSevenModel:(NSArray *)arr andMyType:(NSString *)type andCateType:(NSString *)cate_type {
    myType = type;
    my_Cate_type = cate_type;
    //推荐类型子类型（推荐、食品、生鲜、服饰、家具、进口、美食）的子分类（只有列表）
 
    
    placeholderView.frame = CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 - 100 - 64, 200, 200);
    
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    
    thisArr = arr;
    [_mCollect reloadData];
    
    [self flierViewSetting];
}

- (void)flierViewSetting{
    if ([myType isEqualToString:@"7"]) { //添加一个筛选分类
        if (!_sortView) {
            top = [[SOnlineShop_InfoListView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, [SortHeadView barviewHeight])];
            [_mCollect.superview addSubview:top];
            for (UIView *subView in top.subviews) {
                subView.hidden = YES;
            }
            SortHeadView *sortView = [SortHeadView instaceWithXIB];
            [top addSubview:_sortView = sortView];
            sortView.frame = sortView.superview.bounds;
            [sortView otherViewSettingWithSuperView:_thisView isContenNaviHeight:NO];
            _mCollect.keyboardDismissMode = 1;
            MJWeakSelf;
            _sortView.sortBlock = ^(UIButton *btn, NSString *searchType, BOOL isPriceBtn) {
                if (weakSelf.fliterViewBlock) {
                    weakSelf.fliterViewBlock(searchType, weakSelf.sortView.para_order, weakSelf.sortView.para_fliter);
                }
            };
        }
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
    if (![myType isEqualToString:@"7"] && ![myType isEqualToString:@"8"]) {
        if ([my_Cate_type isEqualToString:@"7"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
        /*
         *当时拼单购时,重新计算sectionInsert
         */
        if ([myType isEqualToString:@"2"]) {
            return UIEdgeInsetsMake(CGRectGetMaxY(top.frame), 0, 0, 0);
            
        }
        return UIEdgeInsetsMake(200 + 10 + 0.5 + ScreenW/1242*400 - 10, 0, 0, 0);
    }
    if ([myType isEqualToString:@"8"]) {
        return UIEdgeInsetsMake(70, 0, 0, 0);
    }
    
    if ([myType isEqualToString:@"7"]) { //添加一个筛选分类
        return UIEdgeInsetsMake([SortHeadView barviewHeight], 0, 0, 0);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([myType isEqualToString:@"1"]) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40);
    }
    if ([myType isEqualToString:@"3"]) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 40);
    }
    if ([myType isEqualToString:@"4"] ) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 30 + 40);
    }
    if ([myType isEqualToString:@"5"]) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40);
    }
    if ([myType isEqualToString:@"6"]) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40);
    }
    if ([myType isEqualToString:@"7"]) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40);
    }
    if ([myType isEqualToString:@"8"]) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40);
    }
    /*
     *隐藏掉拼单购的单买价后item的高度
     */
    if ([myType isEqualToString:@"2"]) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 150 + 40+20);
    }
    //爆款专区  互清库存
    if ([myType isEqualToString:@"10"]||[myType isEqualToString:@"11"]) {
    //   return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 24 + 40 + 15);
         return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 24 + 40 + 15+15 );
    }
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 170 + 40);
    
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([myType isEqualToString:@"1"]||[myType isEqualToString:@"3"]||[myType isEqualToString:@"4"]||[myType isEqualToString:@"5"]||[myType isEqualToString:@"6"]||[myType isEqualToString:@"7"]||[myType isEqualToString:@"8"]) {
        SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
        mCell.choiceBtn.hidden = YES;
        
        if ([myType isEqualToString:@"1"]) {
            mCell.top_oneView.hidden = NO;
            mCell.top_oneView_HHH.constant = 0;//0
            mCell.goodsImage_HHH.constant = 40;//40;
            mCell.top_twoView_HHH.constant = 40;//40;
            mCell.top_twoView.hidden = YES;
            mCell.integral_num.hidden = NO;//已售xx件
            
            mCell.goods_PriceView.hidden = NO;
            mCell.goods_priceHHH.constant = 30;//30
            
            mCell.carView.hidden = YES;
            mCell.carView_HHH.constant = 0;//70
            
            mCell.houseView.hidden = YES;
            mCell.houseView_HHH.constant = 0;//90
            
            mCell.redView.hidden = YES;
            mCell.redView_HHH.constant = 0;//30
            
            mCell.timeView.hidden = YES;
            mCell.timeView_HHH.constant = 0;//30
            mCell.blueView.hidden = YES;
            mCell.blueView_HHH.constant = 0;//30
            
            if (![my_Cate_type isEqualToString:@"7"]) {
                STicketBuyTicketBuyIndex * list = thisArr[indexPath.row];

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
                mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
                mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
                mCell.integral_price.text = list.integral;
                mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
            } else {
                
                STicketBuyThreeList * list = thisArr[indexPath.row];

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
                mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
                mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
                mCell.integral_price.text = list.integral;
                mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
            }
            
            
        }
        if ([myType isEqualToString:@"3"]) {
            mCell.top_oneView_HHH.constant = 0;
            mCell.top_oneTitle.hidden = YES;
            mCell.goodsImage_HHH.constant = 40;
            mCell.top_twoView_HHH.constant = 40;
            mCell.top_twoView.hidden = YES;
            mCell.integral_HHH.constant = 0;
            mCell.integralView.hidden = YES;
            mCell.carView_HHH.constant = 0;
            mCell.carView.hidden = YES;
            mCell.houseView_HHH.constant = 0;
            mCell.houseView.hidden = YES;
            mCell.timeView_HHH.constant = 0;
            mCell.timeView.hidden = YES;
            mCell.redView_HHH.constant = 0;
            mCell.redView.hidden = YES;
            mCell.blueView_HHH.constant = 0;
            mCell.blueView.hidden = YES;
            
            mCell.goods_priceOne.font = [UIFont systemFontOfSize:13];
            mCell.goods_priceTwo.hidden = YES;
            mCell.goods_priceTwo_line.hidden = YES;
            
            if (![my_Cate_type isEqualToString:@"7"]) {
                SIntegralBuyIntegralBuyIndex * list = thisArr[indexPath.row];

                [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                mCell.goodsTitle.text = list.goods_name;
                mCell.goods_priceOne.text = [NSString stringWithFormat:@"  兑换需要%@积分",list.use_integral];
                /*
                 *无界商城首页 - 兑换需要**积分 前 添加图片
                 */
                mCell.WuJieShopModel = list;
            } else {
                SIntegralBuyThreeList * list = thisArr[indexPath.row];

                [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                mCell.goodsTitle.text = list.goods_name;
                mCell.goods_priceOne.text = [NSString stringWithFormat:@"  兑换需要%@积分",list.use_integral];
                /*
                 *无界商城三级列表 - 兑换需要**积分 前 添加图片
                 */
                mCell.WuJieShopModel = list;
            }
            
        }
        if ([myType isEqualToString:@"4"]) {
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
            
            mCell.time_submit.hidden = YES;//提醒我
            
            mCell.timeView.hidden = NO;
            mCell.timeView_HHH.constant = 30;//30
            mCell.blueView.hidden = NO;
            mCell.blueView_HHH.constant = 30;//30
            
            if (![my_Cate_type isEqualToString:@"7"]) {
                SPreBuyPreBuyIndex * list = thisArr[indexPath.row];

                [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                mCell.top_oneTitle.text = [NSString stringWithFormat:@" 可使用%@%%代金券   ",list.ticket_buy_discount];
                [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                mCell.goodsTitle.text = list.goods_name;
                mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.deposit];
                mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
                mCell.integral_price.text = list.integral;
                mCell.blue_Num.text = [NSString stringWithFormat:@"已抢购%@件",list.sell_num];
                mCell.model = thisArr[indexPath.row];
                [mCell.blue_pro setProgress:[list.sell_num floatValue]/[list.success_max_num floatValue]];
                mCell.blue_proNum.text = [NSString stringWithFormat:@"%.0f%%",[list.sell_num floatValue]/[list.success_max_num floatValue] * 100];
            } else {
                
                SPreBuyThreeList * list = thisArr[indexPath.row];

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
                mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.deposit];
                mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
                mCell.integral_price.text = list.integral;
                mCell.blue_Num.text = [NSString stringWithFormat:@"已抢购%@件",list.sell_num];
                mCell.model = thisArr[indexPath.row];
                [mCell.blue_pro setProgress:[list.sell_num floatValue]/[list.success_max_num floatValue]];
                mCell.blue_proNum.text = [NSString stringWithFormat:@"%.0f%%",[list.sell_num floatValue]/[list.success_max_num floatValue] * 100];
            }
            
        }
        if ([myType isEqualToString:@"5"]) {
            mCell.top_oneView.hidden = NO;
            mCell.top_oneView_HHH.constant = 0;//0
            mCell.goodsImage_HHH.constant = 40;//40;
            mCell.top_twoView_HHH.constant = 40;//40;
            mCell.top_twoView.hidden = YES;
            mCell.integral_num.hidden = NO;//已售xx件
            
            mCell.goods_PriceView.hidden = NO;
            mCell.goods_priceHHH.constant = 30;//30
            
            mCell.carView.hidden = YES;
            mCell.carView_HHH.constant = 0;//70
            
            mCell.houseView.hidden = YES;
            mCell.houseView_HHH.constant = 0;//90
            
            mCell.redView.hidden = YES;
            mCell.redView_HHH.constant = 0;//30
            
            mCell.timeView.hidden = YES;
            mCell.timeView_HHH.constant = 0;//30
            mCell.blueView.hidden = YES;
            mCell.blueView_HHH.constant = 0;//30
            
            if (![my_Cate_type isEqualToString:@"7"]) {
                SCountryCountryGoods * list = thisArr[indexPath.row];

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
                mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
                mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
                mCell.integral_price.text = list.integral;
                mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
            } else {
                SCountryThreeList * list = thisArr[indexPath.row];

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
                mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
                mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
                mCell.integral_price.text = list.integral;
                mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
            }
            
        }
        if ([myType isEqualToString:@"6"]) {
            mCell.top_oneView.hidden = NO;
            mCell.top_oneView_HHH.constant = 0;//0
            mCell.goodsImage_HHH.constant = 40;//40;
            mCell.top_twoView_HHH.constant = 40;//40;
            mCell.top_twoView.hidden = YES;
            mCell.integral_num.hidden = NO;//已售xx件
            
            mCell.goods_PriceView.hidden = NO;
            mCell.goods_priceHHH.constant = 30;//30
            
            mCell.carView.hidden = YES;
            mCell.carView_HHH.constant = 0;//70
            
            mCell.houseView.hidden = YES;
            mCell.houseView_HHH.constant = 0;//90
            
            mCell.redView.hidden = YES;
            mCell.redView_HHH.constant = 0;//30
            
            mCell.timeView.hidden = YES;
            mCell.timeView_HHH.constant = 0;//30
            mCell.blueView.hidden = YES;
            mCell.blueView_HHH.constant = 0;//30
            
            SGoodsGoodsList * list = thisArr[indexPath.row];

            
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
            mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
            mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
            mCell.integral_price.text = list.integral;
            mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
            
        }
        if ([myType isEqualToString:@"7"]) {
            mCell.top_oneView.hidden = NO;
            mCell.top_oneView_HHH.constant = 0;//0
            mCell.goodsImage_HHH.constant = 40;//40;
            mCell.top_twoView_HHH.constant = 40;//40;
            mCell.top_twoView.hidden = YES;
            mCell.integral_num.hidden = NO;//已售xx件
            
            mCell.goods_PriceView.hidden = NO;
            mCell.goods_priceHHH.constant = 30;//30
            
            mCell.carView.hidden = YES;
            mCell.carView_HHH.constant = 0;//70
            
            mCell.houseView.hidden = YES;
            mCell.houseView_HHH.constant = 0;//90
            
            mCell.redView.hidden = YES;
            mCell.redView_HHH.constant = 0;//30
            
            mCell.timeView.hidden = YES;
            mCell.timeView_HHH.constant = 0;//30
            mCell.blueView.hidden = YES;
            mCell.blueView_HHH.constant = 0;//30
            
            SGoodsThreeList * list = thisArr[indexPath.row];

            
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
            mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
            mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
            mCell.integral_price.text = list.integral;
            mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];

        }
        if ([myType isEqualToString:@"8"]) {
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
            
            mCell.timeView.hidden = YES;
            mCell.timeView_HHH.constant = 0;//30
            mCell.blueView.hidden = YES;
            mCell.blueView_HHH.constant = 0;//30
        }
        return mCell;
    }
    
    else if ([myType isEqualToString:@"10"])
    {
        SOnlineShop_hotgoodsCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_hotgoodsCell" forIndexPath:indexPath];
        
        
        SGoodsGoodsList * list = thisArr[indexPath.row];
        [mCell.country_logo sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [mCell.googImag sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodName.text=list.goods_name;
     
        
        mCell.lab_use_voucher.text=  [NSString stringWithFormat:@"爆款价¥%@",list.shop_price];
 
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"市场价¥%@ 已售%@件",list.market_price,list.sell_num]];
        [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(3,list.market_price.length+1)];
        mCell.goodsPrice.attributedText = AttributedStr;
        return mCell;
    }
    else if ([myType isEqualToString:@"11"])
    {
        SOnlineShop_hotgoodsCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_hotgoodsCell" forIndexPath:indexPath];
        
        
        SGoodsGoodsList * list = thisArr[indexPath.row];
        [mCell.country_logo sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [mCell.googImag sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodName.text=list.goods_name;
        
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.discountLab.backgroundColor = WordColor_sub_sub;
            mCell.discountLab.text = @"不可使用代金券";
        } else {
            mCell.discountLab.backgroundColor = [UIColor orangeColor];
            mCell.discountLab.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
         mCell.goodName.text=list.goods_name;
        
      //   mCell.goodsPrice.text=[NSString stringWithFormat:@"¥%@ ¥%@",list.shop_price,list.market_price];
        [mCell.goodsPrice setTextColor:[UIColor redColor]];
        
         NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@ ¥%@",list.shop_price,list.market_price]];
        
             [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(list.shop_price.length+2,list.market_price.length+1)];
        
                [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(list.shop_price.length+2,list.market_price.length+1)];
        
        
                mCell.goodsPrice.attributedText = AttributedStr;
        
        
        mCell.lab_use_voucher.text=  [NSString stringWithFormat:@"库存%@件 已售%@件",list.kucun_num,list.sell_num];
        mCell.lab_use_voucher.textAlignment=NSTextAlignmentRight;
        mCell.lab_use_voucher.textColor=[UIColor lightGrayColor];
        //    mCell.goodName.text=list.goods_name;  mCell.goodsPrice.text=[NSString stringWithFormat:@"市场价¥%@ 已售%@",list.market_price,list.sell_num];
//        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"市场价¥%@ 已售%@件",list.market_price,list.sell_num]];
//        [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(3,list.market_price.length+1)];
//        mCell.goodsPrice.attributedText = AttributedStr;
        return mCell;
    }
    
    SOnlineShopCell_2 *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell_2" forIndexPath:indexPath];
    
    if (![my_Cate_type isEqualToString:@"7"]) {
        SGroupBuyGroupBuyIndex * list = thisArr[indexPath.row];
        
        /*
         *添加体验拼单商品提示
         */
        if ([list.group_type isEqualToString:@"1"]) {
            //            NSLog(@"试用品拼单");
            mCell.onTrialTipImageView.hidden = NO;
        }else{
            mCell.onTrialTipImageView.hidden = YES;
        }
        
        [mCell.country_logo sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_title.backgroundColor = WordColor_sub_sub;
            mCell.top_title.text = @"不可使用代金券";
        } else {
            mCell.top_title.backgroundColor = [UIColor orangeColor];
            mCell.top_title.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goods_name.text = list.goods_name;
        mCell.group_price.text = [NSString stringWithFormat:@"￥%@",list.group_price];
        mCell.simple_num.text = [NSString stringWithFormat:@"(%@人拼单价)",list.group_num];
        /*
         *不显示单买价
         *将simple_proce的高度约束设置为0
         */
//        mCell.simple_proce.text = [NSString stringWithFormat:@"单买价:￥%@",list.shop_price];
        mCell.simple_proceHeightCons.constant = 0;
        mCell.total.text = [NSString stringWithFormat:@"已拼:%@件",list.total];
        mCell.integral.text = list.integral;
        
        if (list.append_person.count == 0) {
            mCell.header1.hidden = YES;
            mCell.header2.hidden = YES;
        } else if (list.append_person.count == 1) {
            SGroupBuyGroupBuyIndex * list_pic = list.append_person.firstObject;
            [mCell.header1 sd_setImageWithURL:[NSURL URLWithString:list_pic.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            mCell.header1.hidden = NO;
            mCell.header2.hidden = YES;
        } else if (list.append_person.count == 2) {
            SGroupBuyGroupBuyIndex * list_pic = list.append_person.firstObject;
            [mCell.header1 sd_setImageWithURL:[NSURL URLWithString:list_pic.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            SGroupBuyGroupBuyIndex * list_pic_sub = list.append_person[1];
            [mCell.header2 sd_setImageWithURL:[NSURL URLWithString:list_pic_sub.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            mCell.header1.hidden = NO;
            mCell.header2.hidden = NO;
        }
    } else {
        SGroupBuyThreeList * list = thisArr[indexPath.row];
        [mCell.country_logo sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_title.backgroundColor = WordColor_sub_sub;
            mCell.top_title.text = @"不可使用代金券";
        } else {
            mCell.top_title.backgroundColor = [UIColor orangeColor];
            mCell.top_title.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goods_name.text = list.goods_name;
        mCell.group_price.text = [NSString stringWithFormat:@"￥%@",list.group_price];
        mCell.total.text = [NSString stringWithFormat:@"已拼%@件",list.total];
        mCell.integral.text = list.integral;
        
        if (list.append_person.count == 0) {
            mCell.header1.hidden = YES;
            mCell.header2.hidden = YES;
        } else if (list.append_person.count == 1) {
            SGroupBuyGroupBuyIndex * list_pic = list.append_person.firstObject;
            [mCell.header1 sd_setImageWithURL:[NSURL URLWithString:list_pic.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            mCell.header1.hidden = NO;
            mCell.header2.hidden = YES;
        } else if (list.append_person.count == 2) {
            SGroupBuyGroupBuyIndex * list_pic = list.append_person.firstObject;
            [mCell.header1 sd_setImageWithURL:[NSURL URLWithString:list_pic.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            SGroupBuyGroupBuyIndex * list_pic_sub = list.append_person[1];
            [mCell.header2 sd_setImageWithURL:[NSURL URLWithString:list_pic_sub.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            mCell.header1.hidden = NO;
            mCell.header2.hidden = NO;
        }
    }
    
    
    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([myType isEqualToString:@"1"]) {
        
        if (![my_Cate_type isEqualToString:@"7"]) {
            STicketBuyTicketBuyIndex * list = thisArr[indexPath.row];
            if (self.STicketFight_NewContent_infor) {
                self.STicketFight_NewContent_infor(list.goods_id,nil);
            }
        } else {
            
            STicketBuyThreeList * list = thisArr[indexPath.row];
            if (self.STicketFight_NewContent_infor) {
                self.STicketFight_NewContent_infor(list.goods_id,nil);
            }
        }
        
        
    }
    if ([myType isEqualToString:@"2"]) {
        if (![my_Cate_type isEqualToString:@"7"]) {
            SGroupBuyGroupBuyIndex * list = thisArr[indexPath.row];
            if (self.STicketFight_NewContent_infor) {
                if ([list.group_type isEqualToString:@"1"]) {
                      self.STicketFight_NewContent_infor(list.group_buy_id,list.a_id);
                }
                else
                {
                    self.STicketFight_NewContent_infor(list.group_buy_id,nil);
                }
                
              
            }
        } else {
            SGroupBuyThreeList * list = thisArr[indexPath.row];
           
            if (self.STicketFight_NewContent_infor) {
                if ([list.group_type isEqualToString:@"1"]) {
                    self.STicketFight_NewContent_infor(list.group_buy_id,list.a_id);
                }
                else
                {
                   self.STicketFight_NewContent_infor(list.group_buy_id,nil);
                }
            }
         }
    }
    if ([myType isEqualToString:@"3"]) {
        if (![my_Cate_type isEqualToString:@"7"]) {
            SIntegralBuyIntegralBuyIndex * list = thisArr[indexPath.row];
            if (self.STicketFight_NewContent_infor) {
                self.STicketFight_NewContent_infor(list.integral_buy_id,nil);
            }
        } else {
            SIntegralBuyThreeList * list = thisArr[indexPath.row];
            if (self.STicketFight_NewContent_infor) {
                self.STicketFight_NewContent_infor(list.integral_buy_id,nil);
            }
        }
    }
    if ([myType isEqualToString:@"4"]) {
        if (![my_Cate_type isEqualToString:@"7"]) {
            SPreBuyPreBuyIndex * list = thisArr[indexPath.row];
            if (self.STicketFight_NewContent_infor) {
                self.STicketFight_NewContent_infor(list.pre_buy_id,nil);
            }
        } else {
            
            SPreBuyThreeList * list = thisArr[indexPath.row];
            if (self.STicketFight_NewContent_infor) {
                self.STicketFight_NewContent_infor(list.pre_buy_id,nil);
            }
        }
    }
    if ([myType isEqualToString:@"5"]) {
        if (![my_Cate_type isEqualToString:@"7"]) {
            SCountryCountryGoods * list = thisArr[indexPath.row];
            if (self.STicketFight_NewContent_infor) {
                self.STicketFight_NewContent_infor(list.goods_id,nil);
            }
        } else {
            SCountryThreeList * list = thisArr[indexPath.row];
            if (self.STicketFight_NewContent_infor) {
                self.STicketFight_NewContent_infor(list.goods_id,nil);
            }
        }
    }
    if ([myType isEqualToString:@"6"]||[myType isEqualToString:@"10"]||[myType isEqualToString:@"11"]) {
        SGoodsGoodsList * list = thisArr[indexPath.row];
        if (self.STicketFight_NewContent_infor) {
            self.STicketFight_NewContent_infor(list.goods_id,nil);
        }
    }
    if ([myType isEqualToString:@"7"]) {
        SGoodsThreeList * list = thisArr[indexPath.row];
        if (self.STicketFight_NewContent_infor) {
            self.STicketFight_NewContent_infor(list.goods_id,nil);
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _mCollect) {
        if (self.STicketFight_NewContent_ScrollDelegate) {
            self.STicketFight_NewContent_ScrollDelegate(scrollView.contentOffset.y);
        }
    }
    

}
@end
