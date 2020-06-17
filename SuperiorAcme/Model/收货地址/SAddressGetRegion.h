//
//  SAddressGetRegion.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAddressGetRegionSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAddressGetRegionFailureBlock) (NSError * error);

@interface SAddressGetRegion : NSObject
@property (nonatomic, copy) NSString * region_id;//ID值 如果不传参数 默认返回北京列表 传入的话获取下一级区域列表

@property (nonatomic, strong) SAddressGetRegion * data;

@property (nonatomic, copy) NSArray * province_list;//省
@property (nonatomic, copy) NSArray * city_list;//市
@property (nonatomic, copy) NSArray * area_list;//区
@property (nonatomic, copy) NSArray * hot_list;//热门
@property (nonatomic, copy) NSArray * city;//全部二级城市

//@property (nonatomic, copy) NSString * region_id;//"id",
@property (nonatomic, copy) NSString * region_name;//"名称"

- (void)sAddressGetRegionSuccess:(SAddressGetRegionSuccessBlock)success andFailure:(SAddressGetRegionFailureBlock)failure;
@end
