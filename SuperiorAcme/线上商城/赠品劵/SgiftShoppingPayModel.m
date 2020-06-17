//
//  SgiftShoppingPayModel.m
//  SuperiorAcme/Users/tianjinwotiankeji/Desktop/wujie_ios_test 6  git/SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftShoppingPayModel.h"

@implementation SgiftShoppingPayModel
- (void)SgiftShoppingPayModelSuccess:(SgiftShoppingPayModelSuccessBlock)success andFailure:(SgiftShoppingPayModelFailureBlock)failure {
      NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.order_id)) {
       
        [para setValue:self.order_id forKey:@"order_id"];
    }
    if (SWNOTEmptyStr(self.order_type)) {
        
        [para setValue:self.order_type forKey:@"order_type"];
    }
    if (SWNOTEmptyStr(self.goods_num)) {
        
        [para setValue:self.goods_num forKey:@"goods_num"];
    }
    [HttpManager postSgiftWithUrl:@"GiftGoodsPay/giftGoodsPay" baseurl:SgiftBase_url
                    andParameters:para andSuccess:^(id Json) {
                        NSDictionary * dic = (NSDictionary *)Json;
                        success(dic[@"code"],dic[@"message"]);
                    } andFail:^(NSError *error) {
                        failure(error);
                    }];
}
@end
