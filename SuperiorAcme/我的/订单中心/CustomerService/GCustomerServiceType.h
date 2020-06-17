//
//  GCustomerServiceType.h
//  SeaMonkey
//
//  Created by TXD_air on 16/10/31.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GCustomerServiceType_TypeBlock) (NSString * thisType, NSString * type_id);

@interface GCustomerServiceType : UIViewController
@property (nonatomic, assign) NSInteger type;//0售后类型 1货物状态 2原因

//0售后类型的数组
@property (nonatomic, copy) NSArray * modelArr;
@property (nonatomic, copy) NSArray * modelBrr;

@property (nonatomic, copy) GCustomerServiceType_TypeBlock GCustomerServiceType_Type;
@end
