//
//  STicketFight_NewContent.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SortHeadView.h"

typedef void(^STicketFight_NewContent_classBlock) (NSString *two_cate_id, NSString *short_name);
typedef void(^STicketFight_NewContent_inforBlock) (NSString * goods_id , NSString *a_id);//

typedef void(^STicketFight_NewContent_ScrollDelegateBlock) (CGFloat y);
typedef void(^STicketFight_NewContent_showRBlock) ();
typedef void(^STicketFight_NewContent_ShowModelAgainBlock) ();
typedef void(^STicketFight_NewContent_bannerViewBlock) ();
typedef void(^STicketFight_NewContent_fliterViewBlock) (NSString *searchType,NSString *para_order,NSString *para_fliter);

@interface STicketFight_NewContent : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
//筛选视图
@property (nonatomic, strong) SortHeadView *sortView;


/*
 *通知消息数据
 */
@property (nonatomic, strong) NSArray * noticeArr;

- (void)thisType:(NSString *)type;//1:票券区 2:拼团购 3:无界商店 4:无界预购 5:进口馆 6:推荐类型子类型（推荐、食品、生鲜、服饰、家具、进口、美食）7:6类型的子分类（只有列表）8:好收成超市
- (void)showModel:(NSArray *)arr andTwo_cate_list:(NSArray *)cate_Arr andBanner:(NSArray *)bannerArr andMyType:(NSString *)type;//1:票券区 2:拼团购 3:无界商店 4:无界预购 5:进口馆 6:推荐类型子类型（推荐、食品、生鲜、服饰、家具、进口、美食）7:6类型的子分类（只有列表）8:好收成超市
- (void)showSevenModel:(NSArray *)arr andMyType:(NSString *)type andCateType:(NSString *)cate_type;

- (void)flierViewSetting;
    

@property (nonatomic, copy) STicketFight_NewContent_classBlock STicketFight_NewContent_class;
@property (nonatomic, copy) STicketFight_NewContent_inforBlock STicketFight_NewContent_infor;
@property (nonatomic, copy) STicketFight_NewContent_ScrollDelegateBlock STicketFight_NewContent_ScrollDelegate;
@property (nonatomic, copy) STicketFight_NewContent_showRBlock STicketFight_NewContent_showR;
@property (nonatomic, copy) STicketFight_NewContent_ShowModelAgainBlock STicketFight_NewContent_ShowModelAgain;
@property (nonatomic, copy) STicketFight_NewContent_bannerViewBlock STicketFight_NewContent_bannerView;
@property (nonatomic, copy) STicketFight_NewContent_fliterViewBlock fliterViewBlock;
@end
