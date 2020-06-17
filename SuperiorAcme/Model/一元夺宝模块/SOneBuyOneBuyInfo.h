//
//  SOneBuyOneBuyInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOneBuyOneBuyInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SOneBuyOneBuyInfoFailureBlock) (NSError * error);

@interface SOneBuyOneBuyInfo : NSObject
@property (nonatomic, copy) NSString * one_buy_id;//一元购id

@property (nonatomic, strong) SOneBuyOneBuyInfo * data;
@property (nonatomic, copy) NSString * goods_desc;//"图文详情",
@property (nonatomic, copy) NSString * rules;//"规则说明"

@property (nonatomic, strong) SOneBuyOneBuyInfo * oneBuyInfo;
@property (nonatomic, copy) NSString * balance_num;//": "6.00",           // 金额
@property (nonatomic, copy) NSString * pic;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b882f1e70.jpg",   //图片
@property (nonatomic, copy) NSString * person_num;//"需参与人数",
@property (nonatomic, copy) NSString * add_num;//"0",//参与了多少人
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * start_time;//"开始时间",
@property (nonatomic, copy) NSString * merchant_id;//商家id
@property (nonatomic, copy) NSString * goods_id;//"商品id",
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * end_time;//"结束时间",
@property (nonatomic, copy) NSString * time_num;//"期号"
@property (nonatomic, copy) NSString * t_status;//"已结束"//状态
@property (nonatomic, copy) NSString * goods_name;//"商品名称"

//商品相册
@property (nonatomic, copy) NSArray * goodsGallery;
@property (nonatomic, copy) NSString * path;//"图片地址"

//一元购记录
@property (nonatomic, copy) NSArray * oneBuyLog;
@property (nonatomic, copy) NSString * log_id;//"记录id",
@property (nonatomic, copy) NSString * bid_time;//"出价时间",
@property (nonatomic, copy) NSString * nickname;//"昵称",
@property (nonatomic, copy) NSString * phone;//"电话",
//@property (nonatomic, copy) NSString * time_num;//"期号",
@property (nonatomic, copy) NSString * bid_user_id;//"出价人id",
@property (nonatomic, copy) NSString * count;//"参与次数"

//往期记录
@property (nonatomic, copy) NSArray * outTime_log;
//@property (nonatomic, copy) NSString * one_buy_id;//"一元购id",
//@property (nonatomic, copy) NSString * add_num;//"0",
@property (nonatomic, copy) NSString * winer_code;//"幸运号码",
//@property (nonatomic, copy) NSString * time_num;//"期号",
@property (nonatomic, copy) NSString * end_true_time;//"揭晓时间",
//@property (nonatomic, copy) NSString * count;// "参与人次"
@property (nonatomic, copy) NSString * head_pic;//"头像",
//@property (nonatomic, copy) NSString * nickname;//"昵称",


- (void)sOneBuyOneBuyInfoSuccess:(SOneBuyOneBuyInfoSuccessBlock)success andFailure:(SOneBuyOneBuyInfoFailureBlock)failure;
@end
