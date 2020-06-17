//
//  SOfflineStoreOfflineStore.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOfflineStoreOfflineStoreSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SOfflineStoreOfflineStoreFailureBlock) (NSError * error);

@interface SOfflineStoreOfflineStore : NSObject

@property (nonatomic, strong) SOfflineStoreOfflineStore * data;

//线下商铺轮播图
@property (nonatomic, copy) NSArray * banner;
@property (nonatomic, copy) NSString * ads_id;//": "30",/
@property (nonatomic, copy) NSString * picture;//": "http://wjyp.txunda.com/Uploads/Ads/2017-11-14/5a0a9909c5c5e.png",
@property (nonatomic, copy) NSString * desc;//": "内测",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

//线下商铺品牌图
@property (nonatomic, copy) NSArray * brand;
//@property (nonatomic, copy) NSString * ads_id;//": "57",
//@property (nonatomic, copy) NSString * picture;//": "http://wjyp.txunda.com/Uploads/Ads/2017-12-18/5a375c339a700.jpg",
//@property (nonatomic, copy) NSString * desc;//": "水壶",
//@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
//@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
//@property (nonatomic, copy) NSString * href;//": "广告链接"

//线下商铺广告图
@property (nonatomic, copy) NSArray * ads;
//@property (nonatomic, copy) NSString * ads_id;//": "60",
//@property (nonatomic, copy) NSString * picture;//": "http://wjyp.txunda.com/Uploads/Ads/2017-12-18/5a375ce2139b8.jpg",
//@property (nonatomic, copy) NSString * desc;//": "圣诞优惠",
//@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
//@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
//@property (nonatomic, copy) NSString * href;//": "广告链接"


- (void)sOfflineStoreOfflineStoreSuccess:(SOfflineStoreOfflineStoreSuccessBlock)success andFailure:(SOfflineStoreOfflineStoreFailureBlock)failure;

@end
