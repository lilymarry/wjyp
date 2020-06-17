//
//  SlineDetailWebModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/11/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SlineDetailWebModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SlineDetailWebModelFailureBlock) (NSError * error);
@interface SlineDetailWebModel : NSObject
@property (nonatomic, copy) NSString * save_path;//    汽车购ID    否    文本    1
@property (nonatomic, copy) NSArray * ImagesAndNames;//
@property (nonatomic, copy) NSString * keyName;//

- (void)SlineDetailWebModelSuccess:(SlineDetailWebModelSuccessBlock)success andFailure:(SlineDetailWebModelFailureBlock)failure;
@end
