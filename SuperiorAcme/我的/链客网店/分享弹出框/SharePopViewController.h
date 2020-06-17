//
//  SharePopViewController.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGoodManagementModel.h"
@interface SharePopViewController : UIViewController
@property(strong ,nonatomic)SGoodManagementModel *mode;
@property(strong ,nonatomic)NSString  *goodsName;
@property(strong ,nonatomic)NSString  *share_content;
@property(strong ,nonatomic)NSString  *share_img;
@property(strong ,nonatomic)NSString  *share_url;

@property(strong ,nonatomic)NSString  *fag;//链客网店-商品管理2  线下商城1  链客网店-分享店铺 3
@property(strong ,nonatomic)NSString  *goods_id;
@property(strong ,nonatomic)NSString  *shopidMing;

@property(strong ,nonatomic)NSString  *share_type;

@end
