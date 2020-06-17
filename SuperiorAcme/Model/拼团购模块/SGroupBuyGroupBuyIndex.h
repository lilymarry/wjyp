//
//  SGroupBuyGroupBuyIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyGroupBuyIndexSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SGroupBuyGroupBuyIndexFailureBlock) (NSError * error);

@interface SGroupBuyGroupBuyIndex : NSObject
@property (nonatomic, copy) NSString * cate_id;//固定值 1 当next为1时获取的是拍卖预展
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SGroupBuyGroupBuyIndex * data;

@property (nonatomic, copy) NSArray * top_nav;
//@property (nonatomic, copy) NSString * cate_id;//分类ID,
@property (nonatomic, copy) NSString * short_name;//"分类简称",
@property (nonatomic, copy) NSString * name;// "分类名称"

@property (nonatomic, copy) NSArray * two_cate_list;
@property (nonatomic, copy) NSString * two_cate_id;//"二级分类id",
//@property (nonatomic, copy) NSString * short_name;//": "分类简称",
//@property (nonatomic, copy) NSString * name;//": "分类名称"
@property (nonatomic, copy) NSString * cate_img;//": "二级分类图标"

@property (nonatomic, strong) SGroupBuyGroupBuyIndex * ads;
@property (nonatomic, copy) NSString * ads_id;//"广告id",
@property (nonatomic, copy) NSString * picture;//"广告图片",
@property (nonatomic, copy) NSString * desc;//"图片描述",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * group_buy_list;
@property (nonatomic, copy) NSString * group_buy_id;//"团购ID",
@property (nonatomic, copy) NSString * group_price;//"团购价",
@property (nonatomic, copy) NSString * shop_price;
@property (nonatomic, copy) NSString * group_num;//"团购所需人数",
@property (nonatomic, copy) NSString * total;//"本活动总参团人",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片g",
@property (nonatomic, copy) NSString * country_id;//"国家ID",
@property (nonatomic, copy) NSString * ticket_buy_id;//"抵扣券id",
@property (nonatomic, copy) NSString * country_logo;//"国家图片",
@property (nonatomic, copy) NSString * ticket_buy_discount;// "折扣率"
//两个参团人头像
@property (nonatomic, copy) NSArray * append_person;
@property (nonatomic, copy) NSString * log_id;//"团编号",
@property (nonatomic, copy) NSString * user_id;//"开团者id",
@property (nonatomic, copy) NSString * head_pic;//"开团者头像"

/*
 *添加体验拼单商品提示
 */
@property (nonatomic, copy) NSString * group_type;//"类型 1试用品拼单 2常规拼单",

/*
 体验拼单规则
 */
@property (nonatomic, strong) NSArray *group_buy_rule;

/*
" 拼单规则显示状态" ,// 0:不显示；1：显示
 */
@property (nonatomic, copy) NSString *is_show_group_buy_rule;

/*
 *拼单购通知消息数据
 */
@property (nonatomic, copy) NSArray * group_buy_msg;
@property (nonatomic, copy) NSString * msg;

@property (nonatomic, copy) NSString * a_id;



- (void)sGroupBuyGroupBuyIndexSuccess:(SGroupBuyGroupBuyIndexSuccessBlock)success andFailure:(SGroupBuyGroupBuyIndexFailureBlock)failure;


//体验拼单规则
/*
 status  0:不显示规则弹窗；1：显示规则弹窗  默认0  这里不填
 */
+ (void)sGroupBuyRuleSuccess:(SGroupBuyGroupBuyIndexSuccessBlock)success andFailure:(SGroupBuyGroupBuyIndexFailureBlock)failure;

@end
