//
//  AddAppStageGoodS.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddAppStageGoodSSuccessBlock) (NSString * code, NSString * message);
typedef void (^AddAppStageGoodSFailureBlock) (NSError * error);

typedef void(^AddAfterAppStageGoodSSuccessBlock) (NSString * code, NSString * message,NSDictionary *dic);

@interface AddAppStageGoodS : NSObject


@property (nonatomic, copy) NSString * sta_mid;


@property (nonatomic, copy) NSString * sup_type;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * cate_id;
@property (nonatomic, copy) NSString * boxware;

@property (nonatomic, copy) NSArray * goods_attr;
@property (nonatomic, copy) NSArray * goods_property;


@property (nonatomic, copy) NSString * shop_price;
@property (nonatomic, copy) NSString * church_shop_price;

@property (nonatomic, strong) NSArray * ImagesAndNames;
@property (nonatomic, copy) NSString * label;



@property (nonatomic, copy) NSArray * week_price;
@property (nonatomic, copy) NSArray * church_week_price;

@property (nonatomic, strong) NSDictionary * time_price;
@property (nonatomic, copy) NSDictionary * church_time_price;
@property (nonatomic, copy) NSString * desc;

@property (nonatomic, strong) NSString * goods_id;

@property (nonatomic, copy) NSString * shop_jiesuan_price;
@property (nonatomic, copy) NSString * church_jiesuan_shop_price;

@property (nonatomic, copy) NSString * limit;
- (void)AddAppStageGoodSSuccess:(AddAppStageGoodSSuccessBlock)success andFailure:(AddAppStageGoodSFailureBlock)failure;

- (void)AddAfterAppStageGoodSSuccess:(AddAfterAppStageGoodSSuccessBlock)success andFailure:(AddAppStageGoodSFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
