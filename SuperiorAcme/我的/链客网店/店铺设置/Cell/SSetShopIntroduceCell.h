//
//  SSetShopIntroduceCell.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextViewEditEndBlock)(NSString * text);

@interface SSetShopIntroduceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) NSString * shopDesc;
@property (nonatomic, copy) TextViewEditEndBlock  textViewEndEditBlock;

@end
