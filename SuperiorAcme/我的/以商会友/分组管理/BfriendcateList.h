//
//  Bfriend_cateList.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^GetCateIdBlock)(NSString *cate_id,NSString * cata_name);
@interface BfriendcateList : UIViewController
@property ( strong ,nonatomic)NSString *sta_mid;
@property ( strong ,nonatomic)NSString *type;//选择cate 1
@property (nonatomic, copy) GetCateIdBlock getCateIdBlock;
@end

NS_ASSUME_NONNULL_END
