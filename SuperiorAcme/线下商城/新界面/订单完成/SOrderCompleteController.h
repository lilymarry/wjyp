//
//  SOrderCompleteController.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderCompleteController : UIViewController

@property (nonatomic, assign) BOOL isPopRootVC;     //区分是不是订单页进来的调用这个
                                                    //目前是线下商铺
@property (nonatomic, copy) NSString *order_id;

@end
