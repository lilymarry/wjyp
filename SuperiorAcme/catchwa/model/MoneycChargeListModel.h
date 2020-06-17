//
//  MoneycChargeListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^MoneycChargeListModelSuccessBlock) (NSString * code, NSString * message, id data);

typedef void(^MoneycChargeListModelFailureBlock) (NSError * error);
@interface MoneycChargeListModel : NSObject
@property(copy ,nonatomic)NSString *   p ;
@property(copy ,nonatomic)NSString *  type;

@property (nonatomic, strong) MoneycChargeListModel * data ;
@property(copy ,nonatomic)NSString *count_list;
@property(strong ,nonatomic)NSArray *list ;
@property(copy ,nonatomic)NSString *create_time;
@property(copy ,nonatomic)NSString *desc ;
@property(copy ,nonatomic)NSString *from_type;
@property(copy ,nonatomic)NSString *id ;
@property(copy ,nonatomic)NSString *id_val;
@property(copy ,nonatomic)NSString *img ;
@property(copy ,nonatomic)NSString *money ;
@property(copy ,nonatomic)NSString *order_id;
@property(copy ,nonatomic)NSString *pay_type;
@property(copy ,nonatomic)NSString *status ;
@property(copy ,nonatomic)NSString *sub_type;
@property(copy ,nonatomic)NSString *sub_type_desc;

@property(copy ,nonatomic)NSString *user_id;

@property(copy ,nonatomic)NSString *shouru_money;
@property(copy ,nonatomic)NSString *user_money;
@property(copy ,nonatomic)NSString *zhichu_money;


- (void)MoneycChargeListModelSuccess:(MoneycChargeListModelSuccessBlock)success andFailure:(MoneycChargeListModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
