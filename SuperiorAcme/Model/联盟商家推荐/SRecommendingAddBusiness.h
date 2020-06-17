//
//  SRecommendingAddBusiness.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SRecommendingAddBusinessSuccessBlock) (NSString * code, NSString * message);
typedef void(^SRecommendingAddBusinessFailureBlock) (NSError * error);

@interface SRecommendingAddBusiness : NSObject
@property (nonatomic, copy) NSString * mechant_name;//    商家名称    否    文本    1
@property (nonatomic, copy) NSString * user_name;//    联系人    否    文本    1
@property (nonatomic, copy) NSString * user_position;//    职位    否    文本    1
@property (nonatomic, copy) NSString * user_phone;//    联系电话    否    文本    1
@property (nonatomic, copy) NSString * city;//    所在地区（‘，’分隔，省市区）    否    文本    1
@property (nonatomic, copy) NSString * street;//    街道    否    文本    1
@property (nonatomic, copy) NSString * desc;//    情况描述    否    文本    1
//@property (nonatomic, strong) UIImage * license;//    营业执照    否    文本    未提供
//@property (nonatomic, strong) UIImage * facade;//    身份证正面    否    文本    未提供
//@property (nonatomic, strong) UIImage * identity;//    身份证反面    否    文本    未提供
@property (nonatomic, copy) NSString * type;//    推荐类型（1->联盟商家，2->无界驿站）    否    文本    1
//@property (nonatomic, strong) UIImage * apply;//    申请说明（type为2时传）    否    文本    未提供
//@property (nonatomic, strong) UIImage * logo;//    logo    否    文本    未提供
@property (nonatomic, copy) NSString * rec_type_id;//    类别id
@property (nonatomic, strong) NSDictionary * pic;

- (void)sRecommendingAddBusinessSuccess:(SRecommendingAddBusinessSuccessBlock)success andFailure:(SRecommendingAddBusinessFailureBlock)failure;
@end
