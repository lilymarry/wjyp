//
//  SUserUserAddress.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserUserAddressSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserUserAddressFailureBlock) (NSError * error);

@interface SUserUserAddress : NSObject
//需要传入用户token

@property (nonatomic, strong) SUserUserAddress * data;
@property (nonatomic, copy) NSString * source;//"来源", 1：Android 2：ios
@property (nonatomic, copy) NSArray * PerSondata;// [ { "name": "张三",    //姓名 "phone": "13688888888"//电话 }, { "name": "李四",    //姓名 "phone": "13866666666"//电话 } ] ,


- (void)SUserUserAddressSuccess:(SUserUserAddressSuccessBlock)success andFailure:(SUserUserAddressFailureBlock)failure;
@end
