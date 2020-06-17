//
//  SCarBuyCarInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarBuyCarInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCarBuyCarInfoFailureBlock) (NSError * error);

@interface SCarBuyCarInfo : NSObject
@property (nonatomic, copy) NSString * car_id;//汽车id

@property (nonatomic, strong) SCarBuyCarInfo * data;
@property (nonatomic, copy) NSString * cart_num;//": "4",//购物车数量
@property (nonatomic, copy) NSString * msg_tip;//": "1",//消息提醒数
@property (nonatomic, copy) NSString * is_collect;//": "0",//是否收藏
@property (nonatomic, copy) NSString * share_url;//": "http://wjyp.txunda.com",//分享链接
@property (nonatomic, copy) NSString * share_img;//": "分享图片",
@property (nonatomic, copy) NSString * share_content;//": "分享内容"
@property (nonatomic, copy) NSString * easemob_account;//:客服环信账号
@property (nonatomic, copy) NSString * server_head_pic;//:客服头像
@property (nonatomic, copy) NSString * server_name;//：客服名称
@property (nonatomic, copy) NSString * comment_num;//"4",//总评价数

@property (nonatomic, strong) SCarBuyCarInfo * car_info;
//@property (nonatomic, copy) NSString * car_id;//": "汽车id",
@property (nonatomic, copy) NSString * car_name;//": "汽车名称",
@property (nonatomic, copy) NSString * car_img;//": "汽车购轮播图",
@property (nonatomic, copy) NSString * lng;//": "经度",
@property (nonatomic, copy) NSString * lat;//": "纬度",
@property (nonatomic, copy) NSString * pre_money;//": "代金券",
@property (nonatomic, copy) NSString * true_pre_money;//": "可抵金额",
@property (nonatomic, copy) NSString * all_price;//": "全价",
@property (nonatomic, copy) NSString * integral;//": "积分",
@property (nonatomic, copy) NSString * ticket_discount;//": "购物券比例",
@property (nonatomic, copy) NSString * pictures;//": "7846,7847,7848",
@property (nonatomic, copy) NSString * car_desc;//": "车描述",
@property (nonatomic, copy) NSString * content;//":'详情'
@property (nonatomic, copy) NSArray * banner;
@property (nonatomic, copy) NSString * path;//"http://wjyp.txunda.com/Uploads/CarBuy/2017-09-05/59ae00ceae98d.jpg"

//新评价
@property (nonatomic, copy) NSArray * comment_new;
//@property (nonatomic, copy) NSString * content;//": "跟他们一起去玩啊",//评价内容
@property (nonatomic, copy) NSString * create_time;//": "2017-12-01",//时间
@property (nonatomic, copy) NSString * comment_star;//": "4.75",//星级
@property (nonatomic, copy) NSString * nickname;//": "GYM",//评价人你昵称
@property (nonatomic, copy) NSString * head_pic;//": "http://wjyp.txunda.com/Uploads/User/2017-12-01/5a210bfc32b2e.png"//评价人头像
//评价图片数组
@property (nonatomic, copy) NSArray * pictures_arr;
//@property (nonatomic, copy) NSString * path;//": "http://wjyp.txunda.com/Uploads/CarOrder/2017-12-01/5a20f61b14490.png"//图片
//评价标签数组
@property (nonatomic, copy) NSArray * label_arr;
@property (nonatomic, copy) NSString * label;//": "外观漂亮"//标签


//产品规格
@property (nonatomic, copy) NSArray * attr;
@property (nonatomic, copy) NSString * id;//": "1",
@property (nonatomic, copy) NSString * attr_name;//": "箱规",
@property (nonatomic, copy) NSString * attr_val;//": "单瓶"

- (void)sCarBuyCarInfoSuccess:(SCarBuyCarInfoSuccessBlock)success andFailure:(SCarBuyCarInfoFailureBlock)failure;
@end
