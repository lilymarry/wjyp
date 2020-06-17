//
//  SPromotion_OPEN.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPromotion_OPEN.h"
#import "SPromotion_OPENCell.h"
#import "SGoodsGoodsInfo.h"//普通商品详情、票券区
#import "SLimitBuyLimitBuyInfo.h"//限量购
#import "SGroupBuyGroupBuyInfo.h"//拼单购
#import "SPreBuyPreBuyInfo.h"//无界预购
#import "SIntegralBuyIntegralBuyInfo.h"//无界商店
#import "SAuctionAuctionInfo.h"//比价购
#import "SPromotion_OPENCell_dj.h"
#import "SPromotion_OPEN_footer.h"

@interface SPromotion_OPEN () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * thisArr;
    NSString * thisType;
    NSString * thisClassType;//促销、代金券
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SPromotion_OPEN

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_mTable registerNib:[UINib nibWithNibName:@"SPromotion_OPENCell_dj" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SPromotion_OPENCell_dj"];
    [_mTable registerNib:[UINib nibWithNibName:@"SPromotion_OPENCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SPromotion_OPENCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)showModel:(NSArray *)arr andType:(NSString *)type andClassType:(NSString *)classType andTypeContent:(NSString *)content {
    thisArr = arr;
    thisType = type;
    thisClassType = classType;
    if ([classType isEqualToString:@"代金券"]) {
        CGSize size = [content boundingRectWithSize:CGSizeMake(ScreenW - 60, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        SPromotion_OPEN_footer * footer = [[SPromotion_OPEN_footer alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50 + size.height + 10 + 50)];
        _mTable.tableFooterView = footer;
        footer.thiscontent.text = content;
        
    }
    [_mTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return thisArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([thisClassType isEqualToString:@"代金券"]) {
        SPromotion_OPENCell_dj * cell = [tableView dequeueReusableCellWithIdentifier:@"SPromotion_OPENCell_dj" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (thisType == nil) {
            SGoodsGoodsInfo * infor = thisArr[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                cell.redR.backgroundColor = [UIColor redColor];
            }
            if ([infor.type isEqualToString:@"2"]) {
                cell.redR.backgroundColor = [UIColor orangeColor];
            }
            if ([infor.type isEqualToString:@"3"]) {
                cell.redR.backgroundColor = MyBlue;
            }
            cell.discount_desc.text = infor.discount_desc;
        }
        if ([thisType isEqualToString:@"限量购"]) {
            SLimitBuyLimitBuyInfo  * infor = thisArr[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                cell.redR.backgroundColor = [UIColor redColor];
            }
            if ([infor.type isEqualToString:@"2"]) {
                cell.redR.backgroundColor = [UIColor orangeColor];
            }
            if ([infor.type isEqualToString:@"3"]) {
                cell.redR.backgroundColor = MyBlue;
            }
            cell.discount_desc.text = infor.discount_desc;
        }
        if ([thisType isEqualToString:@"拼单购"]) {
            SGroupBuyGroupBuyInfo  * infor = thisArr[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                cell.redR.backgroundColor = [UIColor redColor];
            }
            if ([infor.type isEqualToString:@"2"]) {
                cell.redR.backgroundColor = [UIColor orangeColor];
            }
            if ([infor.type isEqualToString:@"3"]) {
                cell.redR.backgroundColor = MyBlue;
            }
            cell.discount_desc.text = infor.discount_desc;
        }
        if ([thisType isEqualToString:@"无界预购"]) {
            SPreBuyPreBuyInfo  * infor = thisArr[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                cell.redR.backgroundColor = [UIColor redColor];
            }
            if ([infor.type isEqualToString:@"2"]) {
                cell.redR.backgroundColor = [UIColor orangeColor];
            }
            if ([infor.type isEqualToString:@"3"]) {
                cell.redR.backgroundColor = MyBlue;
            }
            cell.discount_desc.text = infor.discount_desc;
        }
        if ([thisType isEqualToString:@"无界商店"]) {
            SIntegralBuyIntegralBuyInfo  * infor = thisArr[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                cell.redR.backgroundColor = [UIColor redColor];
            }
            if ([infor.type isEqualToString:@"2"]) {
                cell.redR.backgroundColor = [UIColor orangeColor];
            }
            if ([infor.type isEqualToString:@"3"]) {
                cell.redR.backgroundColor = MyBlue;
            }
            cell.discount_desc.text = infor.discount_desc;
        }
        if ([thisType isEqualToString:@"比价购"]) {
            SAuctionAuctionInfo  * infor = thisArr[indexPath.row];
            if ([infor.type isEqualToString:@"1"]) {
                cell.redR.backgroundColor = [UIColor redColor];
            }
            if ([infor.type isEqualToString:@"2"]) {
                cell.redR.backgroundColor = [UIColor orangeColor];
            }
            if ([infor.type isEqualToString:@"3"]) {
                cell.redR.backgroundColor = MyBlue;
            }
            cell.discount_desc.text = infor.discount_desc;
        }
        return cell;
    }
    
    SPromotion_OPENCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SPromotion_OPENCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (thisType == nil) {
        SGoodsGoodsInfo * infor = thisArr[indexPath.row];
        if ([infor.type isEqualToString:@"1"]) {
            cell.blueR.backgroundColor = MyBlue;
            cell.blueR.text = @"满减";
        } else {
            cell.blueR.backgroundColor = MyPowder;
            cell.blueR.text = @"满折";
        }
        cell.thisTitle.text = infor.title;
    }
    if ([thisType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * infor = thisArr[indexPath.row];
        if ([infor.type isEqualToString:@"1"]) {
            cell.blueR.backgroundColor = MyBlue;
            cell.blueR.text = @"满减";
        } else {
            cell.blueR.backgroundColor = MyPowder;
            cell.blueR.text = @"满折";
        }
        cell.thisTitle.text = infor.title;
    }
    if ([thisType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo * infor = thisArr[indexPath.row];
        if ([infor.type isEqualToString:@"1"]) {
            cell.blueR.backgroundColor = MyBlue;
            cell.blueR.text = @"满减";
        } else {
            cell.blueR.backgroundColor = MyPowder;
            cell.blueR.text = @"满折";
        }
        cell.thisTitle.text = infor.title;
    }
    if ([thisType isEqualToString:@"无界预购"]) {
        SPreBuyPreBuyInfo * infor = thisArr[indexPath.row];
        if ([infor.type isEqualToString:@"1"]) {
            cell.blueR.backgroundColor = MyBlue;
            cell.blueR.text = @"满减";
        } else {
            cell.blueR.backgroundColor = MyPowder;
            cell.blueR.text = @"满折";
        }
        cell.thisTitle.text = infor.title;
    }
    if ([thisType isEqualToString:@"无界商店"]) {
        SIntegralBuyIntegralBuyInfo * infor = thisArr[indexPath.row];
        if ([infor.type isEqualToString:@"1"]) {
            cell.blueR.backgroundColor = MyBlue;
            cell.blueR.text = @"满减";
        } else {
            cell.blueR.backgroundColor = MyPowder;
            cell.blueR.text = @"满折";
        }
        cell.thisTitle.text = infor.title;
    }
    
    return cell;
}
- (IBAction)backBtn:(UIButton *)sender {
    if (self.SPromotion_OPEN_Back) {
        self.SPromotion_OPEN_Back();
    }
}
@end
