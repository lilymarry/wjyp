//
//  UBNBShopInfoCellHelper.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBNBShopInfoCellHelper.h"

@interface UBNBShopInfoCellHelper()

@property (nonatomic, strong) UBShopDetailModel *model;

@end

@implementation UBNBShopInfoCellHelper

+(instancetype)helperWithModel:(UBShopDetailModel *)model{
    UBNBShopInfoCellHelper *helper = [UBNBShopInfoCellHelper new];
    helper.model = model;
    return helper;
}

-(NSString *)goodsNumStr{
    return [NSString stringWithFormat:@"%@件",self.model.goods_num];
}

-(NSDictionary *)goodsDic{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.goodsNumStr,@"message",@"商品数量：",@"title", nil];
}

-(NSString *)months_ordersStr{
    return [NSString stringWithFormat:@"%@单",self.model.months_orders];
}

-(NSDictionary *)months_ordersDic{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.months_ordersStr,@"message",@"月销单量：",@"title", nil];
}

-(NSString *)focus_numStr{
    return [NSString stringWithFormat:@"%@人",self.model.focus_num];
}

-(NSDictionary *)focus_numDic{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.focus_numStr,@"message",@"关注人数：",@"title", nil];
}

-(NSString *)open_timeStr{
    return [NSString stringWithFormat:@"%@",self.model.open_time];
}

-(NSDictionary *)open_timeDic{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.open_timeStr,@"message",@"营业时间：",@"title", nil];
}

-(NSString *)final_addressStr{
    return [NSString stringWithFormat:@"%@",self.model.final_address];
}

-(NSDictionary *)final_addressDic{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.final_addressStr,@"message",@"门店地址：",@"title", nil];
}

-(NSString *)merchant_phoneStr{
    return [NSString stringWithFormat:@"%@",self.model.merchant_phone];
}

-(NSDictionary *)merchant_phoneDic{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.merchant_phoneStr,@"message",@"门店电话：",@"title", nil];
}

-(NSString *)merchant_descStr{
    return [NSString stringWithFormat:@"%@",self.model.merchant_desc];
}

-(NSDictionary *)merchant_descDic{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.merchant_descStr,@"message",@"门店描述: ",@"title", nil];
}

- (NSString *)addressStr{
    return self.model.address;
}

- (NSInteger)user_id{
    return self.model.user_id;
}
- (NSString *)months_orders
{
     return self.model. months_orders;
}

-(NSMutableArray *)shopInfos{
    if (!_shopInfos) {
        _shopInfos = [NSMutableArray array];
        if((self.model.user_id > 0) && (![self.model.goods_num isEqualToString:@"0"]))
        {
            [_shopInfos addObject:self.goodsDic];//商品数量
        }
        
        if (SWNOTEmptyStr(self.model.months_orders)) {
        
            if ([self.model.months_orders intValue] >0) {
                [_shopInfos addObject:self.months_ordersDic];
            }
          
        }
        
        if (SWNOTEmptyStr(self.model.focus_num)) {
            [_shopInfos addObject:self.focus_numDic];
        }
        
        if (SWNOTEmptyStr(self.model.open_time)) {
            [_shopInfos addObject:self.open_timeDic];
        }
        
        if (SWNOTEmptyStr(self.model.final_address)) {
            [_shopInfos addObject:self.final_addressDic];
        }
        
        if (SWNOTEmptyStr(self.model.merchant_phone)) {
            [_shopInfos addObject:self.merchant_phoneDic];
        }
        
        if (SWNOTEmptyStr(self.model.merchant_desc)) {
            [_shopInfos addObject:self.merchant_descDic];
        }
    }
    return _shopInfos;
}

-(NSMutableArray *)lookAndReports{
    if (!_lookAndReports) {
        _lookAndReports = [NSMutableArray array];
        if (self.model.user_id > 0) {
            [_lookAndReports addObject:@"查看商家资质"];
            [_lookAndReports addObject:@"举报商家得红包"];
        }
        if(SWNOTEmptyStr(self.model.address)){
            [_lookAndReports addObject:self.model.address];
        }
    }
    return _lookAndReports;
}





@end
