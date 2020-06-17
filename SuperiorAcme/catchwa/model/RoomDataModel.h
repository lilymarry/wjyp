//
//  RoomData.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^RoomDataModelSuccessBlock) (NSString * code, NSString * message, id data);

typedef void(^RoomDataModelFailureBlock) (NSError * error);
@interface RoomDataModel : NSObject
@property(copy ,nonatomic)NSString *   id ;
@property (nonatomic, strong) RoomDataModel * data;


@property (nonatomic, strong) RoomDataModel *  RoomPeople ;
@property (nonatomic, strong) RoomDataModel *  nowPeople ;
@property(copy ,nonatomic)NSString * nickname;
@property(copy ,nonatomic)NSString *  headPath;
@property(copy ,nonatomic)NSString * cMing;
@property(strong ,nonatomic)NSArray *headPic ;
@property(copy ,nonatomic)NSString * head_pic;
@property(copy ,nonatomic)NSString *  nowStatus;
@property(copy ,nonatomic)NSString * peopleNum ;

@property(strong ,nonatomic)NSArray *ads ;
@property(copy ,nonatomic)NSString * ads_href;
@property(copy ,nonatomic)NSString *ads_id;
@property(copy ,nonatomic)NSString *desc;
@property(copy ,nonatomic)NSString *goods_id;
@property(copy ,nonatomic)NSString *href ;
@property(copy ,nonatomic)NSString *merchant_id;
@property(copy ,nonatomic)NSString *picture ;
@property(copy ,nonatomic)NSString *position ;

@property(strong ,nonatomic)NSArray * gDetails;
@property(copy ,nonatomic)NSString *goods_name;
@property(copy ,nonatomic)NSString *goods_pic;
@property(copy ,nonatomic)NSString * num ;

@property (nonatomic, strong) RoomDataModel * listA ;
@property(copy ,nonatomic)NSString * cid ;
@property(copy ,nonatomic)NSString *coin;
@property(copy ,nonatomic)NSString *price;
@property(copy ,nonatomic)NSString * priceStatus ;
@property(strong ,nonatomic)NSArray * listB;
//@property(copy ,nonatomic)NSString *head_pic;
@property(copy ,nonatomic)NSString *user_id;
@property(copy ,nonatomic)NSString * status;
@property (nonatomic, strong) RoomDataModel *toShare;
@property(copy ,nonatomic)NSString *Shapetype;
@property(copy ,nonatomic)NSString * content;
//@property(copy ,nonatomic)NSString * id ;
@property(copy ,nonatomic)NSString *  pic ;
@property(copy ,nonatomic)NSString * title ;
@property(copy ,nonatomic)NSString * url ;

- (void)RoomDataModelSuccess:(RoomDataModelSuccessBlock)success andFailure:(RoomDataModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
