//
//  UBShopDetailModel.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UBShopDetailModel : NSObject

@property (nonatomic, copy) NSString *s_id; //店铺ID
@property (nonatomic, copy) NSString *merchant_id; //店铺ID 其他地方有可能用
@property (nonatomic, assign) BOOL is_collect; ////0未收藏  1已收藏
@property (nonatomic, copy) NSString *merchant_name;  //店铺名称
@property (nonatomic, copy) NSString *goods_num;  //商品数量
@property (nonatomic, copy) NSString *months_orders;  //月消单
@property (nonatomic, copy) NSString *focus_num;   //关注人数
@property (nonatomic, copy) NSString *open_time;   //营业时间
@property (nonatomic, copy) NSString *final_address; //地址
@property (nonatomic, copy) NSString *address; //简写地址
@property (nonatomic, copy) NSString *merchant_phone; //联系方式
@property (nonatomic, copy) NSString *logo;     //店铺logo
@property (nonatomic, assign) NSInteger user_id;  //隐藏部分内容
@property (nonatomic, assign) NSInteger  show_type;
@property (nonatomic, strong) NSArray *gallery;
@property (nonatomic, assign) float lat;  //纬度
@property (nonatomic, assign) float lng;  //经度
@property (nonatomic, assign) float gaode_lat;  //纬度
@property (nonatomic, assign) float gaode_lng;  //经度
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, strong) NSArray *other_license;      //商家资质
@property (nonatomic, copy) NSString *merchant_desc;     //分享内容
//多级映射
@property (nonatomic, copy) NSString *commentCount;      //评论数量
@property (nonatomic, copy) NSString *commentStar_cate;  //综合星级
@property (nonatomic, copy) NSArray *commentList;        //分享链接

//@property (nonatomic, assign) NSInteger months_orders;

@end

#pragma mark - 评论模型
@interface UBShopDetailCommentModel : NSObject

@property (nonatomic, copy) NSString *c_id;       //店铺ID
@property (nonatomic, copy) NSString *nickname;   //昵称
@property (nonatomic, copy) NSString *start_time; //创建时间
//@property (nonatomic, assign) NSInteger star;       //星级
@property (nonatomic, copy) NSString *head_pic;   //头像

//全部评论使用
@property (nonatomic, copy) NSString *environment;
@property (nonatomic, assign) NSInteger star;
@property (nonatomic, strong) UBShopDetailCommentModel *data;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSArray *picture;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *count; //全部评论数量


@end



@interface UBShopLicenseModel : NSObject

@property (nonatomic, copy) NSString *license_name;
@property (nonatomic, copy) NSString *license_pic;

@end
