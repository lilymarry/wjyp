//
//  SComRecom_listInfor_Top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SComRecom_listInfor_Top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIImageView *lineImage;

@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *desc;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *range_id;
@property (weak, nonatomic) IBOutlet UILabel *link_man;
@property (strong, nonatomic) IBOutlet UILabel *job;
@property (strong, nonatomic) IBOutlet UILabel *link_phone;
@property (strong, nonatomic) IBOutlet UILabel *tmail_url;
@property (strong, nonatomic) IBOutlet UILabel *jd_url;
@property (weak, nonatomic) IBOutlet UILabel *other_url;
@property (strong, nonatomic) IBOutlet UILabel *product_desc;
@property (strong, nonatomic) IBOutlet UILabel *create_time;
@end
