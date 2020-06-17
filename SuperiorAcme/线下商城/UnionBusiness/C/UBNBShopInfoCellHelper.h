//
//  UBNBShopInfoCellHelper.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBShopDetailModel.h"

@interface UBNBShopInfoCellHelper : NSObject

@property (nonatomic,strong)NSMutableArray *lookAndReports;

@property (nonatomic,strong)NSMutableArray *shopInfos;

+(instancetype)helperWithModel:(UBShopDetailModel *)model;

//额外数据
- (NSInteger)user_id;
//额外数据

-(NSString *)goodsNumStr;

-(NSString *)months_ordersStr;

-(NSString *)focus_numStr;

-(NSString *)open_timeStr;

-(NSString *)final_addressStr;

-(NSString *)merchant_descStr;

- (NSString *)addressStr;

-(NSDictionary *)goodsDic;
-(NSDictionary *)months_ordersDic;
-(NSDictionary *)focus_numDic;
-(NSDictionary *)open_timeDic;
-(NSDictionary *)final_addressDic;
-(NSDictionary *)merchant_phoneDic;
-(NSDictionary *)merchant_descDic;

- (NSString *)months_orders;


@end
