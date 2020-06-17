//
//  SOrderConfirm_footer.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/8.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderConfirm_footer : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UILabel *sendTitle;
@property (weak, nonatomic) IBOutlet UILabel *sendType;

@property (weak, nonatomic) IBOutlet UIView *invoiceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *invoiceView_HHH;
@property (weak, nonatomic) IBOutlet UIButton *invoiceBtn;
@property (weak, nonatomic) IBOutlet UILabel *thisType;


@property (weak, nonatomic) IBOutlet UIView *serviceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *after_sale_service;

@property (weak, nonatomic) IBOutlet UIView *welfareView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *welfareView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *welfare;

@property (weak, nonatomic) IBOutlet UIView *integrity_aView;
@property (weak, nonatomic) IBOutlet UILabel *integrity_a;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *integrity_aViewHHH;

@property (weak, nonatomic) IBOutlet UIView *integrity_bView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *integrity_bView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *integrity_b;

@property (weak, nonatomic) IBOutlet UIView *integrity_cView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *integrity_cView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *integrity_c;

@end
