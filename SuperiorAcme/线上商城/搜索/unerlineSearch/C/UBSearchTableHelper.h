//
//  UBSearchTableHelper.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/1.
//  Copyright © 2018年 GYM. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SOffLineNearbyStoreListModel.h"
#import "SAAPIHelper.h"

typedef enum : NSUInteger {
    NetworkErrorNoData,
    NetworkErrorNoMoreData
} NetworkError;

typedef void(^didSelectedRowHandler)(SOffLineNearbyStoreListModel *model);

@interface UBSearchTableHelper : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) didSelectedRowHandler didSelectRowBlock;
@property (nonatomic, copy) NSString *keyword;

+ (instancetype)instanceWithKeyWord:(NSString *)keyword tableView:(UITableView *)tableView;
- (void)fetchData;

@end
