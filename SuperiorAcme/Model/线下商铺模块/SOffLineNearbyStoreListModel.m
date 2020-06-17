//
//  SOffLineNearbyStoreListModel.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOffLineNearbyStoreListModel.h"

@implementation SOffLineNearbyStoreListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.RowCount = 0;
    }
    return self;
}

//线下店铺附近店铺列表
- (void)sOfflineStoreOfflineStoreListSuccess:(SOffLineNearbyStoreListModelSuccessBlock)success andFailure:(SOffLineNearbyStoreListModelFailureBlock)failure {
    
    [HttpManager postWithUrl:SOfflineStoreOfflineStoreList_Url andParameters:@{@"lng":_lng,@"lat":_lat,@"p":_p,@"merchant_id":self.merchant_id ?: @""} andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
      
        [SOffLineNearbyStoreListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"star":@"SOffLineNearbyStoreListModel",@"ticket":@"SOffLineNearbyStoreListModel"};
        }];
        id data = [SOffLineNearbyStoreListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
         id top = [SOffLineNearbyStoreListModel mj_objectArrayWithKeyValuesArray:dic[@"top_list"]];
        success(dic[@"code"],dic[@"message"],data,top);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

//-(void)setUser_id:(NSInteger)user_id{
//    _user_id = user_id;
//    _RowCount = user_id ? 2 : 1;
//}

- (void)setTicket:(NSArray *)ticket{
    _ticket = ticket;
    _RowCount = SWNOTEmptyArr(_ticket) ? 2 : 1;
}


@end
