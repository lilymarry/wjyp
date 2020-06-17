//
//  UBNearByShopCell.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SOffLineNearbyStoreListModel;

@interface UBNearByShopCell : UITableViewCell

@property (nonatomic, strong) SOffLineNearbyStoreListModel * nearByStoreModel;

@property (weak, nonatomic) IBOutlet UIButton *choiceBtn;

+(void)xibWithTableView:(UITableView *)tableView;
+(NSString *)cellIdentifer;

@end
