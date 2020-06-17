//
//  CommonMoreView.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "CommonMoreView.h"

@implementation CommonMoreView
- (IBAction)backEvent:(id)sender {
    self.closeMoreView();
}
- (IBAction)btnPushEvent:(id)sender {
    UIButton * btn = (UIButton *)sender;
    NSInteger _tag = btn.tag;
    UIViewController * vc;
    switch (_tag) {
        case 1:
            {
                #pragma mark - 无界商店
//                STicketFight * fight = [[STicketFight alloc] init];
//                fight.type = @"3";
//                vc = fight;
                
                SCarShop * car = [[SCarShop alloc] init];
                vc = car;
            }
            break;
        case 2:
            {
                #pragma mark - 福利社
                SWelfareAgency * agency = [[SWelfareAgency alloc] init];
                vc = agency;
            }
            break;
        case 3:
            {
                #pragma mark - 上市孵化
                SListedIncubation * listed = [[SListedIncubation alloc] init];
                vc = listed;
            }
            break;
        case 4:
            {
                
            }
            break;
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    self.moreBtnBlock(vc);
}
@end
