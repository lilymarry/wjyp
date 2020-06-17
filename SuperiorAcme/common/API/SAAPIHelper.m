//
//  SAAPIHelper.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/1.
//  Copyright © 2018年 GYM. All rights reserved.
//

#define kOfflineStore_search @"OfflineStore/search"
#define kOfflineStore_common @"OfflineStore/common" //评论页面参数获取
#define kOfflineStore_commentList @"OfflineStore/commentList"

#define SuccessState(X) [X[@"code"] isEqualToString:@"1"]
#define kMessage(X) X[@"message"]

#import "SAAPIHelper.h"
#import "SOffLineNearbyStoreListModel.h"


@interface SAAPIHelper()

@property (nonatomic, assign) NSUInteger underSearchPage;
@property (nonatomic, assign) NSUInteger offlineStore_commentList_page;
@property (nonatomic, assign) NSUInteger offlineStore_typeEntry_page;
@property (nonatomic, assign) NSUInteger goods_twoNineEightZero_page;


@end

@implementation SAAPIHelper

#pragma mark - underLineSearch
-(void)refreshUnderLineSearchWithKeyWord:(NSString *)keyword
                              completion:(NetworkCompletionHandler)completion{
    self.underSearchPage = 1;
    [self feachDataWithKeyWord:keyword
                          page:self.underSearchPage
                    completion:completion];
}

- (void)loadMoreUnderLineSearchWithKeyWord:(NSString *)keyword
                                completion:(NetworkCompletionHandler)completion{
    self.underSearchPage += 1;
    [self feachDataWithKeyWord:keyword
                          page:self.underSearchPage
                    completion:completion];
}

#pragma mark - 线下全部评论
- (void)refreshOfflineStoreCommentListWithMerchant_id:(NSString *)merchant_id
                                           completion:(NetworkCompletionHandler)completion{
    self.offlineStore_commentList_page = 1;
    [self offlineStoreCommentListWithMerchant_id:merchant_id
                                            page:self.offlineStore_commentList_page
                                      completion:completion];
}

- (void)loadMoreOfflineStoreCommentListWithMerchant_id:(NSString *)merchant_id
                                           completion:(NetworkCompletionHandler)completion{
    self.offlineStore_commentList_page += 1;
    [self offlineStoreCommentListWithMerchant_id:merchant_id
                                            page:self.offlineStore_commentList_page
                                      completion:completion];
}


#pragma mark -  **************** 评论 *****************

-(void)offlineStoreCommonWithOrder_id:(NSString *)order_id
                           completion:(NetworkCompletionHandler)completion{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:order_id forKey:@"order_id"];
    [HttpManager postWithUrl:kOfflineStore_common
               andParameters:para
                  andSuccess:^(id Json) {
                      if (SWNOTEmptyDictionary(Json)) {
                          if (SuccessState(Json)) {
                              NSDictionary *data = Json[@"data"];
                              if (SWNOTEmptyDictionary(data)) {
                                  completion(YES,kMessage(Json),[UBShopDetailModel mj_objectWithKeyValues:data]);
                              }else{
                                  completion(NO,kMessage(Json),nil);
                              }
                          }else{
                              completion(NO,kMessage(Json),nil);
                          }
                      }else{
                          !completion?:completion(NO,@"数据格式不正确",nil);
                      }
                  }
                     andFail:^(NSError *error) {
                       !completion?:completion(NO,[error localizedDescription],nil);
                     }];
}

-(void)offlineStoreCommentWithOrder_id:(NSString *)order_id
                               content:(NSString *)content //评论内容
                               picture:(NSDictionary *)picture //评论图片
                           environment:(NSInteger )environment //环境星级
                                 serve:(NSInteger )serve //服务星级
                            completion:(NetworkCompletionHandler)completion
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:order_id forKey:@"order_id"];
    [para setValue:content forKey:@"content"];
    [para setValue:@(environment) forKey:@"environment"];
    [para setValue:@(serve) forKey:@"serve"];
    [HttpManager postUploadMultipleImagesWithUrl:@"OfflineStore/comment"
                               andImagesAndNames:picture
                                   andParameters:para
                                      andSuccess:^(id Json) {
                                          if (SWNOTEmptyDictionary(Json)) {
                                              if (SuccessState(Json)) {
                                                completion(YES,kMessage(Json),nil);
                                              }else{
                                                completion(NO,kMessage(Json),nil);
                                              }
                                          }else{
                                              !completion?:completion(NO,@"数据格式不正确",nil);
                                          }
                                      }
                                         andFail:^(NSError *error) {
                                          !completion?:completion(NO,@"数据格式不正确",nil);
                                         }];
}


#pragma mark -  **************** 线下  *****************
//获取分类图标
+(void)recommending_businessType_completion:(NetworkCompletionHandler)completion{
    [HttpManager postWithUrl:@"Recommending/businessType"
               andParameters:@{}
                  andSuccess:^(id Json) {
                      if (SWNOTEmptyDictionary(Json)){
                          NSArray *data = Json[@"data"];
                          if (SWNOTEmptyArr(data)) {
                              completion(YES,kMessage(Json),[UBTypeModel mj_objectArrayWithKeyValuesArray:data]);
                          }else{
                              completion(NO,kMessage(Json),nil);
                          }
                      }else{
                          !completion?:completion(NO,@"数据格式不正确",nil);
                      }
                  }
                     andFail:^(NSError *error) {
                       !completion?:completion(NO,error.localizedDescription,nil);
                     }];
}

//二级分类页面广告
+(void)offlineStore_stageAdsWithTop_cate:(NSString *)top_cate
                              completion:(NetworkCompletionHandler)completion{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:top_cate forKey:@"top_cate"];
    [HttpManager postWithUrl:@"OfflineStore/stageAds"
               andParameters:para
                  andSuccess:^(id Json) {
                      if (SWNOTEmptyDictionary(Json)){
                          if (SuccessState(Json)) {
                              NSArray *data = Json[@"data"];
                              if (SWNOTEmptyArr(data)) {
                                  completion(YES,kMessage(Json),[SOfflineStoreOfflineStore mj_objectArrayWithKeyValuesArray:data]);
                              }else{
                                  completion(NO,kMessage(Json),nil);
                              }
                          }else{
                              completion(NO,kMessage(Json),nil);
                          }
                      }else{
                          !completion?:completion(NO,@"数据格式不正确",nil);
                      }
                  }
                     andFail:^(NSError *error) {
                         !completion?:completion(NO,error.localizedDescription,nil);
                     }];
}

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
                                     completion:(NetworkCompletionHandler)completion{
    _offlineStore_typeEntry_page = 1;
    [SAAPIHelper offlineStore_offlineStoreList_lng:lng
                                               lat:lat
                                                 p:_offlineStore_typeEntry_page
                                       merchant_id:merchant_id
                                          top_cate:top_cate
                                       little_cate:little_cate
                                        completion:completion];
}

-(void)loadMoreOfflineStore_offlineStoreList_lng:(NSString *)lng
                                             lat:(NSString *)lat
                                     merchant_id:(NSString *)merchant_id
                                        top_cate:(NSString *)top_cate
                                     little_cate:(NSString *)little_cate
                                      completion:(NetworkCompletionHandler)completion{
    _offlineStore_typeEntry_page += 1;
    [SAAPIHelper offlineStore_offlineStoreList_lng:lng
                                               lat:lat
                                                 p:_offlineStore_typeEntry_page
                                       merchant_id:merchant_id
                                          top_cate:top_cate
                                       little_cate:little_cate
                                        completion:completion];
}

//线下支付成功后查看页
+(void)offlineStore_orderSuccess_order_id:(NSString *)order_id
                                  completion:(NetworkCompletionHandler)completion{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:order_id forKey:@"order_id"];
    [HttpManager postWithUrl:@"OfflineStore/orderSuccess"
               andParameters:para
                  andSuccess:^(id Json) {
                      if (SWNOTEmptyDictionary(Json)) {
                          if (SuccessState(Json)) {
                              completion(YES,kMessage(Json),[SOrderCompleteModel mj_objectWithKeyValues:Json[@"data"]]);
                          }else{
                              completion(NO,kMessage(Json),nil);
                          }
                      }else{
                          !completion?:completion(NO,@"数据格式不正确",nil);
                      }
                  } andFail:^(NSError *error) {
                    !completion?:completion(NO,[error localizedDescription],nil);
                  }];
    
}

#pragma mark -  **************** 2980商品  *****************
-(void)refrshGoods_twoNineEightZero_completion:(NetworkCompletionHandler)completion{
    self.goods_twoNineEightZero_page = 1;
    [SAAPIHelper goods_twoNineEightZero_page:_goods_twoNineEightZero_page
                                  completion:completion];
}

-(void)loadMoreGoods_twoNineEightZero_completion:(NetworkCompletionHandler)completion{
    self.goods_twoNineEightZero_page += 1;
    [SAAPIHelper goods_twoNineEightZero_page:_goods_twoNineEightZero_page
                                  completion:completion];
}


#pragma mark - Utils

+(void)goods_twoNineEightZero_page:(NSInteger)page
                        completion:(NetworkCompletionHandler)completion{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:@(page) forKey:@"p"];
    [HttpManager postWithUrl:@"Goods/twoNineEightZero"
               andParameters:para
                  andSuccess:^(id Json) {
                      if (SWNOTEmptyDictionary(Json)){
                          if (SuccessState(Json)){
                              NSArray *list = Json[@"data"][@"list"];
                              if (SWNOTEmptyArr(list)) {
                                  completion(YES,kMessage(Json),[SGoodsGoodsList mj_objectArrayWithKeyValuesArray:list]);
                              }else{
                                  completion(NO,page > 1 ? @"没有更多了..." : @"暂无数据",nil);
                              }
                          }else{
                             completion(NO,kMessage(Json),nil);
                          }
                      }else{
                       !completion?:completion(NO,@"数据格式不正确",nil);
                      }
                  }
                     andFail:^(NSError *error) {
                       !completion?:completion(NO,[error localizedDescription],nil);
                     }];
    
}

+(void)offlineStore_offlineStoreList_lng:(NSString *)lng
                                             lat:(NSString *)lat
                                               p:(NSInteger)page
                                     merchant_id:(NSString *)merchant_id
                                        top_cate:(NSString *)top_cate
                                     little_cate:(NSString *)little_cate
                                      completion:(NetworkCompletionHandler)completion{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:lng forKey:@"lng"];
    [para setValue:lat forKey:@"lat"];
    [para setValue:@(page) forKey:@"p"];
    if (SWNOTEmptyStr(merchant_id)) {
        [para setValue:merchant_id forKey:@"merchant_id"];
    }
    if (SWNOTEmptyStr(top_cate)) {
        [para setValue:top_cate forKey:@"top_cate"];
    }
    if (SWNOTEmptyStr(little_cate)) {
        [para setValue:little_cate forKey:@"little_cate"];
    }
    
    [HttpManager postWithUrl:@"OfflineStore/offlineStoreList"
               andParameters:para
                  andSuccess:^(id Json) {
                      if (SWNOTEmptyDictionary(Json)){
                          if (SuccessState(Json)) {
                              UBTypeEntryModel *model = [UBTypeEntryModel mj_objectWithKeyValues:Json];
                              if (SWNOTEmptyArr(model.nums)) {
                                  completion(YES,kMessage(Json),model);
                              }
                              else{
                                  completion(NO,page > 1 ? @"没有更多了..." : @"暂无数据",nil);
                              }
                          }else{
                              completion(NO,kMessage(Json),nil);
                          }
                      }else{
                          !completion?:completion(NO,@"数据格式不正确",nil);
                      }
                  }
                     andFail:^(NSError *error) {
                       !completion?:completion(NO,[error localizedDescription],nil);
                     }];
}

- (void)offlineStoreCommentListWithMerchant_id:(NSString *)merchant_id
                                          page:(NSUInteger)page
                                    completion:(NetworkCompletionHandler)completion{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:merchant_id forKey:@"merchant_id"];
    [para setValue:@(page) forKey:@"p"];
    
    [HttpManager postWithUrl:kOfflineStore_commentList
               andParameters:para
                  andSuccess:^(id Json) {
                      if (SWNOTEmptyDictionary(Json)) {
                          if (SuccessState(Json)) {
                              UBShopDetailCommentModel *model = [UBShopDetailCommentModel mj_objectWithKeyValues:Json];
                              if (SWNOTEmptyArr(model.data.list)) {
                                  completion(YES,kMessage(Json),model);
                              }else{
                                  completion(NO,page > 1 ? @"没有更多了..." : @"暂无数据",nil);
                              }
                          }else{
                              completion(NO,kMessage(Json),nil);
                          }
                      }else{
                          !completion?:completion(NO,@"数据格式不正确",nil);
                      }
                  }
                     andFail:^(NSError *error) {
                         !completion?:completion(NO,[error localizedDescription],nil);
                     }];
    
}

-(void)feachDataWithKeyWord:(NSString *)keyword
                       page:(NSUInteger)page
                 completion:(NetworkCompletionHandler)completion
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:keyword forKey:@"name"];
    [para setValue:@(page) forKey:@"p"];
    [HttpManager postWithUrl:kOfflineStore_search
               andParameters:para
                  andSuccess:^(id Json) {
                      if (SWNOTEmptyDictionary(Json)) {
                          if (SuccessState(Json)) {
                              NSArray *datas = [SOffLineNearbyStoreListModel mj_objectArrayWithKeyValuesArray:Json[@"data"]];
                              if (SWNOTEmptyArr(datas)) {
                                  completion(YES,kMessage(Json),datas);
                              }else{
                                  completion(NO,@"没有更多了...",nil);
                              }
                          }else{
                              completion(NO,@"没有更多了...",nil);
                          }
                      }else{
                          !completion?:completion(NO,@"数据格式不正确",nil);
                      }
                  }
                     andFail:^(NSError *error) {
                         !completion?:completion(NO,[error localizedDescription],nil);
                     }];
}

@end




