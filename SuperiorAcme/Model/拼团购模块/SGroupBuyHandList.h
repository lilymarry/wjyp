//
//  SGroupBuyHandList.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/12/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SGroupBuyHandListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGroupBuyHandListFailureBlock) (NSError * error);

@interface SGroupBuyHandList : NSObject
@property (nonatomic, copy) NSString * a_id;
@property (nonatomic, copy) NSString * p;
@property (nonatomic, copy) NSString * size;
@property (nonatomic, strong) SGroupBuyHandList * data;
@property (nonatomic, strong) SGroupBuyHandList * user_info;
@property (nonatomic, strong) NSArray * rank_list;
@property (nonatomic, copy) NSString * rank;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * user_name;
@property (nonatomic, copy) NSString * head_pic;
@property (nonatomic, copy) NSString * user_count;
- (void)SGroupBuyHandListSuccess:(SGroupBuyHandListSuccessBlock)success andFailure:(SGroupBuyHandListFailureBlock)failure;


@end
