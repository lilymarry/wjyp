//
//  SGroupBuyThreeList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyThreeListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SGroupBuyThreeListFailureBlock) (NSError * error);

@interface SGroupBuyThreeList : NSObject
@property (nonatomic, copy) NSString * two_cate_id;//二级分类id
@property (nonatomic, copy) NSString * three_cate_id;//三级分类id
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SGroupBuyThreeList * data;

//三级分类列表
@property (nonatomic, copy) NSArray * three_cate_list;
//@property (nonatomic, copy) NSString * three_cate_id;"三级分类id",
@property (nonatomic, copy) NSString * short_name;//"分类简称",
@property (nonatomic, copy) NSString * name;// "分类名称"

@property (nonatomic, copy) NSArray * group_buy_list;
@property (nonatomic, copy) NSString * group_buy_id;//"团购ID",
@property (nonatomic, copy) NSString * group_price;//"团购价",
@property (nonatomic, copy) NSString * group_num;//"团购所需人数",
@property (nonatomic, copy) NSString * total;//"已被团数量",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;// "商品图片g",
@property (nonatomic, copy) NSString * country_id;//"国家ID",
@property (nonatomic, copy) NSString * ticket_buy_id;//"抵扣券id",
@property (nonatomic, copy) NSString * country_logo;//"国家图片",
@property (nonatomic, copy) NSString * ticket_buy_discount;//"折扣率"
//两个参团人头像
@property (nonatomic, copy) NSArray * append_person;
@property (nonatomic, copy) NSString * log_id;//"团编号",
@property (nonatomic, copy) NSString * user_id;//"开团者id",
@property (nonatomic, copy) NSString * head_pic;//"开团者头像"


/*
 *添加体验拼单商品提示
 */
@property (nonatomic, copy) NSString * group_type;//"类型 1试用品拼单 2常规拼单"

@property (nonatomic, copy) NSString * a_id;
- (void)sGroupBuyThreeListSuccess:(SGroupBuyThreeListSuccessBlock)success andFailure:(SGroupBuyThreeListFailureBlock)failure;
@end
