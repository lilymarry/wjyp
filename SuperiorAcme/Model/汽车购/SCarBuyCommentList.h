//
//  SCarBuyCommentList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarBuyCommentListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCarBuyCommentListFailureBlock) (NSError * error);

@interface SCarBuyCommentList : NSObject
@property (nonatomic, copy) NSString * car_id;//    车ID    否    文本    1
@property (nonatomic, copy) NSString * label_id;//    标签ID    否    文本    未提供
@property (nonatomic, copy) NSString * p;//    分页ID

@property (nonatomic, strong) SCarBuyCommentList * data;
@property (nonatomic, copy) NSString * composite;//": "0.0",//综合评分
@property (nonatomic, copy) NSString * exterior;//": "0.0",//外观内饰评分
@property (nonatomic, copy) NSString * space;//": "0.0",//空间舒适评分
@property (nonatomic, copy) NSString * controllability;//": "0.0",//操控性评分
@property (nonatomic, copy) NSString * consumption;//": "0.0",//油耗动力评分

@property (nonatomic, copy) NSArray * label_list;
//@property (nonatomic, copy) NSString * label_id;//": "0",//标签ID
@property (nonatomic, copy) NSString * label_name;//": "全部",//标签名称
@property (nonatomic, copy) NSString * num;//": "4"//数量

@property (nonatomic, copy) NSArray * comment_list;
@property (nonatomic, copy) NSString * content;//": "跟他们一起去玩啊",//评价内容
@property (nonatomic, copy) NSString * create_time;//": "2017-12-01",//时间
@property (nonatomic, copy) NSString * comment_star;//": "4.75",//星级
@property (nonatomic, copy) NSString * nickname;//": "GYM",//评价人你昵称
@property (nonatomic, copy) NSString * head_pic;//": "http://wjyp.txunda.com/Uploads/User/2017-12-01/5a210bfc32b2e.png"//评价人头像
//评价图片数组
@property (nonatomic, copy) NSArray * pictures_arr;
@property (nonatomic, copy) NSString * path;//": "http://wjyp.txunda.com/Uploads/CarOrder/2017-12-01/5a20f61b14490.png"//图片路径
//评价标签数组
@property (nonatomic, copy) NSArray * label_arr;
@property (nonatomic, copy) NSString * label;//": "外观漂亮"//标签

- (void)sCarBuyCommentListSuccess:(SCarBuyCommentListSuccessBlock)success andFailure:(SCarBuyCommentListFailureBlock)failure;
@end
