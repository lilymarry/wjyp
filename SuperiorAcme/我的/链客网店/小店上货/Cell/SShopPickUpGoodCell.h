//
//  SShopPickUpGoodCell.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/8.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SShopPickUpModel;
@class SShopPickUpGoodCell;

@protocol SShopPickUpGoodCellDelegate <NSObject>

//上架商品点击方法
-(void)putawayGoodsBtnClick:(SShopPickUpGoodCell *)cell andIndex:(NSIndexPath *)index;

@end

@interface SShopPickUpGoodCell : UITableViewCell

/**
 上架商品的模型
 */
@property (nonatomic, strong) SShopPickUpModel * pickUpModel;

@property (weak,nonatomic) id<SShopPickUpGoodCellDelegate> delegate;
@property (weak, nonatomic) NSIndexPath *  index;
@end
