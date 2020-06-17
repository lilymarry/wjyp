//
//  SUserUserInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserUserInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserUserInfoFailureBlock) (NSError * error);

@interface SUserUserInfo : NSObject

//需要传入用户token

@property (nonatomic, strong) SUserUserInfo * data;
@property (nonatomic, copy) NSString * user_id;//"会员id",
@property (nonatomic, copy) NSString * nickname;//"会员昵称",
@property (nonatomic, copy) NSString * real_name;//"真实姓名",
@property (nonatomic, copy) NSString * head_pic;//"头像",
@property (nonatomic, copy) NSString * id_card_num;//"身份证号",
@property (nonatomic, copy) NSString * sex;//"性别", //2 女  1男
@property (nonatomic, copy) NSString * email;//"邮箱",
@property (nonatomic, copy) NSString * province_id;//"省id",
@property (nonatomic, copy) NSString * city_id;//"市id",
@property (nonatomic, copy) NSString * area_id;//"区县id",
@property (nonatomic, copy) NSString * street_id;//"街道id",
@property (nonatomic, copy) NSString * province_name;//"省名称",
@property (nonatomic, copy) NSString * city_name;//"市名称",
@property (nonatomic, copy) NSString * area_name;//"区县名称",
@property (nonatomic, copy) NSString * street_name;//"街道名称",
@property (nonatomic, copy) NSString * parent_id;//"推荐人id",
@property (nonatomic, copy) NSString * parent_name;//"推荐人昵称",
@property (nonatomic, copy) NSString * parent_phone;//"推荐人手机"，
@property (nonatomic, copy) NSString * parent_alliance_merchant_name;//": "所属联盟商家名称",
@property (nonatomic, copy) NSString * parent_alliance_merchant_sn;//": "所属联盟商家编号",
@property (nonatomic, copy) NSString * hidden_parent_name;//": "隐藏推荐人姓名",
@property (nonatomic, copy) NSString * hidden_parent_phone;//": "隐藏推荐人手机号"
@property (nonatomic, copy) NSString * auth_status;//": "0", //个人认证状态 0 未认证 1认证中 2 已认证 3被拒绝 ",
@property (nonatomic, copy) NSString * comp_auth_status;//": "0", //企业认证状态 0 未认证 1认证中 2 已认证 3被拒绝 "
@property (nonatomic, copy) NSString * personal_data_status;//":"0未完善 1已完善"
@property (nonatomic, copy) NSString * auth_name;//":"个人认证通过的名字"
@property (nonatomic, copy) NSString * comp_auth_name;//":"企业认证通过的企业名字"

@property (nonatomic, copy) NSArray * mInfo;//"店铺"

@property (nonatomic, copy) NSString * a;
@property (nonatomic, copy) NSString * alipay_accounts;
@property (nonatomic, copy) NSString * b;
@property (nonatomic, copy) NSString * change_account_status;
@property (nonatomic, copy) NSString * default_account;
@property (nonatomic, copy) NSString * jeanne_cate;
@property (nonatomic, copy) NSString * logo;
@property (nonatomic, copy) NSString * merchant_name;
@property (nonatomic, copy) NSString * show_type;
@property (nonatomic, copy) NSString * stage_merchant_id;
@property (nonatomic, copy) NSString * wxpay_accounts;

@property (nonatomic, copy) NSString * alliance_merchant;
@property (nonatomic, copy) NSString * member_coding;
@property (nonatomic, copy) NSString * uct_status;

- (void)sUserUserInfoSuccess:(SUserUserInfoSuccessBlock)success andFailure:(SUserUserInfoFailureBlock)failure;
@end
