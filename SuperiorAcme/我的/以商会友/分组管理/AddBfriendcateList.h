//
//  AddBfriendcateList.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RefrechCateBlock)();
@interface AddBfriendcateList : UIViewController
@property ( strong ,nonatomic)NSString *sta_mid;
@property ( strong ,nonatomic)NSString *idstr;
@property (nonatomic, copy) RefrechCateBlock refrechBlock;
@end

NS_ASSUME_NONNULL_END
