//
//  SAM_Recommend.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAM_Recommend : UIViewController
@property (nonatomic, assign) BOOL isno;//NO联盟商家推荐 YES申请联盟商家
@property (nonatomic, assign) BOOL showModel_isno;//YES展示数据
@property (nonatomic, assign) BOOL left_right;//NO左，YES右
@property (nonatomic, copy) NSString * recommending_id;//联盟商家推荐id;
@property (nonatomic, copy) NSString * status;//（0.1->审核中，2，3->审核拒绝，4->待入驻 5 入驻失败 6 入驻成功 7.入驻中）
    //status == 2 ，3 ，5 有拒绝原因
@end
