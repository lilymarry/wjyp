//
//  SCarOrderAddComment.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarOrderAddComment.h"

@implementation SCarOrderAddComment

- (void)sCarOrderAddCommentSuccess:(SCarOrderAddCommentSuccessBlock)success andFailure:(SCarOrderAddCommentFailureBlock)failure {
    [HttpManager postUploadMultipleImagesWithUrl:SCarOrderAddComment_Url andImagesAndNames:_pictures andParameters:@{@"order_id":_order_id,@"exterior":_exterior,@"space":_space,@"controllability":_controllability,@"consumption":_consumption,@"label_str":_label_str,@"content":_content} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
