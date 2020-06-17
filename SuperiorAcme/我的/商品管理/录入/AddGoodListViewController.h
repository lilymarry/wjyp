//
//  AddGoodListViewController.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/13.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddGoodListViewDelegate <NSObject>
//刷新
-(void)refrechGoodListView;
@end
@interface AddGoodListViewController : UIViewController
@property ( strong ,nonatomic)NSString *goods_id;
@property ( strong ,nonatomic)NSString *sta_mid;
@property ( strong ,nonatomic)NSString *type;//录入1  商品详情2\3（3 待审核详情 隐藏按钮）
@property (nonatomic,weak)id <AddGoodListViewDelegate>  delgate;
@end

NS_ASSUME_NONNULL_END
