//
//  SOrderCommentGoods.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderCommentGoods.h"

@implementation SOrderCommentGoods

- (void)sOrderCommentGoodsSuccess:(SOrderCommentGoodsSuccessBlock)success andFailure:(SOrderCommentGoodsFailureBlock)failure {
    if (_pictures == nil) {
        [HttpManager postWithUrl:SOrderCommentGoods_Url andParameters:@{@"order_goods_id":_order_goods_id,@"content":_content,@"all_star":_all_star,@"order_id":_order_id,@"order_type":_order_type} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    } else {
        [HttpManager postUploadMultipleImagesWithUrl:SOrderCommentGoods_Url andImagesAndNames:_pictures andParameters:@{@"order_goods_id":_order_goods_id,@"content":_content,@"all_star":_all_star,@"order_id":_order_id,@"order_type":_order_type} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    }
}
@end
