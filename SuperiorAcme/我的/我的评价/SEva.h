//
//  SEva.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEva : UIViewController
@property (nonatomic, assign) BOOL type;//NO我的评价 YES商家评价（商品评价）
@property (nonatomic, copy) NSString * merchant_id;//商家店铺id
@property (nonatomic, copy) NSString * goods_id;//商品ud
@end
