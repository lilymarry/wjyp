//
//  SRecommendingBusinessList.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SRecommendingBusinessListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SRecommendingBusinessListFailureBlock) (NSError * error);

@interface SRecommendingBusinessList : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * recommending_id;//”            // 联盟商家推荐id
@property (nonatomic, copy) NSString * logo;//": "1",               // logo
@property (nonatomic, copy) NSString * merchant_name;//":  //店铺名,
@property (nonatomic, copy) NSString * type;//": "1",              // 推荐类型（1->联盟商家，2->无界驿站）
@property (nonatomic, copy) NSString * city;//": "天津天津市西青区",      //所在城市
@property (nonatomic, copy) NSString * street;//": "街道",                      //所在街道
@property (nonatomic, copy) NSString * user_name;//": "用户名",          //联系人
@property (nonatomic, copy) NSString * user_phone;//": "15522211234",     //联系电话
@property (nonatomic, copy) NSString * status;////审核状态（0.1->审核中，2，3->审核拒绝，4->待入驻 5 入驻失败 6 入驻成功 7.入驻中）
@property (nonatomic, copy) NSString * create_time;//": "11111111"        //创建时间

- (void)sRecommendingBusinessListSuccess:(SRecommendingBusinessListSuccessBlock)success andFailure:(SRecommendingBusinessListFailureBlock)failure;
@end
