//
//  WAUserCenterModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WAUserCenterModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^WAUserCenterModelFailureBlock) (NSError * error);

@interface WAUserCenterModel : NSObject
@property (nonatomic, strong) WAUserCenterModel * data;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * head_pic;
@property (nonatomic, copy) NSString * chance_num;
@property (nonatomic, copy) NSString * my_catcher_num;
- (void)WAUserCenterModelSuccess:(WAUserCenterModelSuccessBlock)success andFailure:(WAUserCenterModelFailureBlock)failure;



@end

NS_ASSUME_NONNULL_END
