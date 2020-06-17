//
//  StoreStatisticsModel.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

typedef void(^Success)(NSDictionary *data);
typedef void(^Failure)(NSError *error);

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface StoreStatisticsModel : BaseModel

/// 小店id
@property (nonatomic, strong) NSString * storeId;
/// 必须传1才是统计信息
@property (nonatomic, strong) NSString * type;
/// 1：销售额 0：净收益
@property (nonatomic, strong) NSString * c_type;
/// 1: 日 2：月 0 ：年
@property (nonatomic, strong) NSString * c_base_type;


/**
 获取小店营收数据
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getStatisticsData:(Success)success andFailure:(Failure)failure;

@end
