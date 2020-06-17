//
//  SShopSettingController.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol refrechUserSetViewDelegate <NSObject>

//上架商品点击方法
-(void)refrechUserSetView;

@end
@interface SShopSettingController : UIViewController

@property (nonatomic, copy) NSString * shopName;
@property (nonatomic, copy) NSString * shopDesc;
@property (nonatomic, copy) NSString * shopPicUrl;
@property (nonatomic ,copy) NSString *shopId;
@property (nonatomic, copy) NSString * shopTime;

@property (nonatomic,weak)id <refrechUserSetViewDelegate>  delgate;
@end
