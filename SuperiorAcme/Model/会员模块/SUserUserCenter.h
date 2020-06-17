//
//  SUserUserCenter.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserUserCenterSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserUserCenterFailureBlock) (NSError * error);

@interface SUserUserCenter : NSObject

@property (nonatomic, strong) SUserUserCenter * data;
@property (nonatomic, copy) NSString * nickname;//"昵称",
@property (nonatomic, copy) NSString * head_pic;//"头像",
@property (nonatomic, copy) NSString * easemob_account;//"环信账号",
@property (nonatomic, copy) NSString * easemob_pwd;//"环信密码",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * balance;//"余额",
@property (nonatomic, copy) NSString * ticket_num;//"购物券",
@property (nonatomic, copy) NSString * invite_code;//"邀请码",
@property (nonatomic, copy) NSString * token;//"token",
@property (nonatomic, copy) NSString * expired_time;//"token过期时间",
@property (nonatomic, copy) NSString * rank_id;// "1",
@property (nonatomic, copy) NSString * grow_point;//"成长值",
@property (nonatomic, copy) NSString * rank;//"普通会员",//缴费会员等级
@property (nonatomic, copy) NSString * rank_icon;//"会员图标",
@property (nonatomic, copy) NSString * level;//"普通用户",//普通用户等级
@property (nonatomic, copy) NSString * level_icon;//"会员图标",
@property (nonatomic, copy) NSString * point_date;//"无界指数日期",
@property (nonatomic, copy) NSString * point_num;//"无界指数",
@property (nonatomic, copy) NSString * server_line;//客服电话",
@property (nonatomic, copy) NSString * thisNew_msg;//未读消息数
@property (nonatomic, copy) NSString * auth_status;//"0", //认证状态 0 未认证 1认证中 2 已认证
@property (nonatomic, copy) NSString * cart_num;//":"2"//购物车数量
@property (nonatomic, copy) NSString * complete_status; //1 时赠送蓝色代金券 0时诚聘无界推广员

@property (nonatomic, copy) NSString * is_gold_a;//": "0"//金，0不点亮 1点亮,
@property (nonatomic, copy) NSString * is_silver_a;//": "0",//银，0不点亮 1点亮,
@property (nonatomic, copy) NSString * is_copper_a;//": "0",//铜，0不点亮 1点亮,
@property (nonatomic, copy) NSString * is_masonry_a;//": "0",//钢，0不点亮 1点亮,
@property (nonatomic, copy) NSString * is_iron_a;//": "0",//铁，0不点亮 1点亮,
@property (nonatomic, copy) NSString * service_easemob_account;//": "150632770313193",//环信客服账号
@property (nonatomic, copy) NSString * service_nickname;//";: "干将莫邪",//环信客服昵称
@property (nonatomic, copy) NSString * service_head_pic;//": "http://wjyp.txunda.com/Uploads/User/2017-09-25/59c8bd7707a89.jpg",//环信客服头像
@property (nonatomic, copy) NSString * is_agent;//":"0",    //是否显示    代理加盟  0 不显示  1 显示
@property (nonatomic, copy) NSString * is_alliance;//":"0"    //是否显示  联盟商家管理   0 不显示  1 显示
@property (nonatomic, copy) NSString * user_card_type;//":"1无界会员 2无忧会员 3优享会员 4其他会员
@property (nonatomic, copy) NSString * shop_card_status;//"://会员卡模块是否开启 0不开启  1开启
@property (nonatomic, copy) NSString * activity_status;//首页活动是否开启
@property (nonatomic, copy) NSString * city_status;//": 0              // 是否填写个人资料所在地（0->否，1->是）
@property (nonatomic, copy) NSString * blue_voucher;//蓝色代金券余额
@property (nonatomic, assign) BOOL reward_status;  //"是否存在延时会员卡功能" 1 存在  0不存在



/*
 *添加拜师码相关的属性
 */
@property (nonatomic, copy) NSString * is_member_trainer;
@property (nonatomic, copy) NSString * is_merchant_trainer;
@property (nonatomic, copy) NSString * code;

// 三方绑定涉及的属性
/// "1",//是否支持账户切换 1支持 2不支持   只有当该值为1 和alliance_merchant是有值的时候 才能在个人中心显示“三方收款账户绑定”
@property (nonatomic, copy) NSString * change_account_status;
/// "1"//是否是联盟商家  0不是 1联盟商家 2 无界驿店
@property (nonatomic, copy) NSString * alliance_merchant;
/// 商家ID
@property (nonatomic, copy) NSString * stage_merchant_id;


@property (nonatomic, copy) NSArray * mInfo;//"店铺"
@property (nonatomic, copy) NSString * has_shop;//是否有小店 “1” or “0”
@property (nonatomic, copy) NSString * shop_id_ming;
@property (nonatomic, copy) NSString * shop_id;
@property (nonatomic, copy) NSString * gift_num;
@property (nonatomic, copy) NSString * uct_status;//店主身份

@property (nonatomic, copy) NSString * chance_num;//银两

 @property (nonatomic, copy) NSString * clean_status;
- (void)sUserUserCenterSuccess:(SUserUserCenterSuccessBlock)success andFailure:(SUserUserCenterFailureBlock)failure;
@end
