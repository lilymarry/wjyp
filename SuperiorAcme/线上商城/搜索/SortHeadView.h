//
//  SortHeadView.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sortBtnAction)(UIButton *btn,NSString *searchType,BOOL isPriceBtn);

@interface SortHeadView : UIView


//参数
//@property (nonatomic, copy) NSString *para_sort;   //积分 用券 销量 这些
@property (nonatomic, copy) NSString *para_fliter; //价格
@property (nonatomic, copy) NSString *para_order;  //从大到小 小到大

@property (nonatomic, copy) sortBtnAction sortBlock;

+(instancetype)instaceWithXIB;

+(CGFloat)barviewHeight;

-(void)otherViewSettingWithSuperView:(UIView *)superView
                  isContenNaviHeight:(BOOL)isContenNaviHeight;

@end
