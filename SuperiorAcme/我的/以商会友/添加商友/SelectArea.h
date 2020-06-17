//
//  SelectArea.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectAreaBlock)(NSString * sex,NSString *age,NSString * member_coding,NSString *city_id);
@interface SelectArea : UIViewController
@property ( strong ,nonatomic)NSString *sta_mid;
@property ( strong ,nonatomic)NSArray *cate_dataArr;
@property ( strong ,nonatomic)NSString *type;// 1 按条件查找 2 会员互换 3 设置互换条件
@property (nonatomic, copy) SelectAreaBlock selectAreaBlock;
@end

NS_ASSUME_NONNULL_END
