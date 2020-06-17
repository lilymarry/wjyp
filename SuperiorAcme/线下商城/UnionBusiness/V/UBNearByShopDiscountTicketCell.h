//
//  UBNearByShopDiscountTicketCell.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SOffLineNearbyStoreListModel;
@interface UBNearByShopDiscountTicketCell : UITableViewCell
@property (nonatomic, strong) SOffLineNearbyStoreListModel * nearByStoreTikcetModel;
@property (nonatomic, copy) void(^ShowMoreDiscountTicketBlock)(BOOL);


+(void)xibWithTableView:(UITableView *)tableView;
+(NSString *)cellIdentifer;
@property (weak, nonatomic) IBOutlet UILabel *aviliableDiscountTicketLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountTicketTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *showMoreDiscountTicketBtn;
@end
