//
//  SMerchantMerInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMerchantMerInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SMerchantMerInfoFailureBlock) (NSError * error);

@interface SMerchantMerInfo : NSObject
@property (nonatomic, copy) NSString * merchant_id;//商家id

@property (nonatomic, strong) SMerchantMerInfo * data;
@property (nonatomic, copy) NSString * is_collect;//"是否收藏",
@property (nonatomic, copy) NSString * share_url;//": "http://wjyp.txunda.com",//分享链接
@property (nonatomic, copy) NSString * share_img;//": "分享图片",
@property (nonatomic, copy) NSString * share_content;//": "分享内容"

@property (nonatomic, strong) SMerchantMerInfo * mer_comment;
@property (nonatomic, copy) NSString * total;//"评论总数",
@property (nonatomic, copy) NSString * score;//"综合评分",
//一条评论
@property (nonatomic, strong) SMerchantMerInfo * one_comment;
@property (nonatomic, copy) NSString * user_id;//"会员id",
@property (nonatomic, copy) NSString * nickname;//"会员昵称",
@property (nonatomic, copy) NSString * create_time;// "评论时间",
@property (nonatomic, copy) NSString * all_star;//"评论星级",
@property (nonatomic, copy) NSString * head_pic;//"会员头像"
@property (nonatomic, copy) NSString * goods_id;//商品id

@property (nonatomic, strong) SMerchantMerInfo * mer_info;
@property (nonatomic, copy) NSString * goods_total;//"该店商品总数",
@property (nonatomic, copy) NSString * goods_month_num;//"月销售量",
@property (nonatomic, copy) NSString * view_num;//"关注人数",
@property (nonatomic, copy) NSString * address;//"门店地址",
@property (nonatomic, copy) NSString * phone;//"门店电话"
@property (nonatomic, copy) NSString * open_time;//": "营业时间"


- (void)sMerchantMerInfoSuccess:(SMerchantMerInfoSuccessBlock)success andFailure:(SMerchantMerInfoFailureBlock)failure;
@end
