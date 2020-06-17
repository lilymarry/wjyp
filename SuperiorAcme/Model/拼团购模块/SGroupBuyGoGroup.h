//
//  SGroupBuyGoGroup.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyGoGroupSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGroupBuyGoGroupFailureBlock) (NSError * error);

@interface SGroupBuyGoGroup : NSObject
@property (nonatomic, copy) NSString * log_id;//开团id

@property (nonatomic, strong) SGroupBuyGoGroup * data;
@property (nonatomic, copy) NSString * diff;//"还差3人",//此时的参团信息
//@property (nonatomic, copy) NSString * log_id;//"1" //开团ID
@property (nonatomic, copy) NSString * rule;//"拼团须知"

@property (nonatomic, strong) SGroupBuyGoGroup * info;
//@property (nonatomic, copy) NSString * log_id;//"开团id",
@property (nonatomic, copy) NSString * user_id;//"团长id",
@property (nonatomic, copy) NSString * group_num;//"团购所需人数",
@property (nonatomic, copy) NSString * group_price;//"团购价",
@property (nonatomic, copy) NSString * total;//"已经被团的数量",
@property (nonatomic, copy) NSString * goods_id;// "商品id",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * goods_name;//"商品名称"

//参团人信息
@property (nonatomic, copy) NSArray * person;
@property (nonatomic, copy) NSString * head_pic;//"头像",
@property (nonatomic, copy) NSString * nickname;//"昵称",
@property (nonatomic, copy) NSString * is_first;//"是否是团长"

- (void)sGroupBuyGoGroupSuccess:(SGroupBuyGoGroupSuccessBlock)success andFailure:(SGroupBuyGoGroupFailureBlock)failure;
@end
