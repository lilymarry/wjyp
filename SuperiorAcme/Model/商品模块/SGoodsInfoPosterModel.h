//
//  SGoodsInfoPosterModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/31.
//  Copyright © 2018年 GYM. All rights reserved.
//


//
//  SGoodsGoodsInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGoodsInfoPosterModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGoodsInfoPosterModelFailureBlock) (NSError * error);



@interface SGoodsInfoPosterModel : NSObject
@property (nonatomic, copy) NSString * type;//1、普通商品(进口管、主题街) 2、拼单购 3、积分商城 4、分销（普通商品） 5、分销（399商品）
@property (nonatomic, copy) NSString * id;//普通商品是goods_id，当是拼单购(group_buy_id)、积分商城(integral_buy_id)、分销(gid或者id)

@property (nonatomic, copy) NSString * goods_img;//组合海报商品图片 http开头的图片地址

@property (nonatomic, copy) NSString * goods_name;//商品名称
@property (nonatomic, copy) NSString * integral;//所返最多积分
@property (nonatomic, copy) NSString * discount;//最大用券比例
@property (nonatomic, copy) NSString * shop_price;//售价
@property (nonatomic, copy) NSString * market_price;//市场价
@property (nonatomic, copy) NSString * shop_id;//分销的shop_id
@property (nonatomic, copy) SGoodsInfoPosterModel * data;
@property (nonatomic, copy) NSString * img;//分销的shop_id
@property (nonatomic, copy) NSString * invite_code;
@property (nonatomic, copy) NSString * is_active_5;

- (void)sGoodsGoodsInfoSuccess:(SGoodsInfoPosterModelSuccessBlock)success andFailure:(SGoodsInfoPosterModelFailureBlock)failure;
@end


