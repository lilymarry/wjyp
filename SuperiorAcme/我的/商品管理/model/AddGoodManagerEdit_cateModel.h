//
//  AddGoodManagerEdit_cateModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddGoodManagerEdit_cateModelSuccessBlock) (NSString * code, NSString * message);
typedef void (^AddGoodManagerEdit_cateModelFailureBlock) (NSError * error);
@interface AddGoodManagerEdit_cateModel : NSObject
@property (nonatomic, copy) NSString * id;

@property (nonatomic, copy) NSString * is_del;

@property (nonatomic, copy) NSString * name;


@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * sort;

@property (nonatomic, copy) NSString * sta_mid;


- (void)AddGoodManagerEdit_cateModelSuccess:(AddGoodManagerEdit_cateModelSuccessBlock)success andFailure:(AddGoodManagerEdit_cateModelFailureBlock)failure;



@end

NS_ASSUME_NONNULL_END
