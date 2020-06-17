//
//  SFreightSplit.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SFreightSplitSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SFreightSplitFailureBlock) (NSError * error);

@interface SFreightSplit : NSObject
@property (nonatomic, copy) NSString * address_id;//    地址ID    否    文本    1
@property (nonatomic, copy) NSString * now_goods_id;//    当前选中商品ID    否    文本    1
@property (nonatomic, copy) NSString * goods_info;//    [{'商品ID':'1','价格属性ID':'1','商品数量':'2'}] [{'goods_id':'1','product_id':'1','goods_num':'2'}]

@property (nonatomic, strong) SFreightSplit * data;
@property (nonatomic, copy) NSArray * tem;
@property (nonatomic, copy) NSString * id;//":"默认模板ID"
@property (nonatomic, copy) NSString * type_status;//"://1包邮 2是地区 3是默认
@property (nonatomic, copy) NSString * shipping_id;//"://快递公司ID
@property (nonatomic, copy) NSString * shipping_name;//"://快递公司名称
@property (nonatomic, copy) NSString * type;//": "1",//快递类型ID
@property (nonatomic, copy) NSString * type_name;//""平邮",//快递类型
@property (nonatomic, copy) NSString * pay;//": 29                // 运费金额
@property (nonatomic, copy) NSString * desc;//":描述  满多少件包邮
@property (nonatomic, copy) NSString * same_tem_id;//": "1,2,3",//相同模板的商品ID

- (void)sFreightSplitSuccess:(SFreightSplitSuccessBlock)success andFailure:(SFreightSplitFailureBlock)failure;
@end
