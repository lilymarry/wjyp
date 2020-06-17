//
//  SOrderManagementCell_sub3.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/9/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyYellowModel.h"
typedef void(^wuliuBtnBlock)();
@protocol YellowDegreeCellDelegate <NSObject>

-(void)degreeBtnClick:(ApplyYellowModel *)model andtxf:(NSString *)text ticket_line:(NSString *)ticket_line ;
-(void)disgreeBtnClick:(ApplyYellowModel *)model andtxf:(NSString *)text ticket_line:(NSString *)ticket_line;

@end
@interface SOrderManagementCell_sub3 : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_maijia;
@property (weak, nonatomic) IBOutlet UILabel *lab_gongyingshang;
@property (weak, nonatomic) IBOutlet UILabel *lab_shouyi;
@property (weak, nonatomic) IBOutlet UILabel *lab_yongjuan;
@property (weak, nonatomic) IBOutlet UILabel *lab_yongjuanbi;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UIImageView *imaView_flag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHHH;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UITextField *tf_huangJuanNum;
@property (weak, nonatomic) IBOutlet UIButton *degreeBtn;

@property (weak, nonatomic) IBOutlet UIButton *disgreeBtn;
@property (strong ,nonatomic)NSString *ticket_lines;
@property (strong,nonatomic)ApplyYellowModel *model;
@property (weak,nonatomic) id<YellowDegreeCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lab_ticket_line;
@property (weak, nonatomic) IBOutlet UILabel *lab_yongjuanTittle;
@property (weak, nonatomic) IBOutlet UILabel *lab_yongjuanbiTittle;

@property (weak, nonatomic) IBOutlet UIButton *wuliuBtn;
@property (nonatomic, copy) wuliuBtnBlock wuliuBlock;




@end
