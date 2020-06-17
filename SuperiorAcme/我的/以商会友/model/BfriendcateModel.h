//
//  Bfriend_cateModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//
/*
sta_mid    商户id    否    文本    12
参数汇总    获取分组列表时参数：sta_mid、t=1
添加分组时参数：sta_mid、name
编辑分组时参数：id(分组id)、name(修改后分组名称)、is_del=0
删除分组时参数：id(分组id)、is_del:1
向分组中添加会员参数：id(分组id)、uid(多个用,分割)、type=2
删除分组中已添加的好友参数:id(分组id)、uid(单个)、is_del=2
获取分组中已添加好友列表时参数：sta_mid、id(分组id)、type=2、t=1
获取分组中未添加分组好友列表时参数：sta_mid、id(分组id)、type=3、t=1
*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BfriendcateListModelSuccessBlock) (NSString * code, NSString * message, id data);


typedef void (^BfriendcateModelFailureBlock) (NSError * error);


@interface BfriendcateModel : NSObject
@property (nonatomic, copy) NSString * t;

@property (nonatomic, copy) NSString * sta_mid;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * is_del;

- (void)BfriendcateListModelSuccess:(BfriendcateListModelSuccessBlock)success andFailure:(BfriendcateModelFailureBlock)failure;



@end

NS_ASSUME_NONNULL_END
