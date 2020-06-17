//
//  MemberExchangModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^MemberExchangModelSuccessBlock) (NSString * code, NSString * message, id data,NSString * num);


typedef void (^MemberExchangModelFailureBlock) (NSError * error);


@interface MemberExchangModel : NSObject
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * sta_mid;

@property (nonatomic, copy) NSString * shopkeeper_id;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * member_coding;
@property (nonatomic, copy) NSString * city_id;
@property (nonatomic, copy) NSString * cid;
@property (nonatomic, copy) NSString * flag;//区分标注

@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * c_id;


- (void)MemberExchangModelSuccess:(MemberExchangModelSuccessBlock)success andFailure:(MemberExchangModelFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
