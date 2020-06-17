//
//  MyWAWAListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MyWAWAListModelSuccessBlock) (NSString * code, NSString * message, id data);

typedef void(^MyWAWAListModelFailureBlock) (NSError * error);
@interface MyWAWAListModel : NSObject
@property (nonatomic, copy) NSString * type;
@property (nonatomic, strong) MyWAWAListModel * data;
@property (nonatomic, strong) NSArray *deposit;

@property (nonatomic, copy) NSString *GraspingNum ;
@property (nonatomic, copy) NSString *catGoodsImg ;
@property (nonatomic, copy) NSString *cat_goods_img;
@property (nonatomic, copy) NSString *catcherNum ;
@property (nonatomic, copy) NSString *coinStatus;
@property (nonatomic, copy) NSString *countdown;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *depositStatus ;
@property (nonatomic, copy) NSString *exchange_price;
@property (nonatomic, copy) NSString *goodsStatus;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_img;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *maturityTime;
@property (nonatomic, copy) NSString *name ;
@property (nonatomic, copy) NSString *nickname ;
@property (nonatomic, copy) NSString *productId ;
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, copy) NSString *roomName ;
@property (nonatomic, copy) NSString *userHeader;
@property (nonatomic, copy) NSString *userNickName ;
@property (nonatomic, copy) NSString *c_time ;


@property (nonatomic, copy) NSString *createTime ;
//@property (nonatomic, copy) NSString *depositStatus;
@property (nonatomic, copy) NSString *goodsName ;
//@property (nonatomic, copy) NSString *goods_img;
@property (nonatomic, copy) NSString *id ;
//@property (nonatomic, copy) NSString *name ;
@property (nonatomic, copy) NSString *orderSn;
//@property (nonatomic, copy) NSString *roomId ;
//@property (nonatomic, copy) NSString *roomName;
@property (nonatomic, copy) NSString *update_time;
//@property (nonatomic, copy) NSString *userHeader;
//@property (nonatomic, copy) NSString *userNickName ;




@property(nonatomic, copy) NSString *details;
- (void)MyWAWAListModelSuccess:(MyWAWAListModelSuccessBlock)success andFailure:(MyWAWAListModelFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
