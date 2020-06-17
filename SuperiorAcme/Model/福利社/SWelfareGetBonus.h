//
//  SWelfareGetBonus.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SWelfareGetBonusSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SWelfareGetBonusFailureBlock) (NSError * error);

@interface SWelfareGetBonus : NSObject
@property (nonatomic, copy) NSString * bonus_id;//红包ID
@property (nonatomic, copy) NSString * bonus_val;//红包金额

@property (nonatomic, strong) SWelfareGetBonus * data;
//@property (nonatomic, copy) NSString * bonus_val;//红包金额,
@property (nonatomic, copy) NSString * head_pic;//"用户头像"

- (void)sWelfareGetBonusSuccess:(SWelfareGetBonusSuccessBlock)success andFailure:(SWelfareGetBonusFailureBlock)failure;
@end
