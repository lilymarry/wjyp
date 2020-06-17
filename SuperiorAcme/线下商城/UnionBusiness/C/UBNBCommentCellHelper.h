//
//  UBNBCommentCellHelper.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBShopDetailModel.h"

@interface UBNBCommentCellHelper : NSObject

+(instancetype)helperWithModel:(UBShopDetailCommentModel *)model;

-(NSString *)c_id;
-(NSString *)nickname;
-(NSString *)start_time;
-(NSInteger )star;
-(NSString *)head_pic;

@end
