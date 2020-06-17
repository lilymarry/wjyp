//
//  SCarShop_sub.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCarShop_sub : UIViewController
@property (nonatomic, copy) NSString * min_price;//价格最小不能为0 单位为元
@property (nonatomic, copy) NSString * max_price;//价格最大值
@property (nonatomic, copy) NSString * style_id;//车型id(默认不限)
@property (nonatomic, copy) NSString * brand_id;//品牌id(默认不限)
@end
