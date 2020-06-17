//
//  GetShengqiangouModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetShengqiangouModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^GetShengqiangouModelFailureBlock) (NSError * error);

@interface GetShengqiangouModel : NSObject
@property (nonatomic, copy) NSString * type;

@property (nonatomic, copy) NSString * q;
@property (nonatomic, copy) NSString * p;
@property (nonatomic, copy) NSString * sort_type;

@property (nonatomic, strong) NSArray * goods_list;
@property (nonatomic, strong) GetShengqiangouModel * data;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * pict_url;



@property (nonatomic, copy) NSString * zk_final_price;

@property (nonatomic, copy) NSString * reserve_price;
@property (nonatomic, copy) NSString * volume;

@property (nonatomic, copy) NSString * item_url;
@property (nonatomic, copy) NSString *biaoshi;
- (void)GetShengqiangouModelsSuccess:(GetShengqiangouModelSuccessBlock)success andFailure:(GetShengqiangouModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
