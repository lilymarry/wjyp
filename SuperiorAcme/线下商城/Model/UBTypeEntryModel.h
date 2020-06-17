//
//  UBTypeEntryModel.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/21.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBTypeModel.h"
#import "SOffLineNearbyStoreListModel.h"

@interface UBTypeEntryModel : NSObject

/**
 附近列表数据
 */
@property (nonatomic, strong) NSArray *data;

/**
 二级分类
 */
@property (nonatomic, strong) NSArray *nums;

@property (nonatomic, copy) NSString *tip_num; //消息数

@end
