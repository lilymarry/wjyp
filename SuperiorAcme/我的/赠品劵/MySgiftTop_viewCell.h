//
//  SgiftTop_viewCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MySgiftChangeMoneyBtnBlock)();
@interface MySgiftTop_viewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sumMoneylab;

@property (weak, nonatomic) IBOutlet UILabel *tittleLab;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UILabel *exchangeLab;
@property (weak, nonatomic) IBOutlet UILabel *tittleSubLab;

@property (nonatomic, copy) MySgiftChangeMoneyBtnBlock mySgiftChangeMoneyBtnBlock;

@end
