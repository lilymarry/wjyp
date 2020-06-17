//
//  AddAttr_name.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/14.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^AddAttr_nameFinishBlock)(NSArray *arr);
@interface AddAttr_name : UIViewController
@property(nonatomic,copy) AddAttr_nameFinishBlock block;
-(id)initWithBlock:(AddAttr_nameFinishBlock)ablock;
@property(nonatomic,strong) NSMutableArray *arr;
@property(nonatomic,strong) NSString *goods_id;
@property ( strong ,nonatomic)NSString *sta_mid;

@property ( strong ,nonatomic)NSString *MerchantCate;

@end

NS_ASSUME_NONNULL_END
