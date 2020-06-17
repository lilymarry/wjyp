//
//  MyGiftVoucherIndex.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^MyGiftVoucherIndexSuccessBlock) (NSString * code, NSString * message ,id data);
typedef void(^MyGiftVoucherIndexFailureBlock) (NSError * error);
typedef void(^MyGiftVoucherIndexChangeSuccessBlock) (NSString * code, NSString * message);


@interface MyGiftVoucherIndex : NSObject
@property (copy,nonatomic) NSString * p;

@property (nonatomic, strong) MyGiftVoucherIndex * data;
@property (nonatomic, strong) MyGiftVoucherIndex * gift;

@property (nonatomic, copy) NSString * gift_num;//": "4",//地址id
@property (nonatomic, copy) NSString * exchange_money;//": "GYM",//收货人
@property (nonatomic, copy) NSString * exchange_voucher;//": "18600001234",//联系电话
@property (nonatomic, copy) NSString * sum_money;//": "天津市南开区华苑鑫茂科技园",//地址
@property (nonatomic, copy) NSArray * giftlist;//": "天津",//省
@property (nonatomic, copy) NSString * id;//": "天津市",//市
@property (nonatomic, copy) NSString * user_id;//": "南开区",//区
@property (nonatomic, copy) NSString * type;//": "得一蜂业旗舰店",//店铺名称
@property (nonatomic, copy) NSString * money;//" :"1"//是否有默认地址 1是0否
@property (nonatomic, copy) NSString * end_time;//":"100" //商品总额

@property (nonatomic, copy) NSString * use_money;
@property (nonatomic, copy) NSString * create_time;//": "13",//商品id
@property (nonatomic, copy) NSString * status;//": "美式球形爆米花 香甜酥脆到爆 看片好伙伴 休闲零食小吃",//商品名称
@property (nonatomic, copy) NSString * source;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b9c3370d7.jpg",//商品封面图
@property (nonatomic, copy) NSString * sb_id;//": "26.60",//价格
//@property (nonatomic, copy) NSString * welfare;//": 5.696,            // 公益金额

@property (nonatomic, copy) NSString * merchant_id;//": 5.696,            // 公益金额
@property (nonatomic, copy) NSString * source_status;//":"1"//组和属性id
@property (nonatomic, copy) NSString * now_money;//": "粉,L",
@property (nonatomic, copy) NSString * x_money;//快递名称
@property (nonatomic, copy) NSString * exchanged;



- (void)MyGiftVoucherIndexSuccess:(MyGiftVoucherIndexSuccessBlock)success andFailure:(MyGiftVoucherIndexFailureBlock)failure;

//赠品券兑换接口
- (void)MyGiftVoucherChangeIndexSuccess:(MyGiftVoucherIndexChangeSuccessBlock)success andFailure:(MyGiftVoucherIndexFailureBlock)failure;




@end
