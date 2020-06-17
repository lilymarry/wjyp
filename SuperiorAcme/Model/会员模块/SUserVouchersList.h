//
//  SUserVouchersList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserVouchersListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SUserVouchersListFailureBlock) (NSError * error);

@interface SUserVouchersList : NSObject

@property (nonatomic, strong) SUserVouchersList * data;

@property (nonatomic, copy) NSArray * out;//表示过期失效的
@property (nonatomic, copy) NSArray * normal;//normal表示正常的

@property (nonatomic, copy) NSString * id;//"购物券id",
@property (nonatomic, copy) NSString * now_money;//": "代金券现有金额",
@property (nonatomic, copy) NSString * use_money;//":"使用金额"
@property (nonatomic, copy) NSString * create_time;//"创建时间",
@property (nonatomic, copy) NSString * end_time;//"过期时间",
@property (nonatomic, copy) NSString * user_id;//"用户id",
@property (nonatomic, copy) NSString * status;//0未使用 1 已使用
@property (nonatomic, copy) NSString * logo;//"购物券默认图标"
@property (nonatomic, copy) NSString * source_status;//":"联盟商家"


- (void)sUserVouchersListSuccess:(SUserVouchersListSuccessBlock)success andFailure:(SUserVouchersListFailureBlock)failure;
@end
