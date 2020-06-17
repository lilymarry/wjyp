//
//  SOrderInfor_footer.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderInfor_footer : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UILabel *order_num;
@property (strong, nonatomic) IBOutlet UILabel *order_price;
@property (weak, nonatomic) IBOutlet UILabel *freight;

@end
