//
//  SHouseBuyCommentList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseBuyCommentListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SHouseBuyCommentListFailureBlock) (NSError * error);

@interface SHouseBuyCommentList : NSObject
@property (nonatomic, copy) NSString * house_id;//    房产购id    否    文本    1
@property (nonatomic, copy) NSString * p;//    分页参数    否    文本    1
@property (nonatomic, copy) NSString * label_id;//    标签id

@property (nonatomic, strong) SHouseBuyCommentList * data;
@property (nonatomic, copy) NSString * composite;//": "4.1",//综合评分
@property (nonatomic, copy) NSString * price;//": "3.8",//价格评分
@property (nonatomic, copy) NSString * lot;//": "3.5",//地段评分
@property (nonatomic, copy) NSString * supporting;//": "4.3",//配套评分
@property (nonatomic, copy) NSString * traffic;//": "4.0",//交通评分
@property (nonatomic, copy) NSString * environment;//": "4.8"//环境评分

//标签列表
@property (nonatomic, copy) NSArray * label_list;
//@property (nonatomic, copy) NSString * label_id;//": "0",//标签id
@property (nonatomic, copy) NSString * label_name;//": "全部",//标签名称
@property (nonatomic, copy) NSString * num;//": "4"//数量

//评价列表
@property (nonatomic, copy) NSArray * comment_list;
//@property (nonatomic, copy) NSString * price;//": "5",//价格评分
//@property (nonatomic, copy) NSString * lot;//": "4",//地段评分
//@property (nonatomic, copy) NSString * supporting;//": "5",//配套评分
//@property (nonatomic, copy) NSString * traffic;//": "4",//交通评分
//@property (nonatomic, copy) NSString * environment;//": "5",//环境评分
@property (nonatomic, copy) NSString * content;//": "啦咯啦咯啦咯啦咯啦咯啦咯",//评价内容
@property (nonatomic, copy) NSString * create_time;//": "2017-12-01",//评价时间
@property (nonatomic, copy) NSString * comment_star;//": "4.6",//总评分
@property (nonatomic, copy) NSString * nickname;//": "GYM",//用户昵称
@property (nonatomic, copy) NSString * head_pic;//": "用户昵称"
//评价图片
@property (nonatomic, copy) NSArray * pictures_arr;
@property (nonatomic, copy) NSString * path;//": "图片路径"
//评价标签
@property (nonatomic, copy) NSArray * label_arr;
@property (nonatomic, copy) NSString * label;//": "户型完美"//标签列表

- (void)sHouseBuyCommentListSuccess:(SHouseBuyCommentListSuccessBlock)success andFailure:(SHouseBuyCommentListFailureBlock)failure;
@end
