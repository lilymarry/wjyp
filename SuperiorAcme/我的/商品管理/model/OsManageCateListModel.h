//
//  OsManageCateListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/22.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^OsManageCateListModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^OsManageCateListModelFailureBlock) (NSError * error);
@interface OsManageCateListModel : NSObject

@property (nonatomic, copy) NSString * cate_id;
@property (nonatomic, copy) NSString * sta_mid;

@property (nonatomic, strong) OsManageCateListModel * data;

@property (nonatomic, strong) NSArray * cate_goods_list;
@property (nonatomic, copy) NSArray * attr;

@property (nonatomic, copy) NSString * attr_count;

@property (nonatomic, copy) NSString * bossrec;

@property (nonatomic, copy) NSString * c_name;


@property (nonatomic, copy) NSString * church_shop_price;
@property (nonatomic, copy) NSString * church_time_price;

@property (nonatomic, copy) NSString * church_week_price;

@property (nonatomic, copy) NSString * create_time;

@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * goods_id;

@property (nonatomic, copy) NSString * goods_pic;

@property (nonatomic, copy) NSString * id;

@property (nonatomic, copy) NSString * is_sale;

@property (nonatomic, copy) NSString * label;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * orig_price;

@property (nonatomic, copy) NSString * pic;

@property (nonatomic, copy) NSString * sale_num;

@property (nonatomic, copy) NSString * shop_price;
@property (nonatomic, copy) NSArray * specs;
@property (nonatomic, copy) NSString * specs_count;

@property (nonatomic, copy) NSString * sup_type;

@property (nonatomic, copy) NSString * time_price;
@property (nonatomic, copy) NSString * week_price;

@property (nonatomic, strong) OsManageCateListModel * cate_info;
@property (nonatomic, copy) NSString * label_int;
@property (nonatomic, assign) BOOL isturnEditStatus;
@property (nonatomic, assign) BOOL isSelect;
- (void)OsManageCateListModelSuccess:(OsManageCateListModelSuccessBlock)success andFailure:(OsManageCateListModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
