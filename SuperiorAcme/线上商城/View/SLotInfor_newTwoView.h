//
//  SLotInfor_newTwoView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/16.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<WebKit/WebKit.h>
typedef void(^QGoodsInfor_first_header3Reusa_HTMLBlock) (NSInteger num);
typedef void(^QGoodsInfor_first_header3Reusa_downOneBtnBlock) ();
typedef void(^QGoodsInfor_first_header3Reusa_downTwoBtnBlock) ();
typedef void(^QGoodsInfor_first_header3Reusa_downThreeBtnBlock) ();

@interface SLotInfor_newTwoView : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIImageView *country_logo;
@property (strong, nonatomic) IBOutlet UILabel *country_desc;
@property (strong, nonatomic) IBOutlet UILabel *pushPrice;
@property (strong, nonatomic) IBOutlet UIImageView *goods_server_oneImage;
@property (strong, nonatomic) IBOutlet UILabel *goods_server_oneTitle;
@property (strong, nonatomic) IBOutlet UIImageView *goods_server_twoImage;
@property (strong, nonatomic) IBOutlet UILabel *goods_server_twoTitle;

@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIView *evaImageView;
@property (strong, nonatomic) IBOutlet UICollectionView *evaCollect;

@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UILabel *num1;
@property (strong, nonatomic) IBOutlet UILabel *num2;
@property (strong, nonatomic) IBOutlet UILabel *num3;

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

- (void)showModel:(NSArray *)arr;


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
@property (nonatomic, copy) QGoodsInfor_first_header3Reusa_HTMLBlock QGoodsInfor_first_header3Reusa_HTML;
- (void)wk_web:(NSString *)wk_webHTML;

@property (strong, nonatomic) IBOutlet UIView *downOne;
@property (weak, nonatomic) IBOutlet UIButton *evaBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downOne_HHH;
@property (strong, nonatomic) IBOutlet UIView *downTwo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downTwo_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downTwo_topHHH;
@property (strong, nonatomic) IBOutlet UIView *donwThree;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downThree_topHHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downThree_HHH;

@property (strong, nonatomic) IBOutlet UIButton *down_oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *down_twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *down_threeBtn;
@property (nonatomic, copy) QGoodsInfor_first_header3Reusa_downOneBtnBlock QGoodsInfor_first_header3Reusa_downOneBtn;
@property (nonatomic, copy) QGoodsInfor_first_header3Reusa_downTwoBtnBlock QGoodsInfor_first_header3Reusa_downTwoBtn;
@property (nonatomic, copy) QGoodsInfor_first_header3Reusa_downThreeBtnBlock QGoodsInfor_first_header3Reusa_downThreeBtn;
@property (strong, nonatomic) IBOutlet UIButton *priceInterBtn;
@property (strong, nonatomic) IBOutlet UIButton *sendBtnClick;
@property (strong, nonatomic) IBOutlet UILabel *send_Content;
@end
