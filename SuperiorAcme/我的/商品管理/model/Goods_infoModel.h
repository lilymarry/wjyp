//
//  Goods_infoModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/13.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^Goods_infoModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^Goods_infoModelFailureBlock) (NSError * error);
@interface Goods_infoModel : NSObject
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, strong) Goods_infoModel * data;

@property (nonatomic, copy) NSString * sup_type;
@property (nonatomic, copy) NSString * cate_id;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * shop_price;

@property (nonatomic, copy) NSString * shop_jiesuan_price;
@property (nonatomic, copy) NSString * church_shop_price;
@property (nonatomic, copy) NSString * church_jiesuan_shop_price;
@property (nonatomic, copy) NSString * boxware;

@property (nonatomic, strong) NSArray * goods_pic;
@property (nonatomic, copy) NSString * path;



@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * label;

@property (nonatomic, strong) NSArray * week_price;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * jiesuan_price;

@property (nonatomic, strong) NSArray * church_week_price;
//@property (nonatomic, copy) NSString * price;
//@property (nonatomic, copy) NSString * jiesuan_price;


@property (nonatomic, strong) Goods_infoModel * time_price;

@property (nonatomic, copy) NSString * start_time;
@property (nonatomic, copy) NSString * end_time;
//@property (nonatomic, copy) NSString * price;
//@property (nonatomic, copy) NSString * jiesuan_price;


@property (nonatomic, strong) Goods_infoModel * church_time_price;

@property (nonatomic, copy) NSString * cate_name;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * examine_desc;
@property (nonatomic, copy) NSString * attr_name;
@property (nonatomic, copy) NSString * specs_name;

@property (nonatomic, copy) NSString * limit;


- (void)Goods_infoModelSuccess:(Goods_infoModelSuccessBlock)success andFailure:(Goods_infoModelFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
