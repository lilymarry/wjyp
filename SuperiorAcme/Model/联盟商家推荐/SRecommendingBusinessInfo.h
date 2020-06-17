//
//  SRecommendingBusinessInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SRecommendingBusinessInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SRecommendingBusinessInfoFailureBlock) (NSError * error);

@interface SRecommendingBusinessInfo : NSObject
@property (nonatomic, copy) NSString * recommending_id;//    联盟商家推荐id;

@property (nonatomic, strong) SRecommendingBusinessInfo * data;
//@property (nonatomic, copy) NSString * recommending_id;//": "1",                          // 联盟商家id
@property (nonatomic, copy) NSString * merchant_name;//": "店铺名",                   // 店铺名
@property (nonatomic, copy) NSString * logo;//": "http://tkl.txunda.com/Uploads/Merchant/2016-11-11/58255b6fa209e.jpg",    // logo
@property (nonatomic, copy) NSString * rec_type_id;//": "",                          //商家类别
@property (nonatomic, copy) NSString * user_name;//": "用户名",               //联系人
@property (nonatomic, copy) NSString * user_position;//": "职位",             //职位
@property (nonatomic, copy) NSString * user_phone;//": "15522211234",            // 联系电话
@property (nonatomic, copy) NSString * city;//": "天津天津市西青区",                    // 所在城市
@property (nonatomic, copy) NSString * street;//": "街道",                                    // 所在街道
@property (nonatomic, copy) NSString * desc;//": "描述",                          //申请企业情况描述
@property (nonatomic, copy) NSString * license;//": "http://tkl.txunda.com/Uploads/Merchant/2016-11-11/58255b6fa301c.jpg",       // 营业执照
@property (nonatomic, copy) NSString * identity;//": "http://tkl.txunda.com/Uploads/Merchant/2016-11-11/58255b6fa24dd.jpg",      // 身份证反面
@property (nonatomic, copy) NSString * facade;//": "http://tkl.txunda.com/Uploads/Merchant/2016-11-11/58255b6fa289b.jpg",    //身份证正面
@property (nonatomic, copy) NSString * apply;//": "",             //申请说明
@property (nonatomic, copy) NSString * type;//": "1",              //推荐类型（1->联盟商家，2->无界驿站）
@property (nonatomic, copy) NSString * status;//": "0",          //审核状态（1->审核中，2->审核通过，3->审核拒绝）
@property (nonatomic, copy) NSString * reason;//": "",          //拒绝原因
@property (nonatomic, copy) NSString * user_id;//": "54",      // 用户id
@property (nonatomic, copy) NSString * create_time;//": "11111111",        //创建时间
@property (nonatomic, copy) NSString * update_time;//": "0"                    //更新时间

- (void)sRecommendingBusinessInfoSuccess:(SRecommendingBusinessInfoSuccessBlock)success andFailure:(SRecommendingBusinessInfoFailureBlock)failure;
@end
