//
//  SUserUserDevelop.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserUserDevelopSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserUserDevelopFailureBlock) (NSError * error);

@interface SUserUserDevelop : NSObject

@property (nonatomic, strong) SUserUserDevelop * data;
@property (nonatomic, copy) NSString * head_pic;//"会员头衔",
@property (nonatomic, copy) NSString * level;//"会员等级名称",
@property (nonatomic, copy) NSString * my_point;//"年度成长值"
@property (nonatomic, copy) NSString * year;//"当前年分"
@property (nonatomic, copy) NSString * icon;//等级图标


@property (nonatomic, copy) NSArray * level_list;
@property (nonatomic, copy) NSString * level_id;// "1",
@property (nonatomic, copy) NSString * level_name;//"普通会员",
@property (nonatomic, copy) NSString * min_points;//"0", //阶段最小值
@property (nonatomic, copy) NSString * max_points;//"999",//阶段最大值
@property (nonatomic, copy) NSString * is_get;//"1" //是否获得 0未获得 1获得

- (void)sUserUserDevelopSuccess:(SUserUserDevelopSuccessBlock)success andFailure:(SUserUserDevelopFailureBlock)failure;
@end
