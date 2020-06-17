//
//  SGoodsInfor_firstView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/10/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGroupBuyGroupBuyInfo.h"

@interface SGoodsInfor_firstView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (strong, nonatomic) IBOutlet UIView *bannerView;
@property (strong, nonatomic) IBOutlet UILabel *songR;
@property (strong, nonatomic) IBOutlet UILabel *songRTitle;
@property (strong, nonatomic) IBOutlet UIButton *priceInterBtn;

@property (strong, nonatomic) IBOutlet UILabel *is_end_desc;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *is_end_desc_HHH;
@property (strong, nonatomic) IBOutlet UILabel *is_new_goods_desc;
@property (strong, nonatomic) IBOutlet UIView *is_EndNewView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *is_EndNewView_HHH;
@property (strong, nonatomic) IBOutlet UIView *overTimeView;
@property (strong, nonatomic) IBOutlet UILabel *overTime;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *overTime_HHH;
@property (strong, nonatomic) IBOutlet UIImageView *overTime_needImage;
@property (strong, nonatomic) IBOutlet UILabel *overTime_needTitle;
@property (strong, nonatomic) IBOutlet UILabel *goods_name;
@property (strong, nonatomic) IBOutlet UILabel *shop_priceLeft;
@property (strong, nonatomic) IBOutlet UILabel *shop_price;
@property (strong, nonatomic) IBOutlet UILabel *market_price;
@property (strong, nonatomic) IBOutlet UIView *market_price_line;
@property (strong, nonatomic) IBOutlet UILabel *integral;
@property (strong, nonatomic) IBOutlet UILabel *wy_price;
@property (strong, nonatomic) IBOutlet UILabel *yx_price;
@property (strong, nonatomic) IBOutlet UILabel *sell_num;
@property (strong, nonatomic) IBOutlet UILabel *goods_num;
@property (weak, nonatomic) IBOutlet UILabel *top_freight;
@property (strong, nonatomic) IBOutlet UILabel *use_integral;
@property (weak, nonatomic) IBOutlet UIButton *use_integralBtn;
@property (strong, nonatomic) IBOutlet UILabel *goods_brief;
@property (strong, nonatomic) IBOutlet UIView *priceExplainView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *priceExplain_HHH;
@property (strong, nonatomic) IBOutlet UIView *threeNumView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *threeNum_HHH;
@property (strong, nonatomic) IBOutlet UIView *intergChangeView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *intergChange_HHH;
@property (strong, nonatomic) IBOutlet UIView *needInterView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *needInter_HHH;
@property (strong, nonatomic) IBOutlet UILabel *needInter_Num;
@property (strong, nonatomic) IBOutlet UIView *lastTimeView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lastTime_HHH;
@property (strong, nonatomic) IBOutlet UILabel *lastTime_num;
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property (strong, nonatomic) IBOutlet UIView *actionGround;
@property (strong, nonatomic) IBOutlet UILabel *action_Title;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *action_HHH;
@property (strong, nonatomic) IBOutlet UIView *blueView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *blue_HHH;
@property (strong, nonatomic) IBOutlet UIProgressView *proBlue;
@property (strong, nonatomic) IBOutlet UILabel *proBlue_num;
@property (strong, nonatomic) IBOutlet UILabel *proBlue_leftNum;
@property (strong, nonatomic) IBOutlet UILabel *proBlue_rigthNum;
@property (strong, nonatomic) IBOutlet UIView *introductView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *introduct_HHH;
@property (strong, nonatomic) IBOutlet UIView *dj_ticketView;
@property (strong, nonatomic) IBOutlet UIButton *dj_ticketBtn;
@property (weak, nonatomic) IBOutlet UILabel *group_type_title;
@property (weak, nonatomic) IBOutlet UILabel *conditionNum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marketPriceConstraintHeight;
/*
 *用于设置进度条在体验拼单中的显示
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *proBlueHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *proBlueToTopCons;
/*
 *体验拼单商品的已拼商品的进度的展示
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *proLabelToLeadingCons;
@property (weak, nonatomic) IBOutlet UILabel *proLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopPriceLeftGroup;
@property (weak, nonatomic) IBOutlet UILabel *shopPriceGroup;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;


/* overType:
 * 添加购物模式的类型
 */
@property (nonatomic, copy) NSString * overType;

/*
 *用于设置进度条在体验拼单中的显示
 */
@property (nonatomic, copy) NSString * group_buy_type_status;

@property (nonatomic, strong) SGroupBuyGroupBuyInfo * inforData;

//2980隐藏这个高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *di_ticket_view_HHH;

@property (weak, nonatomic) IBOutlet UILabel *tickNamelab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tickNameLabHHH;
@property (weak, nonatomic) IBOutlet UIImageView *ima_jiangPai;


@property (strong, nonatomic) IBOutlet UILabel *indexLab;

@property (strong, nonatomic) IBOutlet UIView *priceView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *priceViewHH;


@end
