//
//  SEB_VoucherMine_Content.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEB_VoucherMine_Content : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UITableView *mTable;

- (void)show:(NSString *)type;
@end
