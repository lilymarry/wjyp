//
//  OsManagerBflistModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/25.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^OsManagerBflistModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^OsManagerBflistModelFailureBlock) (NSError * error);
@interface OsManagerBflistModel : NSObject

@property (nonatomic, copy) NSString * t;

@property (nonatomic, copy) NSString * sta_mid;
@property (nonatomic, strong) OsManagerBflistModel * data;
@property (nonatomic, copy) NSString * change_num;
@property (nonatomic, copy) NSString * msg_num;
@property (nonatomic, strong) NSArray * list;
@property (nonatomic, copy) NSString * name;


@property (nonatomic, copy) NSString * add_time;
@property (nonatomic, copy) NSString * b_cate_id;
@property (nonatomic, copy) NSString * b_name;
@property (nonatomic, copy) NSString * b_vinfo;
@property (nonatomic, copy) NSString * bid;
@property (nonatomic, copy) NSString * id;

@property (nonatomic, strong) OsManagerBflistModel *msg;
@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * u_cate_id;
@property (nonatomic, copy) NSString * u_name;
@property (nonatomic, copy) NSString * u_vinfo;
@property (nonatomic, copy) NSString * uid;

@property (nonatomic, strong) OsManagerBflistModel *user_info;



@property (nonatomic, copy) NSString * activity_status;
@property (nonatomic, copy) NSString * alipay_accounts;
@property (nonatomic, copy) NSString * alliance_merchant;
@property (nonatomic, copy) NSString * area_id;
@property (nonatomic, copy) NSString * auth_status;
@property (nonatomic, copy) NSString * balance;
@property (nonatomic, copy) NSString * blue_voucher;
@property (nonatomic, copy) NSString * cart_num;
@property (nonatomic, copy) NSString * chance_num;
@property (nonatomic, copy) NSString * change_account_status;
@property (nonatomic, copy) NSString * city_id;
@property (nonatomic, copy) NSString * city_status;


@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * comp_auth_status;
@property (nonatomic, copy) NSString * complete_status;
@property (nonatomic, copy) NSString * default_account;
@property (nonatomic, copy) NSString * easemob_account;
@property (nonatomic, copy) NSString * easemob_pwd;
@property (nonatomic, copy) NSString * end_time;
@property (nonatomic, copy) NSString * expired_time;
@property (nonatomic, copy) NSString * gift_num;
@property (nonatomic, copy) NSString * grow_point;
@property (nonatomic, copy) NSString * has_shop;
@property (nonatomic, copy) NSString * head_pic;


//@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * integral;
@property (nonatomic, copy) NSString * invite_code;
@property (nonatomic, copy) NSString * is_agent;
@property (nonatomic, copy) NSString * is_alliance;
@property (nonatomic, copy) NSString * is_copper;
@property (nonatomic, copy) NSString * is_copper_a;
@property (nonatomic, copy) NSString * is_gold;
@property (nonatomic, copy) NSString * is_gold_a;
@property (nonatomic, copy) NSString * is_iron;
@property (nonatomic, copy) NSString * is_iron_a;
@property (nonatomic, copy) NSString * is_masonry;

@property (nonatomic, copy) NSString * is_masonry_a;
@property (nonatomic, copy) NSString * is_member_trainer;
@property (nonatomic, copy) NSString * is_merchant_trainer;
@property (nonatomic, copy) NSString * is_silver;
@property (nonatomic, copy) NSString * is_silver_a;
@property (nonatomic, copy) NSString * is_vip;
@property (nonatomic, copy) NSString * lat;
@property (nonatomic, copy) NSString * level;
@property (nonatomic, copy) NSString * level_icon;
@property (nonatomic, copy) NSString * lng;
@property (nonatomic, strong) NSArray * mInfo;

@property (nonatomic, copy) NSString * a;
//@property (nonatomic, copy) NSString * alipay_accounts;
@property (nonatomic, copy) NSString * b;
//@property (nonatomic, copy) NSString * change_account_status;
//@property (nonatomic, copy) NSString * default_account;
//@property (nonatomic, copy) NSString * invite_code;

@property (nonatomic, copy) NSString * is_delivery;
@property (nonatomic, copy) NSString * is_dine;
@property (nonatomic, copy) NSString * is_display;

//@property (nonatomic, copy) NSString * lat;
//@property (nonatomic, copy) NSString * lng;

@property (nonatomic, copy) NSString * logo;

@property (nonatomic, copy) NSString * merchant_name;
@property (nonatomic, copy) NSString * send_goods_status;
@property (nonatomic, copy) NSString * show_type;
@property (nonatomic, copy) NSString * stage_merchant_id;
@property (nonatomic, copy) NSString * wxpay_accounts;

@property (nonatomic, copy) NSString * member_coding;
//@property (nonatomic, copy) NSString * new_msg;
//@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * phone;

@property (nonatomic, copy) NSString * province_id;
@property (nonatomic, copy) NSString * rank;
@property (nonatomic, copy) NSString * rank_end_time;
@property (nonatomic, copy) NSString * rank_icon;
@property (nonatomic, copy) NSString * regid;
@property (nonatomic, copy) NSString * reward_status;

@property (nonatomic, copy) NSString * server_line;
@property (nonatomic, copy) NSString * service_easemob_account;
@property (nonatomic, copy) NSString * service_easemob_id;

@property (nonatomic, copy) NSString * service_easemob_pwd;
@property (nonatomic, copy) NSString * service_head_pic;

@property (nonatomic, copy) NSString * service_nickname;

@property (nonatomic, copy) NSString * shop_card_status;
@property (nonatomic, copy) NSString * shop_id;
@property (nonatomic, copy) NSString * shop_id_ming;
@property (nonatomic, copy) NSString * shop_level;
//@property (nonatomic, copy) NSString * stage_merchant_id;


@property (nonatomic, copy) NSString * street_id;
@property (nonatomic, copy) NSString * ticket_num;
@property (nonatomic, copy) NSString * token;

@property (nonatomic, copy) NSString * user_card_type;
//@property (nonatomic, copy) NSString * wxpay_accounts;

@property (nonatomic, copy) NSString * wxpay_name;



- (void)OsManagerBflistModelSuccess:(OsManagerBflistModelSuccessBlock)success andFailure:(OsManagerBflistModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
