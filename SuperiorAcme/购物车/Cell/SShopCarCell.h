//
//  SShopCarCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SShopCarCell;
@protocol SShopCarCellDelegate <NSObject>
@optional
- (void)leftCell:(SShopCarCell *)cell leftBtn:(UIButton *)btn;
- (void)rightCell:(SShopCarCell *)cell rightBtn:(UIButton *)btn;
- (void)editCell:(SShopCarCell *)cell editBtn:(UIButton *)btn;
- (void)RBtnCell:(SShopCarCell *)cell RBtn:(UIButton *)btn;
- (void)editNumCell:(SShopCarCell *)cell editNumTF:(UITextField *)numTF;
@end

@interface SShopCarCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *editView;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;

@property (strong, nonatomic) IBOutlet UIImageView *goods_img;
@property (strong, nonatomic) IBOutlet UILabel *goods_name;
@property (strong, nonatomic) IBOutlet UILabel *attr_group;
@property (strong, nonatomic) IBOutlet UILabel *shop_price;
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UITextField *numTF;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UILabel *attr_group_edit;

@property (nonatomic, weak) id<SShopCarCellDelegate>delegate;
@property (strong, nonatomic) IBOutlet UIButton *RBtn;
@end
