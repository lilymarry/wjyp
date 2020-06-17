//
//  UBNearByShopDiscountTicketCell.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBNearByShopDiscountTicketCell.h"
#import "SOffLineNearbyStoreListModel.h"

@interface UBNearByShopDiscountTicketCell ()


@end

@implementation UBNearByShopDiscountTicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.discountTicketTipLabel.layer.cornerRadius = 3;
    self.discountTicketTipLabel.layer.masksToBounds = YES;

}


-(void)setNearByStoreTikcetModel:(SOffLineNearbyStoreListModel *)nearByStoreTikcetModel{

    _nearByStoreTikcetModel = nearByStoreTikcetModel;
 
    if (_discountTicketTipLabel.hidden==NO) {
    if ([nearByStoreTikcetModel.type isEqualToString:@"1"]) {//红券
        self.discountTicketTipLabel.backgroundColor = [UIColor colorWithRed:249.0/255 green:4.0/255 blue:1.0/255 alpha:1];
        self.showMoreDiscountTicketBtn.hidden = NO;
    }else if ([nearByStoreTikcetModel.type isEqualToString:@"2"]){//黄券
        self.discountTicketTipLabel.backgroundColor = [UIColor colorWithRed:253.0/255 green:128.0/255 blue:2.0/255 alpha:1];
        self.showMoreDiscountTicketBtn.hidden = YES;
    }else if ([nearByStoreTikcetModel.type isEqualToString:@"3"]){//蓝券
        self.discountTicketTipLabel.backgroundColor = [UIColor colorWithRed:89.0/255 green:159.0/255 blue:247.0/255 alpha:1];
        self.showMoreDiscountTicketBtn.hidden = YES;
    }
    }
    if ( self.aviliableDiscountTicketLabel.hidden==NO) {
         self.aviliableDiscountTicketLabel.text = nearByStoreTikcetModel.discount_desc;
    }
    if (self.showMoreDiscountTicketBtn.hidden==NO) {
         self.showMoreDiscountTicketBtn.selected = nearByStoreTikcetModel.isClick;
    }

}

- (IBAction)showMoreDistcountTicket:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.ShowMoreDiscountTicketBlock) {
        self.ShowMoreDiscountTicketBlock(sender.selected);
    }
}

+(void)xibWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:[UBNearByShopDiscountTicketCell cellIdentifer] bundle:nil]
    forCellReuseIdentifier:[UBNearByShopDiscountTicketCell cellIdentifer]];
}

+(NSString *)cellIdentifer{
    return NSStringFromClass([self class]);
}

@end
