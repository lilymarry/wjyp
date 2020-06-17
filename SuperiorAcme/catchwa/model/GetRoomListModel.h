//
//  getRoomListModel.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/30.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^getRoomListModelSuccessBlock) (NSString * code, NSString * message, id data,NSDictionary *dic_new);
typedef void(^getRoomListModelFailureBlock) (NSError * error);

@interface GetRoomListModel : NSObject
@property (nonatomic, copy) NSString * p;//顶级分类id
@property (nonatomic, copy) NSString * per;


@property (nonatomic, strong) GetRoomListModel * data;

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * pid;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * pic;
@property (nonatomic, copy) NSString * des;
@property (nonatomic, copy) NSString * g_cate;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * product_id;


@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * update_time;
@property (nonatomic, copy) NSString * other;
@property (nonatomic, copy) NSString * mac;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * catcher_num;
@property (nonatomic, copy) NSString * room_pic;
@property (nonatomic, copy) NSString * status_ming;


@property (nonatomic, copy) NSArray * victory;
//@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * nickname;
//@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, copy) NSString * head_pic;


@property (nonatomic, copy) NSArray * banner;
@property (nonatomic, copy) NSString * ads_id;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * href;
@property (nonatomic, copy) NSString * merchant_id;
@property (nonatomic, copy) NSString * picture;
@property (nonatomic, copy) NSString * position;

@property (nonatomic, strong) NSArray * sx;
@property (nonatomic, copy) NSString * clumn;
//@property (nonatomic, copy) NSString * id;
//@property (nonatomic, copy) NSString * name;
//@property (nonatomic, copy) NSString * pic;
//@property (nonatomic, copy) NSString * status;

@property (nonatomic, strong) GetRoomListModel * turntable;
@property (nonatomic, copy) NSString * check;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, strong) NSArray *sign_news;
@property (nonatomic, copy) NSString * bgImg;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * contentType;
//@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * prizeImg;
@property (nonatomic, copy) NSString * type;
- (void)getRoomListModelSuccess:(getRoomListModelSuccessBlock)success andFailure:(getRoomListModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
