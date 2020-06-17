//
//  AddGoodList_headCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/13.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddGoodList_headCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *tangshiBtn;
@property (strong, nonatomic) IBOutlet UIButton *waimaiBtn;
@property (strong, nonatomic) IBOutlet UIButton *allBtn;


@property (strong, nonatomic) IBOutlet UITextField *nameTextField;//商品名称
@property (strong, nonatomic) IBOutlet UILabel *cate_nameLab;//分类名称
@property (strong, nonatomic) IBOutlet UIButton *cate_nameBtn;
@property (strong, nonatomic) IBOutlet UITextField *limitTf;





@property (strong, nonatomic) IBOutlet UITextField *shop_priceTextField;//外卖价格
@property (strong, nonatomic) IBOutlet UITextField *shop_jiesuan_priceTextField;//外卖结算价
@property (strong, nonatomic) IBOutlet UITextField *church_shop_priceTextField;//堂食价格
@property (strong, nonatomic) IBOutlet UITextField *church_jiesuan_shop_priceTextField;//堂食结算价格

@property (strong, nonatomic) IBOutlet UITextField *boxwareTextField;////餐盒数量

@property (strong, nonatomic) IBOutlet UIView *boxwareView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *boxwareViewHHH;


@property (strong, nonatomic) IBOutlet UILabel *attr_nameLab;////规格


@property (strong, nonatomic) IBOutlet UIButton *attr_nameBtn;



@property (strong, nonatomic) IBOutlet UIView *headView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shop_priceTextFieldHHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shop_jiesuan_priceTextFieldHHH;//外卖结算价
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *church_shop_priceTextFieldHHH;//堂食价格
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *church_jiesuan_shop_priceTextFieldHHH;//堂食结算价格

@property (strong, nonatomic) IBOutlet UIView *shop_priceTextFieldView;
@property (strong, nonatomic) IBOutlet UIView *shop_jiesuan_priceTextFieldView;//外卖结算价
@property (strong, nonatomic) IBOutlet UIView *church_shop_priceTextFieldView;//堂食价格
@property (strong, nonatomic) IBOutlet UIView *church_jiesuan_shop_priceTextFieldView;//堂食结算价格


@property (strong, nonatomic) IBOutlet UIView *sellNumView;//已售数量
@property (strong, nonatomic) IBOutlet UITextField *sellNumTextFeild;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sellNumViewHHH;


@property (strong, nonatomic) IBOutlet UIView *numView;//库存数量
@property (strong, nonatomic) IBOutlet UITextField *numTextFeild;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numViewHHH;


@end

NS_ASSUME_NONNULL_END
