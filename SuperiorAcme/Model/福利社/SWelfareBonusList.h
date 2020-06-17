//
//  SWelfareBonusList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SWelfareBonusListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SWelfareBonusListFailureBlock) (NSError * error);

@interface SWelfareBonusList : NSObject
@property (nonatomic, copy) NSString * bonus_id;//红包id

@property (nonatomic, strong) SWelfareBonusList * data;
//@property (nonatomic, copy) NSString * bonus_id;//": "红包id",
@property (nonatomic, copy) NSString * bonus_val;//": 红包金额,
@property (nonatomic, copy) NSString * logo;//": "店铺logo",
@property (nonatomic, copy) NSString * merchant_name;//": "店铺名称"

@property (nonatomic, copy) NSArray * ads_list;
@property (nonatomic, copy) NSString * ads_id;//": "广告id",
@property (nonatomic, copy) NSString * bonus_title;//": "标题",
@property (nonatomic, copy) NSString * bonus_ads;//": "链接",//分视频和图片
@property (nonatomic, copy) NSString * type;//": "1",//类型  1 视频 2图片
@property (nonatomic, copy) NSString * delay_time;//": "0" //持续时间 图片有时间 视频根据时长来定 返回0   单位秒

- (void)sWelfareBonusListSuccess:(SWelfareBonusListSuccessBlock)success andFailure:(SWelfareBonusListFailureBlock)failure;
@end
