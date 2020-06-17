//
//  BaseShare.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "BaseShare.h"
#import "BaseAFNetworkingManager.h"
#import "AShare.h"

@implementation BaseShare

/**
 从服务器获取分享url
 
 @param url 接口请求地址
 @param parameters 请求参数
 */
-(void)shareApi:(NSString *)url andParameters:(NSDictionary *)parameters andViewController:(UIViewController *)viewController andShareParameters:(NSDictionary *)dit{
    BaseAFNetworkingManager *baseAFNetworkingManager = [BaseAFNetworkingManager defaultManager];
    [baseAFNetworkingManager sendRequestMethod:HTTPMethodPOST url:Base_url apiPath:url parameters:parameters progress:nil success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 200) {
            [self shareSend:viewController andUrl:responseObject[@"data"][@"url"] andShareParameters:dit];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)shareSend:(UIViewController *)viewController andUrl:(NSString *)url andShareParameters:(NSDictionary *)dit{
    AShare * shareVC = [[AShare alloc] init];
    shareVC.thisUrl = url;
    shareVC.thisImage = dit[@"shareGoodsImage"];
    shareVC.thisTitle = dit[@"shareGoodsName"];
    shareVC.thisContent = dit[@"content"];
    shareVC.id_val = dit[@"id_val"];
    shareVC.thisType = dit[@"type"];
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [viewController presentViewController:shareVC animated:YES completion:nil];
}
@end
