//
//  SOffLineNearbyStoreListModel.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOffLineNearbyStoreListModelSuccessBlock) (NSString * code, NSString * message, id data,id toplist);
typedef void(^SOffLineNearbyStoreListModelFailureBlock) (NSError * error);

@interface SOffLineNearbyStoreListModel : NSObject
/**
 经度
 */
@property (nonatomic, copy) NSString * lng;//经度
/**
 纬度
 */
@property (nonatomic, copy) NSString * lat;//纬度
/**
 分页
 */
@property (nonatomic, copy) NSString * p;//分页
/**
 店铺id
 */
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”

/**
 店铺ID
 */
@property (nonatomic, copy) NSString * s_id;
/**
 店铺名称
 */
@property (nonatomic, copy) NSString * merchant_name;
/**
 店铺描述
 */
@property (nonatomic, copy) NSString * merchant_desc;
/**
 店铺LOGO url
 */
@property (nonatomic, copy) NSString * logo;
/**
 店铺评分
 */
@property (nonatomic, copy) NSString * score;

/**
 距离
 */
@property (nonatomic, copy) NSString * distance;
/**
 月消单
 */
@property (nonatomic, copy) NSString * months_order;

/**
 可使用的券数组
 */
@property (nonatomic, strong) NSArray * ticket;
/**
 券的类型
 */
@property (nonatomic, copy) NSString * type;//1-红色代金券,2-黄色代金券,3-蓝色代金券
/**
 券的优惠
 */
@property (nonatomic, copy) NSString * discount_desc;
/**
如果user_id==0  隐藏 月消单  跟   红黄蓝券
 */
@property (nonatomic, assign) NSInteger user_id;
/**
 每组显示的row数
 */
@property (nonatomic, assign) NSUInteger RowCount;
/**
 是否显示更过ticket
 */
@property (nonatomic, assign) BOOL isClick;
@property (nonatomic, copy) NSString * proportion;
@property (nonatomic, strong) NSArray * star;

//search 或 普通
@property (nonatomic, assign) BOOL isSearch;



@property (nonatomic, assign) NSInteger show_type;

@property (nonatomic, assign) NSString * goods_num;//goods_num字段值并且大于0的时候，需要跳转至wap下面页面

@property (nonatomic, strong) NSArray * top_list;






/**
 线下商城附近店铺列表
 
 @param success 接口请求成功回调
 @param failure 接口请求失败回调
 */
- (void)sOfflineStoreOfflineStoreListSuccess:(SOffLineNearbyStoreListModelSuccessBlock)success andFailure:(SOffLineNearbyStoreListModelFailureBlock)failure;
@end
