//
//  QGoodsInfor_first_header3Reusa.h
//  SuperiorAcme
//
//  Created by GYM on 2017/10/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<WebKit/WebKit.h>
typedef void(^QGoodsInfor_first_header3Reusa_HTMLBlock) (NSInteger num);
typedef void(^QGoodsInfor_first_header3Reusa_downOneBtnBlock) ();
typedef void(^QGoodsInfor_first_header3Reusa_downTwoBtnBlock) ();
typedef void(^QGoodsInfor_first_header3Reusa_downThreeBtnBlock) ();
typedef void(^QGoodsInfor_first_header3Reusa_showImageBlock) ();

@interface QGoodsInfor_first_header3Reusa : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIView *evaImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *evaImageView_HHH;
@property (strong, nonatomic) IBOutlet UICollectionView *evaCollect;

@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UILabel *num1;
@property (strong, nonatomic) IBOutlet UILabel *num2;
@property (strong, nonatomic) IBOutlet UILabel *num3;
@property (strong, nonatomic) IBOutlet UIView *collocationView;
@property (strong, nonatomic) IBOutlet UILabel *collocationR;
@property (strong, nonatomic) IBOutlet UILabel *songR;
@property (strong, nonatomic) IBOutlet UILabel *delPriceR;
@property (strong, nonatomic) IBOutlet UILabel *total;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *thisContent;
@property (strong, nonatomic) IBOutlet UILabel *create_time;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *eva_topHHH;
@property (strong, nonatomic) IBOutlet UIView *eva_TitleView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *eva_TitleViewHHH;
@property (strong, nonatomic) IBOutlet UIView *evaHiddenView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *evaHiddenView_HHH;

@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UILabel *merchant_name;
@property (strong, nonatomic) IBOutlet UILabel *all_goods;
@property (strong, nonatomic) IBOutlet UILabel *view_num;
@property (strong, nonatomic) IBOutlet UILabel *group_price;
@property (strong, nonatomic) IBOutlet UILabel *integral;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collocation_topHHH;
@property (strong, nonatomic) IBOutlet UIView *collocation_TitleView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collocation_TitleViewHHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collocation_HHH;
@property (strong, nonatomic) IBOutlet UIView *collocation_DownView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collocation_DownViewHHH;

- (void)showModel:(NSArray *)arr;
- (void)showModelBrr:(NSArray *)brr;

@property (strong, nonatomic) IBOutlet UILabel *package_list;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *package_list_HHH;
@property (strong, nonatomic) IBOutlet UIView *package_listView;
@property (strong, nonatomic) IBOutlet UILabel *after_sale_service;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *after_sale_service_HHH;
@property (strong, nonatomic) IBOutlet UIView *after_sale_serviceView;
@property (strong, nonatomic) IBOutlet UILabel *price_desc;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *price_desc_HHH;
@property (strong, nonatomic) IBOutlet UIView *price_descView;

@property (strong, nonatomic) IBOutlet UIView * thisWk_web;
@property (nonatomic, strong) WKWebView * wk_web;//极速web
@property (nonatomic, strong) UIButton * imageBtn;//看图
@property (weak, nonatomic) IBOutlet UIButton *evaBtn;


@property (strong, nonatomic) IBOutlet UIView *downOne;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downOne_HHH;
@property (strong, nonatomic) IBOutlet UIView *downTwo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downTwo_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downTwo_topHHH;
@property (strong, nonatomic) IBOutlet UIView *donwThree;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downThree_topHHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downThree_HHH;
@property (nonatomic, copy) QGoodsInfor_first_header3Reusa_HTMLBlock QGoodsInfor_first_header3Reusa_HTML;
- (void)wk_web:(NSString *)wk_webHTML;

@property (strong, nonatomic) IBOutlet UIButton *down_oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *down_twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *down_threeBtn;
@property (nonatomic, copy) QGoodsInfor_first_header3Reusa_downOneBtnBlock QGoodsInfor_first_header3Reusa_downOneBtn;
@property (nonatomic, copy) QGoodsInfor_first_header3Reusa_downTwoBtnBlock QGoodsInfor_first_header3Reusa_downTwoBtn;
@property (nonatomic, copy) QGoodsInfor_first_header3Reusa_downThreeBtnBlock QGoodsInfor_first_header3Reusa_downThreeBtn;
@property (nonatomic, copy) QGoodsInfor_first_header3Reusa_showImageBlock QGoodsInfor_first_header3Reusa_showImage;
@property (strong, nonatomic) IBOutlet UIButton *groupGoodsBtn;


@property (weak, nonatomic) IBOutlet UITableView *attr_table;

/*
 *用来获取详情的Y坐标用
 */
@property (weak, nonatomic) IBOutlet UIView *goodIntroduceTitleContainView;


- (void)showAttrModel:(NSArray *)attr_arr andType:(NSString *)type;
@end
