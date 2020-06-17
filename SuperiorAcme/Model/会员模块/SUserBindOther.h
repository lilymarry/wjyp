//
//  SUserBindOther.h
//  SuperiorAcme
//
//  Created by GYM on 2017/10/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBindOtherSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserBindOtherFailureBlock) (NSError * error);
typedef void(^SUserBindOtherAlipay_infoSuccessBlock) (NSString * code, NSString * message,NSDictionary *dic);
@interface SUserBindOther : NSObject
@property (nonatomic, copy) NSString * openid;//授权登陆后给的openid : 微信传unionId ，QQ和新浪微博传userId
@property (nonatomic, copy) NSString * type;//type '1'=>'微信','2'=>'微博','3'=>'QQ'
@property (nonatomic, copy) NSString * nickname;//昵称 可选

@property (nonatomic, copy) NSString * auth_code;//昵称 可选
- (void)sUserBindOtherSuccess:(SUserBindOtherSuccessBlock)success andFailure:(SUserBindOtherFailureBlock)failure;
//获取支付宝openid
- (void)sUserBindOtherAlipay_infoSuccess:(SUserBindOtherAlipay_infoSuccessBlock)success andFailure:(SUserBindOtherFailureBlock)failure;
@end
