//
//  SelectResult.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UidBlock)(NSString * name,NSString *uid);
@interface SelectResult : UIViewController
@property ( strong ,nonatomic)NSString *sta_mid;
@property ( strong ,nonatomic)NSString *cate_id;
@property ( strong ,nonatomic)NSString *city_id;
@property ( strong ,nonatomic)NSString *type;//1 查询 2 店主列表
@property (nonatomic, copy) UidBlock uidBlock;

@end

NS_ASSUME_NONNULL_END
