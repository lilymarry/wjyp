//
//  SHouseBuyHouseInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseBuyHouseInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SHouseBuyHouseInfoFailureBlock) (NSError * error);

@interface SHouseBuyHouseInfo : NSObject
@property (nonatomic, copy) NSString * house_id;//楼盘id

@property (nonatomic, strong) SHouseBuyHouseInfo * data;
@property (nonatomic, copy) NSString * id;//": "1",//楼盘id
@property (nonatomic, copy) NSString * house_name;//": "楼盘名称",
@property (nonatomic, copy) NSString * province_name;//": "省id",
@property (nonatomic, copy) NSString * city_name;//": "市id",
@property (nonatomic, copy) NSString * area_name;//": "地区id",
@property (nonatomic, copy) NSString * address;//": "详细地址",
@property (nonatomic, copy) NSString * lng;//": "经度",
@property (nonatomic, copy) NSString * lat;//": "纬度",
@property (nonatomic, copy) NSString * min_price;//": "最低价",
@property (nonatomic, copy) NSString * max_price;//": "最高价",
@property (nonatomic, copy) NSString * sell_address;//": "售楼处",
@property (nonatomic, copy) NSString * now_num;//": "在售房源",
@property (nonatomic, copy) NSString * link_man;//": "联系人",
@property (nonatomic, copy) NSString * link_phone;//": "联系电话",
@property (nonatomic, copy) NSString * is_collect;//": "是否收藏"
@property (nonatomic, copy) NSString * comment_num;//": "5",//总评分

//楼盘信息列表
@property (nonatomic, copy) NSArray * house_attr;
@property (nonatomic, copy) NSString * key;//": "信息名称",
@property (nonatomic, copy) NSString * value;//": "信息值"

@property (nonatomic, copy) NSArray * comment_new;
@property (nonatomic, copy) NSString * price;//": "5",//价格评分
@property (nonatomic, copy) NSString * lot;//": "4",//地段评分
@property (nonatomic, copy) NSString * supporting;//": "5",//配套评分
@property (nonatomic, copy) NSString * traffic;//": "4",//交通评分
@property (nonatomic, copy) NSString * environment;//": "5",//环境评分
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

//轮播图
@property (nonatomic, copy) NSArray * banner;
//@property (nonatomic, copy) NSString * path;//"http://wjyp.txunda.com/Uploads/HouseBuy/2017-09-05/59ae5283e1243.jpg"

- (void)sHouseBuyHouseInfoSuccess:(SHouseBuyHouseInfoSuccessBlock)success andFailure:(SHouseBuyHouseInfoFailureBlock)failure;
@end
