//
//  Specs_nameDetail.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/20.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^Specs_nameDetailFinishBlock)(NSArray *arr);
@interface Specs_nameDetail : UIViewController
@property ( strong ,nonatomic)NSString *goods_id;
@property ( strong ,nonatomic)NSMutableArray *arr;
@property ( strong ,nonatomic)NSString *sta_mid;
@property(nonatomic,copy) Specs_nameDetailFinishBlock block;
-(id)initWithBlock:(Specs_nameDetailFinishBlock)ablock;
@end

NS_ASSUME_NONNULL_END
