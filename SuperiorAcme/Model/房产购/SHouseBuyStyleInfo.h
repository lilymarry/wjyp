//
//  SHouseBuyStyleInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseBuyStyleInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SHouseBuyStyleInfoFailureBlock) (NSError * error);

@interface SHouseBuyStyleInfo : NSObject
@property (nonatomic, copy) NSString * style_id;//户型id;

@property (nonatomic, strong) SHouseBuyStyleInfo * data;
@property (nonatomic, copy) NSString * id;//": "户型id",
@property (nonatomic, copy) NSString * style_name;//": "户型名称 ",
@property (nonatomic, copy) NSString * house_address;//'楼盘地址'
@property (nonatomic, copy) NSString * house_id;//": "楼盘id",
@property (nonatomic, copy) NSString * tags;//": "大户型 在售 独栋",//标签
@property (nonatomic, copy) NSString * all_price;//": "房全款.71",
@property (nonatomic, copy) NSString * integral;//": "积分",
@property (nonatomic, copy) NSString * house_style_desc;//": "户型描述",
@property (nonatomic, copy) NSString * one_price;//": "房价",
@property (nonatomic, copy) NSString * pre_money;//": "代金券",
@property (nonatomic, copy) NSString * true_pre_money;//": "可抵金额",
@property (nonatomic, copy) NSString * pictures;//": "7863,7864,7865",
@property (nonatomic, copy) NSString * area;//": "      ",
@property (nonatomic, copy) NSString * ticket_discount;//": "购物券比例",
@property (nonatomic, copy) NSString * house_name;//": "楼盘名称",
@property (nonatomic, copy) NSString * cart_num;//": "购物车数量"
@property (nonatomic, copy) NSString * house_style_img;//": ""户型图片,
@property (nonatomic, copy) NSString * developer;//": "公司名称",
@property (nonatomic, copy) NSString * easemob_account;//:'客服环信账号'
@property (nonatomic, copy) NSString * server_head_pic;//:客服头像
@property (nonatomic, copy) NSString * server_name;//：客服名称

//户型轮播图
@property (nonatomic, copy) NSArray * banner;
@property (nonatomic, copy) NSString * path;// "http://wjyp.txunda.com/Uploads/HouseStyle/2017-09-05/59ae6338ef521.jpg"

//其他户型
@property (nonatomic, copy) NSArray * other_style;
//@property (nonatomic, copy) NSString * style_id;//": "户型id",
//@property (nonatomic, copy) NSString * style_name;//": "户型名称",
//@property (nonatomic, copy) NSString * house_style_img;//": "户型封面图",
//@property (nonatomic, copy) NSString * pre_money;//": "代金券",
//@property (nonatomic, copy) NSString * true_pre_money;//": "可抵金额",
//@property (nonatomic, copy) NSString * one_price;//";: "房价",
//@property (nonatomic, copy) NSString * all_price;//": "房全款",
//@property (nonatomic, copy) NSString * integral;//": "积分",
//@property (nonatomic, copy) NSString * ticket_discount;//": "购物券比例",
//@property (nonatomic, copy) NSString * developer;//": "开发商",
@property (nonatomic, copy) NSString * total;//": "总数",
@property (nonatomic, copy) NSString * sell_num;//": "已售"
@property (nonatomic, copy) NSString * country_logo;//国家logo
@property (nonatomic, copy) NSString * country_id;//

- (void)sHouseBuyStyleInfoSuccess:(SHouseBuyStyleInfoSuccessBlock)success andFailure:(SHouseBuyStyleInfoFailureBlock)failure;
@end
