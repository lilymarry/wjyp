//
//  SSetShopNameCell.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextFieldEndEditBlock)(NSString * text);

@interface SSetShopNameCell : UITableViewCell 
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) NSString * shopName;
@property (nonatomic, copy) TextFieldEndEditBlock  textFieldEndEditBlock;

@end
