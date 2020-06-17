//
//  SHouseOrderAddComment.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseOrderAddComment.h"

@implementation SHouseOrderAddComment

- (void)HouseOrderAddCommentSuccess:(SHouseOrderAddCommentSuccessBlock)success andFailure:(SHouseOrderAddCommentFailureBlock)failure {
    [HttpManager postUploadMultipleImagesWithUrl:SHouseOrderAddComment_Url andImagesAndNames:_pictures andParameters:@{@"order_id":_order_id,@"price":_price,@"lot":_lot,@"supporting":_supporting,@"traffic":_traffic,@"environment":_environment,@"label_str":_label_str,@"content":_content} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
