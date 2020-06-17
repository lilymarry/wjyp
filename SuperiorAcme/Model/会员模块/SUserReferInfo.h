//
//  SUserReferInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserReferInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserReferInfoFailureBlock) (NSError * error);

@interface SUserReferInfo : NSObject
@property (nonatomic, copy) NSString * refer_id;//推荐商家id

@property (nonatomic, strong) SUserReferInfo * data;
@property (nonatomic, copy) NSString * id;//"29",
@property (nonatomic, copy) NSString * name;//": "推荐商家名称",//推荐商家名称
@property (nonatomic, copy) NSString * range_id;//": "经营范围",//经营范围
@property (nonatomic, copy) NSString * link_man;//": "联系人",
@property (nonatomic, copy) NSString * job;//": "职位",
@property (nonatomic, copy) NSString * link_phone;//": "联系电话",
@property (nonatomic, copy) NSString * tmail_url;//": "天猫地址",
@property (nonatomic, copy) NSString * jd_url;//": "京东地址",
@property (nonatomic, copy) NSString * other_url;//": "其他网店地址",
@property (nonatomic, copy) NSString * status;//": "1",//0 未认证 1待审核 2已通过
@property (nonatomic, copy) NSString * create_time;//": "2017-09-22",//推荐时间
@property (nonatomic, copy) NSString * user_id;//": "38",
@property (nonatomic, copy) NSString * product_desc;//": "产品描述",
//@property (nonatomic, copy) NSString * refuse_desc;//": "拒绝理由"
@property (nonatomic, copy) NSString * desc;//": "店铺介绍，店铺介绍",
@property (nonatomic, copy) NSString * logo;//": "店铺logo",//选的产品图的第一张
@property (nonatomic, copy) NSString * score;//": "4.5"//评分
@property (nonatomic, copy) NSString * business_license;//": "营业执照",
@property (nonatomic, copy) NSString * refuse_desc;//2 客服审核未通过  refuse_desc 客服拒绝理由
@property (nonatomic, copy) NSString * is_desc;//3 招商审核未通过  is_desc  招商人员拒绝理由
@property (nonatomic, copy) NSString * is_kaihu;//5 入驻审核未通过  is_kaihu 客服拒绝理由



//产品图列表
@property (nonatomic, copy) NSArray * product_pic;
//其他证件照列表
@property (nonatomic, copy) NSArray * other_license;
@property (nonatomic, copy) NSString * path;//"http://wjyp.txunda.com/Uploads/MerchantRefer/2017-09-22/59c4da3998323.jpg"

- (void)sUserReferInfoSuccess:(SUserReferInfoSuccessBlock)success andFailure:(SUserReferInfoFailureBlock)failure;
@end
