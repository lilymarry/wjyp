//
//  SAAPIHelper.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/1.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBShopDetailModel.h"
#import "UBTypeEntryModel.h"
#import "SOfflineStoreOfflineStore.h"
#import "SGoodsGoodsList.h"
#import "SOrderCompleteModel.h"

typedef void(^NetworkCompletionHandler)(BOOL isSuccess,NSString*message,id result);

@interface SAAPIHelper : NSObject

#pragma mark - underLineSearch
-(void)refreshUnderLineSearchWithKeyWord:(NSString *)keyword
                              completion:(NetworkCompletionHandler)completion;

- (void)loadMoreUnderLineSearchWithKeyWord:(NSString *)keyword
                                completion:(NetworkCompletionHandler)completion;


#pragma mark -  **************** 评论 *****************
//评论商家页面参数获取
-(void)offlineStoreCommonWithOrder_id:(NSString *)order_id
                           completion:(NetworkCompletionHandler)completion;

//评论商家
-(void)offlineStoreCommentWithOrder_id:(NSString *)order_id
                               content:(NSString *)content //评论内容
                               picture:(NSDictionary *)picture //评论图片
                           environment:(NSInteger)environment //环境星级
                                 serve:(NSInteger)serve //服务星级
                            completion:(NetworkCompletionHandler)completion;

//线下全部评论
#pragma mark - 线下全部评论
- (void)refreshOfflineStoreCommentListWithMerchant_id:(NSString *)merchant_id
                                           completion:(NetworkCompletionHandler)completion;
- (void)loadMoreOfflineStoreCommentListWithMerchant_id:(NSString *)merchant_id
                                            completion:(NetworkCompletionHandler)completion;


#pragma mark -  **************** 线下  *****************
//获取分类图标
+(void)recommending_businessType_completion:(NetworkCompletionHandler)completion;

//二级分类页面广告
+(void)offlineStore_stageAdsWithTop_cate:(NSString *)top_cate
                              completion:(NetworkCompletionHandler)completion;

//附近商家列表
/*
 *(merchant_id 如果是店铺详情页面需要传 防止店铺详情页面的附近商家有当前点击的店铺)
   top_cate  点击一级分类时用到
   little_cate  点击二级分类时用到
   列表页面p递增 详情页面没有下拉刷新 只是p=1
 */
-(void)refreshOfflineStore_offlineStoreList_lng:(NSString *)lng
                                     lat:(NSString *)lat
                             merchant_id:(NSString *)merchant_id
                                top_cate:(NSString *)top_cate
                             little_cate:(NSString *)little_cate
                              completion:(NetworkCompletionHandler)completion;

-(void)loadMoreOfflineStore_offlineStoreList_lng:(NSString *)lng
                                             lat:(NSString *)lat
                                     merchant_id:(NSString *)merchant_id
                                        top_cate:(NSString *)top_cate
                                     little_cate:(NSString *)little_cate
                                      completion:(NetworkCompletionHandler)completion;

//线下支付成功后查看页
+(void)offlineStore_orderSuccess_order_id:(NSString *)order_id
                                  completion:(NetworkCompletionHandler)completion;


#pragma mark -  **************** 2980商品  *****************
-(void)refrshGoods_twoNineEightZero_completion:(NetworkCompletionHandler)completion;

-(void)loadMoreGoods_twoNineEightZero_completion:(NetworkCompletionHandler)completion;



@end
