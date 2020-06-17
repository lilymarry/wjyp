//
//  SgiftContentCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MySgiftContentDetailBtnBlock)();
@interface MySgiftContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_mingxi;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *create_timeLab;
@property (weak, nonatomic) IBOutlet UILabel *source_statusLab;
@property (weak, nonatomic) IBOutlet UILabel *leve_moneyLab;
@property (weak, nonatomic) IBOutlet UIImageView *leveLab;

@property (nonatomic, copy) MySgiftContentDetailBtnBlock MySgiftContentDetailBtn;

@end
