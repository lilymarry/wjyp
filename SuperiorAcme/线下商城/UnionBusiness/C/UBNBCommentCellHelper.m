//
//  UBNBCommentCellHelper.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBNBCommentCellHelper.h"

@interface UBNBCommentCellHelper()

@property (nonatomic, strong) UBShopDetailCommentModel *model;

@end

@implementation UBNBCommentCellHelper

+(instancetype)helperWithModel:(UBShopDetailCommentModel *)model{
    UBNBCommentCellHelper *helper = [UBNBCommentCellHelper new];
    helper.model = model;
    return helper;
}

-(NSString *)c_id{
    return self.model.c_id;
}
-(NSString *)nickname{
    return self.model.nickname;
}
-(NSString *)start_time{
    return self.model.start_time;
}
-(NSInteger)star{
    return self.model.star;
}
-(NSString *)head_pic{
    return self.model.head_pic;
}



@end
