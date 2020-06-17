//
//  GoodsManagerItemList.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/23.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^finishBlock)(NSString *names,NSString *uids);
@protocol refrechtViewDelegate <NSObject>
//刷新
-(void)refrechtView:(NSString *)itemId name:(NSString *)name;
@end
@interface GoodsManagerItemList : UIViewController

@property ( strong ,nonatomic)NSString *type;//1 分类移动 2分类管理 3录入商品
@property ( strong ,nonatomic)NSString *sta_mid;
@property ( strong ,nonatomic)NSArray *goods_idArr;
@property (nonatomic,weak)id <refrechtViewDelegate>  delgate;

@property(nonatomic,copy) finishBlock block;
-(id)initWithBlock:(finishBlock)ablock;

@end

NS_ASSUME_NONNULL_END
