//
//  SShopCar_editView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SShopCar_editView_backBlock) ();
typedef void(^SShopCar_editView_submitBlock) ();
typedef void(^SShopCar_editView_carEditBlock) (NSString * num, NSString * product_id, NSString * product_id_name, NSString * goods_num);
typedef void(^SShopCar_editView_addBuyBlock) (NSString * num, NSString * now_product_id);

/*
 *拼单购,点击一键参团后的回调
 */
typedef void(^SShopCar_editView_OneKeyGroupAddBuyBlock) (NSString * num, NSString * now_product_id, NSString * now_group_buy_id);

//拼单购金额显示
typedef void(^SShopCar_editView_showPriceBlock) ();
//商品详情变成这样
typedef void(^SShopCar_editView_nowBlock) (NSString * shop_price, NSString * market_price, NSString * red_return_integral, NSString * wy_price, NSString * yx_price, NSString * goods_num, NSString * choiceContent, NSString * num, NSString * now_product_id, NSArray * model_dj_ticket, NSString * integral, NSString *model_group_buy_id, NSString * p_shop_price, NSString *model_p_integral, NSString * model_integral_buy_id, NSString * model_use_integral,NSString * model_gift_goods_id, NSString * model_use_voucher);

@interface SShopCar_editView : UIView <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scr_HHH;
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIView *goodsImageView;
@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UILabel *thisPrice;
@property (weak, nonatomic) IBOutlet UILabel *thisPrice_Title;
@property (strong, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UILabel *all_num;
@property (weak, nonatomic) IBOutlet UILabel *cart_number_label;
@property (weak, nonatomic) IBOutlet UIButton *cart_add_button;
@property (weak, nonatomic) IBOutlet UITextField *cart_buyNumber_label;
@property (weak, nonatomic) IBOutlet UIButton *cart_minus_button;
@property (weak, nonatomic) IBOutlet UILabel *cart_repertoryNum_label;
@property (weak, nonatomic) IBOutlet UILabel *maxNum;

@property (nonatomic, copy) SShopCar_editView_backBlock SShopCar_editView_back;
@property (nonatomic, copy) SShopCar_editView_submitBlock SShopCar_editView_submit;
@property (nonatomic, copy) SShopCar_editView_carEditBlock SShopCar_editView_carEdit;
@property (nonatomic, copy) SShopCar_editView_addBuyBlock SShopCar_editView_addBuy;

/*
 *拼单购,点击一键参团后的回调
 */
@property (nonatomic, copy) SShopCar_editView_OneKeyGroupAddBuyBlock SShopCar_editView_OneKeyGroupAddBuy;

- (void)showModel;
@property (nonatomic, copy) NSString * goods_id;//商品id
@property (nonatomic, copy) NSString * product_id;//    商品属性id （特殊商品时需传）
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
- (void)addBuy:(NSString *)addBuy_isno;
@property (nonatomic, copy) SShopCar_editView_showPriceBlock SShopCar_editView_showPrice;

- (void)goodsInfor_now:(NSString *)gym;
@property (nonatomic, copy) SShopCar_editView_nowBlock SShopCar_editView_now;

@property (nonatomic, copy) NSString *buy_goods_type;//商品类型
@property (nonatomic, copy) NSString *group_buy_type_status;// 拼单购状态下 如果是体验商品 传1 否则传2
@property (nonatomic, assign) BOOL isOneKeyGroup;

/*
 *是否是一键参团页面弹出
 */
@property (nonatomic, assign) BOOL is_active;

@end
