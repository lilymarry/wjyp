//
//  YingLiangWebInfo.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/7.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YinLiangWebInfoSuccessBlock) (NSString * code, NSString * message,id data);
typedef void(^YinLiangWebInfoFailureBlock) (NSError * error);


@interface YinLiangWebInfo : NSObject
@property (nonatomic, copy) NSString * p;//分页参数
@property (nonatomic, copy) NSString * count_list;
@property (nonatomic, copy) NSString * shouru_money;
@property (nonatomic, copy) NSString * zhichu_money;

@property (nonatomic, strong)YinLiangWebInfo  * data;
@property (nonatomic ,copy) NSArray * info;
@property (nonatomic ,copy) NSString * time;
@property (nonatomic ,copy) NSArray * list;
@property (nonatomic, copy) NSString * id;//分页参数
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * money;

@property (nonatomic, copy) NSString * id_val;//分页参数
@property (nonatomic, copy) NSString * sub_type;
@property (nonatomic, copy) NSString * from_type;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * img;
@property (nonatomic, copy) NSString * sub_type_desc;




- (void)YinLiangWebInfoSuccess:(YinLiangWebInfoSuccessBlock)success andFailure:(YinLiangWebInfoFailureBlock)failure;
@end


