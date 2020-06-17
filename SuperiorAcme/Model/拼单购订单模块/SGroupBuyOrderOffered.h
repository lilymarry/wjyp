//
//  SGroupBuyOrderOffered.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyOrderOfferedSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGroupBuyOrderOfferedFailureBlock) (NSError * error);

@interface SGroupBuyOrderOffered : NSObject
@property (nonatomic, copy) NSString * group_buy_order_id;//    订单ID

@property (nonatomic, strong) SGroupBuyOrderOffered * data;
@property (nonatomic, copy) NSString * goods_name;//": "美式球形爆米花 香甜酥脆到爆 看片好伙伴 休闲零食小吃",//商品名称
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b9c3370d7.jpg",//封面图
@property (nonatomic, copy) NSString * shop_price;//": "26.60",//价格
@property (nonatomic, copy) NSString * already;//": "已团1件",//已团几件
@property (nonatomic, copy) NSString * number;//": "1人团",//几人团
@property (nonatomic, copy) NSString * colonel_head_pic;//": "http://www.tocolor.cn/Uploads/Goods/2016-12-01/583f0aa6dbe8f.jpg",//团长头像
@property (nonatomic, copy) NSString * status;//": "1", //0团未满 1团已满
@property (nonatomic, copy) NSString * m_short;//": "还差1人",//还差几人
@property (nonatomic, copy) NSString * is_colonel;//": "1",//1是团长0不是团长
@property (nonatomic, copy) NSString * is_member;//": "0"//1是团员 0不是团员

@property (nonatomic, copy) NSArray * head_pic;
@property (nonatomic, copy) NSString * pic;//": "http://www.tocolor.cn/Uploads/Goods/2016-12-01/583f0aa6dbe8f.jpg"

//参团说明
@property (nonatomic, copy) NSArray * offered;
@property (nonatomic, copy) NSString * oneself;//": "说明1"
/*
 *富文本属性,用于加载html内容
 */
@property (nonatomic, copy) NSAttributedString * attrOneself;

/*
 *增加拼团购倒计时属性
 */
@property (nonatomic, copy) NSString * end_time;//"截止时间"
@property (nonatomic, copy) NSString * end_true_time;//"延迟后截止时间（若无延迟，此时间等于截止时间）"
@property (nonatomic, copy) NSString * sys_time;//"系统参照时间"

/*
 *添加返回积分属性
 */
@property (nonatomic, copy) NSString * givenIntegral;


/*
 *根据内容获取cell的实际高度
 */
@property (nonatomic, assign) CGFloat CellHeight;

- (void)sGroupBuyOrderOfferedSuccess:(SGroupBuyOrderOfferedSuccessBlock)success andFailure:(SGroupBuyOrderOfferedFailureBlock)failure;
@end
