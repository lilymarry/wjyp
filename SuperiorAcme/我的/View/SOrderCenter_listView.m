//
//  SOrderCenter_listView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderCenter_listView.h"
#import "SOrderCenter_listView_header.h"
#import "SOrderCenter_listView_footer.h"
#import "SOrderCenter_listViewCell.h"

#import "SCarOrderOrderList.h"//汽车购
#import "SHouseOrderOrderList.h"//房产购
#import "SOrderOrderList.h"//普通商品
#import "SGroupBuyOrderOrderList.h"//拼单购
#import "SPreOrderPreOrderList.h"//无界预购
#import "SIntegralOrderOrderList.h"//积分抽奖
#import "SAuctionOrderOrderList.h"//比价购
#import "SIntegralBuyOrderOrderList.h"//无界商店
#import "SgiftOderListModel.h"
@interface SOrderCenter_listView () <UITableViewDelegate,UITableViewDataSource>
{
    NSString * type;//文字类型
    NSArray * thisArr;
  //  BOOL   is399Normal;
}
@end
@implementation SOrderCenter_listView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOrderCenter_listView" owner:self options:nil];
        [self addSubview:_thisView];
        
        [_mTable registerNib:[UINib nibWithNibName:@"SOrderCenter_listViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOrderCenter_listViewCell"];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
//-(void)setIs_399:(BOOL)Is_399
//{
//    _Is_399=Is_399;
//     [_mTable reloadData];
//}
//- (void)showCarModel:(NSArray *)arr andType:(NSString *)thisType is399:(BOOL)is399Nor
//{
//    type = thisType;
//    thisArr = arr;
//    is399Normal=is399Nor;
//    [_mTable reloadData];
//
//}
- (void)showCarModel:(NSArray *)arr andType:(NSString *)thisType{
    type = thisType;
    thisArr = arr;
  //  is399=_Is_399;
    [_mTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([type isEqualToString:@"汽车购"] || [type isEqualToString:@"房产购"] || [type isEqualToString:@"普通商品"] || [type isEqualToString:@"拼单购"] || [type isEqualToString:@"无界预购"] || [type isEqualToString:@"积分抽奖"]|| [type isEqualToString:@"赠品专区"]) {
        return thisArr.count;
    }
    return thisArr.count;//比价购
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([type isEqualToString:@"汽车购"] || [type isEqualToString:@"房产购"]) {
        return 1;
    }
    if ([type isEqualToString:@"普通商品"]) {
        SOrderOrderList * list = thisArr[section];
        return list.order_goods.count;
    }
    if ([type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderOrderList * list = thisArr[section];
        return list.order_goods.count;
    }
    if ([type isEqualToString:@"无界预购"]) {
        SPreOrderPreOrderList * list = thisArr[section];
        return list.order_goods.count;
    }
    if ([type isEqualToString:@"积分抽奖"]) {
        return 1;
    }
    if ([type isEqualToString:@"无界商店"]) {
        SIntegralBuyOrderOrderList * list = thisArr[section];
        return list.order_goods.count;
    }
    if ([type isEqualToString:@"赠品专区"]) {
        SgiftOderListModel * list = thisArr[section];
        return list.order_goods.count;
    }
    SAuctionOrderOrderList * list = thisArr[section];
    return list.order_goods.count;//比价购、比价购纪录
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SOrderCenter_listView_header * header = [[SOrderCenter_listView_header alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    
    
    if ([type isEqualToString:@"汽车购"]) {
        SCarOrderOrderList * list = thisArr[section];
        header.thisTitle.text = list.shop_name;
        if ([list.status isEqualToString:@"0"]) {
            header.thisType.text = @"待付款";
        } else if ([list.status isEqualToString:@"1"]) {
            header.thisType.text = @"办理手续中";
        } else if ([list.status isEqualToString:@"2"]) {
            header.thisType.text = @"待评价";
        } else if ([list.status isEqualToString:@"4"]) {
            header.thisType.text = @"已完成";
        } else if ([list.status isEqualToString:@"5"]) {
            header.thisType.text = @"已取消";
        }
        [header.mapBtn addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [header.mapBtn setTag:section];
    } else if ([type isEqualToString:@"房产购"]) {
        SHouseOrderOrderList * list = thisArr[section];
        header.thisTitle.text = list.house_name;
        if ([list.status isEqualToString:@"0"]) {
            header.thisType.text = @"待付款";
        } else if ([list.status isEqualToString:@"1"]) {
            header.thisType.text = @"办理手续中";
        } else if ([list.status isEqualToString:@"2"]) {
            header.thisType.text = @"待评价";
        } else if ([list.status isEqualToString:@"4"]) {
            header.thisType.text = @"已完成";
        } else if ([list.status isEqualToString:@"5"]) {
            header.thisType.text = @"已取消";
        }
        [header.mapBtn addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [header.mapBtn setTag:section];
    } else if ([type isEqualToString:@"普通商品"]) {
        SOrderOrderList * list = thisArr[section];
        if (list.shop_name!=nil ) {
              header.thisTitle.text =[NSString stringWithFormat:@"%@",list.shop_name] ;
        }
        else
        {
           header.thisTitle.text = list.merchant_name;
        }
        
        if ([list.order_status isEqualToString:@"0"]) {
            header.thisType.text = @"待付款";
        } else if ([list.order_status isEqualToString:@"1"]) {
            header.thisType.text = @"待发货";
        } else if ([list.order_status isEqualToString:@"2"]) {
            header.thisType.text = @"待收货";
        } else if ([list.order_status isEqualToString:@"3"]) {
            header.thisType.text = @"待评价";
        } else if ([list.order_status isEqualToString:@"4"]) {
            header.thisType.text = @"已完成";
        } else if ([list.order_status isEqualToString:@"5"]) {
            header.thisType.text = @"已取消";
        }
        [header.mapBtn addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [header.mapBtn setTag:section];
    } else if ([type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderOrderList * list = thisArr[section];
        header.thisTitle.text = list.merchant_name;
        if ([list.order_status isEqualToString:@"0"]) {
            header.thisType.text = @"待付款";
        } else if ([list.order_status isEqualToString:@"1"]) {
            header.thisType.text = @"拼单中";
        } else if ([list.order_status isEqualToString:@"2"]) {
            header.thisType.text = @"待发货";
        } else if ([list.order_status isEqualToString:@"3"]) {
            header.thisType.text = @"待收货";
        } else if ([list.order_status isEqualToString:@"4"]) {
            header.thisType.text = @"待评价";
        } else if ([list.order_status isEqualToString:@"5"]) {
            header.thisType.text = @"已完成";
        } else if ([list.order_status isEqualToString:@"6"]) {
            header.thisType.text = @"已取消";
        } else if ([list.order_status isEqualToString:@"7"]) {
            header.thisType.text = @"待抽奖";
        } else if ([list.order_status isEqualToString:@"8"]) {
            header.thisType.text = @"未拼成";
        } else if ([list.order_status isEqualToString:@"10"]) {
            header.thisType.text = @"未中奖";
        }
    } else if ([type isEqualToString:@"无界预购"]) {
        SPreOrderPreOrderList * list = thisArr[section];
        header.thisTitle.text = list.merchant_name;
        if ([list.order_status isEqualToString:@"0"]) {
            header.thisType.text = @"预购中";
        } else if ([list.order_status isEqualToString:@"1"]) {
            header.thisType.text = @"待付尾款";
        } else if ([list.order_status isEqualToString:@"2"]) {
            header.thisType.text = @"待发货";
        } else if ([list.order_status isEqualToString:@"3"]) {
            header.thisType.text = @"待收货";
        } else if ([list.order_status isEqualToString:@"4"]) {
            header.thisType.text = @"待评价";
        } else if ([list.order_status isEqualToString:@"5"]) {
            header.thisType.text = @"已完成";
        } else if ([list.order_status isEqualToString:@"6"]) {
            header.thisType.text = @"已取消";
        } else if ([list.order_status isEqualToString:@"7"]) {
            header.thisType.text = @"待付定金";
        }
    } else if ([type isEqualToString:@"积分抽奖"]) {
        header.leftR_www.constant = 0;
        header.leftR_WWW.constant = 0;
        SIntegralOrderOrderList * list = thisArr[section];
        header.thisTitle.text = list.merchant_name;
        if ([list.order_status isEqualToString:@"10"]) {
            header.thisType.text = @"进行中";
        } else if ([list.order_status isEqualToString:@"11"]) {
            header.thisType.text = @"未中奖";
        } else if ([list.order_status isEqualToString:@"12"]) {
            header.thisType.text = @"已中奖";
        } else  {
            header.thisType.text = @"状态有误,请联系客服";
        }
    } else if ([type isEqualToString:@"比价购"]) {
        header.leftR_www.constant = 0;
        header.leftR_WWW.constant = 0;
        SAuctionOrderOrderList * list = thisArr[section];
        header.thisTitle.text = list.merchant_name;
        if ([list.order_status isEqualToString:@"1"]) {
            header.thisType.text = @"待付款";
        } else if ([list.order_status isEqualToString:@"3"]) {
            header.thisType.text = @"待发货";
        } else if ([list.order_status isEqualToString:@"4"]) {
            header.thisType.text = @"待收货";
        } else if ([list.order_status isEqualToString:@"5"]) {
            header.thisType.text = @"已取消";
        } else if ([list.order_status isEqualToString:@"8"]) {
            header.thisType.text = @"待评价";
        } else if ([list.order_status isEqualToString:@"6"]) {
            header.thisType.text = @"已完成";
        }
    } else if ([type isEqualToString:@"比价购纪录"]) {
        header.leftR.image = [UIImage imageNamed:@"灰色时间"];
        header.thisType.hidden = YES;
        header.directR.hidden = YES;
        SAuctionOrderOrderList * list = thisArr[section];
        if ([list.order_status isEqualToString:@"10"]) {
            header.thisType.text = @"竞拍中";
            header.thisTitle.text = [NSString stringWithFormat:@"正在进行 %@ 结束",list.end_time];
        } else if ([list.order_status isEqualToString:@"11"]) {
            header.thisType.text = @"竞拍成功";
        } else if ([list.order_status isEqualToString:@"12"]) {
            header.thisType.text = @"竞拍结束";
        }
    } else if ([type isEqualToString:@"无界商店"]) {
        SIntegralBuyOrderOrderList * list = thisArr[section];
        header.thisTitle.text = list.merchant_name;
        if ([list.order_status isEqualToString:@"0"]) {
            header.thisType.text = @"待付款";
        } else if ([list.order_status isEqualToString:@"1"]) {
            header.thisType.text = @"待发货";
        } else if ([list.order_status isEqualToString:@"2"]) {
            header.thisType.text = @"待收货";
        } else if ([list.order_status isEqualToString:@"3"]) {
            header.thisType.text = @"待评价";
        } else if ([list.order_status isEqualToString:@"4"]) {
            header.thisType.text = @"已完成";
        } else if ([list.order_status isEqualToString:@"5"]) {
            header.thisType.text = @"已取消";
        }
    }
    else if ([type isEqualToString:@"赠品专区"]) {
        SgiftOderListModel * list = thisArr[section];
        header.thisTitle.text = list.merchant_name;
        if ([list.order_status isEqualToString:@"0"]) {
            header.thisType.text = @"待付款";
        } else if ([list.order_status isEqualToString:@"1"]) {
            header.thisType.text = @"待发货";
        } else if ([list.order_status isEqualToString:@"2"]) {
            header.thisType.text = @"待收货";
        }
//        else if ([list.order_status isEqualToString:@"3"]) {
//            header.thisType.text = @"待评价";
//        }
        else if ([list.order_status isEqualToString:@"4"]) {
            header.thisType.text = @"已完成";
        } else if ([list.order_status isEqualToString:@"5"]) {
            header.thisType.text = @"已取消";
        }
    }
    return header;
}
- (void)mapBtnClick:(UIButton *)btn {
    if ([type isEqualToString:@"汽车购"]) {
        SCarOrderOrderList * list = thisArr[btn.tag];
        if (self.SOrderCenter_listView_map) {
            self.SOrderCenter_listView_map(list.shop_name,list.lng,list.lat);
        }
    } else if ([type isEqualToString:@"房产购"]) {
        SHouseOrderOrderList * list = thisArr[btn.tag];
        if (self.SOrderCenter_listView_map) {
            self.SOrderCenter_listView_map(list.house_name,list.lng,list.lat);
        }
    } else if ([type isEqualToString:@"普通商品"]) {
        SOrderOrderList * list = thisArr[btn.tag];
       if (![list.order_type isEqualToString:@"12"]) {
             if (self.SOrderCenter_listView_map) {
                 self.SOrderCenter_listView_map(list.merchant_id,@"普通商品",@"");
             }
      }
        
       
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([type isEqualToString:@"汽车购"]) {
        SCarOrderOrderList * list = thisArr[section];
        if ([list.status isEqualToString:@"0"]) {
            return 100;
        } else if ([list.status isEqualToString:@"1"]) {
            return 50;
        } else if ([list.status isEqualToString:@"2"]) {
            return 100;
        } else if ([list.status isEqualToString:@"4"]) {
            return 100;
        } else if ([list.status isEqualToString:@"5"]) {
            return 100;
        }
    } else if ([type isEqualToString:@"房产购"]) {
        SHouseOrderOrderList * list = thisArr[section];
        if ([list.status isEqualToString:@"0"]) {
            return 100;
        } else if ([list.status isEqualToString:@"1"]) {
            return 50;
        } else if ([list.status isEqualToString:@"2"]) {
            return 100;
        } else if ([list.status isEqualToString:@"4"]) {
            return 100;
        } else if ([list.status isEqualToString:@"5"]) {
            return 100;
        }
    } else if ([type isEqualToString:@"普通商品"]) {
        SOrderOrderList * list = thisArr[section];
        if ([list.order_status isEqualToString:@"0"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"1"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"2"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"3"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"4"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"5"]) {
            return 100;
        }
    } else if ([type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderOrderList * list = thisArr[section];
        if ([list.order_status isEqualToString:@"0"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"1"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"2"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"3"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"4"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"5"]) {
            //已完成隐藏删除按钮 50 显示 100
            return 50;
        } else if ([list.order_status isEqualToString:@"6"]) {
            return 100;
        }else if ([list.order_status isEqualToString:@"10"]) {
            /*
             *体验拼单,未中奖的订单,设置downview的高度,不显示"删除订单"按钮
             */
//            return 100;
            return 50.0f;
        }
    } else if ([type isEqualToString:@"无界预购"]) {
        SPreOrderPreOrderList * list = thisArr[section];
        if ([list.order_status isEqualToString:@"0"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"1"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"2"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"3"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"4"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"5"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"6"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"7"]) {
            return 100;
        }
    } else if ([type isEqualToString:@"积分抽奖"]) {
        SIntegralOrderOrderList * list = thisArr[section];
        if ([list.order_status isEqualToString:@"10"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"11"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"12"]) {
            return 100;
        } else {
            return 50;
        }
    } else if ([type isEqualToString:@"比价购"]) {
        SAuctionOrderOrderList * list = thisArr[section];
        if ([list.order_status isEqualToString:@"1"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"3"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"4"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"5"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"7"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"8"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"13"]) {
            return 100;
        }
    } else if ([type isEqualToString:@"无界商店"]) {
        SIntegralBuyOrderOrderList * list = thisArr[section];
        if ([list.order_status isEqualToString:@"0"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"1"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"2"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"3"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"4"]) {
            return 50; //100 50
        } else if ([list.order_status isEqualToString:@"5"]) {
            return 100;
        }
    }
    else if ([type isEqualToString:@"赠品专区"]) {
        SgiftOderListModel * list = thisArr[section];
        if ([list.order_status isEqualToString:@"0"]) {
            return 100;
        } else if ([list.order_status isEqualToString:@"1"]) {
            return 50;
        } else if ([list.order_status isEqualToString:@"2"]) {
            return 50;
        }
//        else if ([list.order_status isEqualToString:@"3"]) {
//            return 100;
//        }
        else if ([list.order_status isEqualToString:@"4"]) {
            return 50; //100 50
        } else if ([list.order_status isEqualToString:@"5"]) {
            return 100;
        }
    }
    return 50;//比价购纪录
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SOrderCenter_listView_footer * footer = [[SOrderCenter_listView_footer alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    
    footer.thisType.hidden = YES;
    footer.thisPro.hidden = YES;
    footer.thisPro_num.hidden = YES;
    footer.thisPro_title.hidden = YES;
    [footer.oneBtn addTarget:self action:@selector(oneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footer.twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footer.oneBtn setTag:section];
    [footer.twoBtn setTag:section];
    
    if ([type isEqualToString:@"汽车购"]) {
        SCarOrderOrderList * list = thisArr[section];
        footer.thisContent.text = [NSString stringWithFormat:@"总计:￥%@",list.order_price];
        
        if ([list.status isEqualToString:@"0"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        } else if ([list.status isEqualToString:@"1"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.status isEqualToString:@"2"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
        } else if ([list.status isEqualToString:@"4"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.status isEqualToString:@"5"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }
        
    } else if ([type isEqualToString:@"房产购"]) {
        SHouseOrderOrderList * list = thisArr[section];
        footer.thisContent.text = [NSString stringWithFormat:@"总计:￥%@",list.order_price];
        
        if ([list.status isEqualToString:@"0"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        } else if ([list.status isEqualToString:@"1"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.status isEqualToString:@"2"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
        } else if ([list.status isEqualToString:@"4"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.status isEqualToString:@"5"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }
        
    } else if ([type isEqualToString:@"普通商品"]) {
        SOrderOrderList * list = thisArr[section];
        NSInteger order_num = 0;
        for (SOrderOrderList * list_sub in list.order_goods) {
            order_num += [list_sub.goods_num integerValue];
        }
        footer.thisContent.text = [NSString stringWithFormat:@"共%zd件商品 合计:￥%@ 运费:%@",order_num,list.order_price,[list.freight floatValue] < 0.01 ? @"包邮" : [NSString stringWithFormat:@"%@元",list.freight]];

        if ([list.order_status isEqualToString:@"0"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"1"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.order_status isEqualToString:@"2"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
//            [footer.twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"3"]) {
            if ([list.apply_id isEqualToString:@"0"]&&[list.order_type isEqualToString:@"7"]) {
                  footer.oneBtn.hidden = NO;
                  [footer.oneBtn setTitle:@"去寄售" forState:UIControlStateNormal];
            }
            else
            {
                footer.oneBtn.hidden = YES;
            }
          
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
          
            [footer.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"4"]) {
          //  NSLog(@"dsssd");
            if ([list.apply_id isEqualToString:@"0"]&&[list.order_type isEqualToString:@"7"]) {
                footer.oneBtn.hidden = NO;
                [footer.oneBtn setTitle:@"去寄售" forState:UIControlStateNormal];
            }
            else
            {
                footer.oneBtn.hidden = YES;
            }
         
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"5"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }
    } else if ([type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderOrderList * list = thisArr[section];
        NSInteger order_num = 0;
        for (SGroupBuyOrderOrderList * list_sub in list.order_goods) {
            order_num += [list_sub.goods_num integerValue];
        }
        footer.thisContent.text = [NSString stringWithFormat:@"共%zd件商品 合计:￥%@ 运费:%@",order_num,list.order_price,[list.freight floatValue] < 0.01 ? @"包邮" : [NSString stringWithFormat:@"%@元",list.freight]];
        
        if ([list.order_status isEqualToString:@"0"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"1"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.order_status isEqualToString:@"2"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.order_status isEqualToString:@"3"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
//            [footer.twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"4"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"5"]) {
            footer.oneBtn.hidden = YES;
            //已完成状态隐藏删除按钮
            footer.twoBtn.hidden = !NO;
            footer.downView.hidden = !NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 50); //100
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"6"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"10"]){
            /*
             *体验拼单未中奖的订单,不显示"删除订单"按钮
             */
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }else if ([list.order_status isEqualToString:@"7"] || [list.order_status isEqualToString:@"8"]) {
            //待抽奖 或 未中奖 或 未拼成
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        }
    } else if ([type isEqualToString:@"无界预购"]) {
        SPreOrderPreOrderList * list = thisArr[section];
        NSInteger order_num = 0;
        for (SPreOrderPreOrderList * list_sub in list.order_goods) {
            order_num += [list_sub.goods_num integerValue];
        }
        footer.thisType.hidden = NO;
        if ([list.order_status isEqualToString:@"0"] || [list.order_status isEqualToString:@"7"]) {
            footer.thisType.text = @"一阶段";
        } else {
            footer.thisType.text = @"二阶段";
        }
        footer.thisContent.text = [NSString stringWithFormat:@"共%zd件商品 合计:￥%@ 运费:%@",order_num,list.order_price,[list.freight floatValue] < 0.01 ? @"包邮" : [NSString stringWithFormat:@"%@元",list.freight]];
        
        if ([list.order_status isEqualToString:@"0"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.order_status isEqualToString:@"1"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"2"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.order_status isEqualToString:@"3"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
//            [footer.twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"4"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"5"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"6"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"7"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        }
    } else if ([type isEqualToString:@"积分抽奖"]) {
        SIntegralOrderOrderList * list = thisArr[section];
        footer.thisContent.text = [NSString stringWithFormat:@"共%@人次 合计:￥%@",list.goods_num,list.order_price];
        
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总需%@人/剩余%zd人",list.all_num,[list.all_num integerValue] - [list.add_num integerValue]]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2 + list.all_num.length + 4, [NSString stringWithFormat:@"%zd",[list.all_num integerValue] - [list.add_num integerValue]].length)];
        footer.thisPro_title.attributedText = AttributedStr;
        footer.thisPro_num.text = [NSString stringWithFormat:@"%.2f%%",[list.add_num floatValue]/[list.all_num floatValue]];
        [footer.thisPro setProgress:[list.add_num floatValue]/[list.all_num floatValue]];
        
        
        footer.oneBtn.hidden = YES;
        
        if ([list.order_status isEqualToString:@"10"]) {
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.thisPro.hidden = NO;
            footer.thisPro_num.hidden = NO;
            footer.thisPro_title.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"追加" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"11"]) {
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.thisPro.hidden = YES;
            footer.thisPro_num.hidden = YES;
            footer.thisPro_title.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"12"]) {
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.thisPro.hidden = YES;
            footer.thisPro_num.hidden = YES;
            footer.thisPro_title.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else {
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        }
    } else if ([type isEqualToString:@"比价购"]) {
        SAuctionOrderOrderList * list = thisArr[section];
        footer.thisContent.text = [NSString stringWithFormat:@"共%@件商品 合计:￥%@ 运费:%@",@"1",list.order_price,[list.freight floatValue] < 0.01 ? @"包邮" : [NSString stringWithFormat:@"%@元",list.freight]];
        if ([list.order_status isEqualToString:@"1"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"3"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.order_status isEqualToString:@"4"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
//            [footer.twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"5"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"7"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"8"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"13"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }
    } else if ([type isEqualToString:@"比价购纪录"]) {
        footer.oneBtn.hidden = YES;
        footer.twoBtn.hidden = NO;
        footer.topView.hidden = YES;
        footer.topView_HHH.constant = 0;
        footer.frame = CGRectMake(0, 0, ScreenW, 50);
        [footer.twoBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    } else if ([type isEqualToString:@"无界商店"]) {
        SIntegralBuyOrderOrderList * list = thisArr[section];
        NSInteger order_num = 0;
        for (SIntegralBuyOrderOrderList * list_sub in list.order_goods) {
            order_num += [list_sub.goods_num integerValue];
        }
        footer.thisContent.text = [NSString stringWithFormat:@"共%zd件商品 合计:%@积分 运费:%@",order_num,list.order_price,[list.freight floatValue] < 0.01 ? @"包邮" : [NSString stringWithFormat:@"%@元",list.freight]];
        
        if ([list.order_status isEqualToString:@"0"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"1"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.order_status isEqualToString:@"2"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
//            [footer.twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"3"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"4"]) {
            footer.oneBtn.hidden = YES;
            //隐藏删除按钮    100 50
            footer.twoBtn.hidden = !NO;
            footer.downView.hidden = !NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"5"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }
    }
    else if ([type isEqualToString:@"赠品专区"])
    {
        SgiftOderListModel * list = thisArr[section];
        NSInteger order_num = 0;
        for (SgiftOderListModel * list_sub in list.order_goods) {
            order_num += [list_sub.goods_num integerValue];
        }
        footer.thisContent.text = [NSString stringWithFormat:@"共%zd件商品 合计:%@赠品券 运费:%@",order_num,list.use_voucher,[list.freight floatValue] < 0.01 ? @"包邮" : [NSString stringWithFormat:@"%@元",list.freight]];
        
        if ([list.order_status isEqualToString:@"0"]) {
            footer.oneBtn.hidden = NO;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [footer.twoBtn setTitle:@"付款" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"1"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
        } else if ([list.order_status isEqualToString:@"2"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = YES;
            footer.downView.hidden = YES;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
            //            [footer.twoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        }
//        else if ([list.order_status isEqualToString:@"3"]) {
//            footer.oneBtn.hidden = YES;
//            footer.twoBtn.hidden = NO;
//            footer.downView.hidden = NO;
//            footer.frame = CGRectMake(0, 0, ScreenW, 100);
//            [footer.twoBtn setTitle:@"评价" forState:UIControlStateNormal];
//        }
        else if ([list.order_status isEqualToString:@"4"]) {
            footer.oneBtn.hidden = YES;
            //隐藏删除按钮    100 50
            footer.twoBtn.hidden = !NO;
            footer.downView.hidden = !NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 50);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([list.order_status isEqualToString:@"5"]) {
            footer.oneBtn.hidden = YES;
            footer.twoBtn.hidden = NO;
            footer.downView.hidden = NO;
            footer.frame = CGRectMake(0, 0, ScreenW, 100);
            [footer.twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }
    }
    
    return footer;
}
- (void)oneBtnClick:(UIButton *)btn {
    if ([type isEqualToString:@"汽车购"]) {
        if (self.SOrderCenter_listView_oneBtn) {
            SCarOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_oneBtn(btn,list.order_id,nil);
        }
    } else if ([type isEqualToString:@"房产购"]) {
        if (self.SOrderCenter_listView_oneBtn) {
            SHouseOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_oneBtn(btn,list.order_id,nil);
        }
    } else if ([type isEqualToString:@"普通商品"]) {
        if (self.SOrderCenter_listView_oneBtn) {
            SOrderOrderList * list = thisArr[btn.tag];
            if ([list.apply_id isEqualToString:@"0"]&&[list.order_type isEqualToString:@"7"]) {
   self.SOrderCenter_listView_oneBtn(btn,list.order_id,list.goods_id);
            }
            else
            {
             self.SOrderCenter_listView_oneBtn(btn,list.order_id,nil);
            }
        }
    } else if ([type isEqualToString:@"拼单购"]) {
        if (self.SOrderCenter_listView_oneBtn) {
            SGroupBuyOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_oneBtn(btn,list.group_buy_order_id,nil);
        }
    } else if ([type isEqualToString:@"无界预购"]) {
        if (self.SOrderCenter_listView_oneBtn) {
            SPreOrderPreOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_oneBtn(btn,list.order_id,nil);
        }
    } else if ([type isEqualToString:@"积分抽奖"]) {
        if (self.SOrderCenter_listView_oneBtn) {
            SIntegralOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_oneBtn(btn,list.order_id,nil);
        }
    } else if ([type isEqualToString:@"比价购"]||[type isEqualToString:@"比价购纪录"]) {
        if (self.SOrderCenter_listView_oneBtn) {
            SAuctionOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_oneBtn(btn,list.order_id,nil);
        }
    } else if ([type isEqualToString:@"无界商店"]) {
        if (self.SOrderCenter_listView_oneBtn) {
            SIntegralBuyOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_oneBtn(btn,list.order_id,nil);
        }
    }
    else if ([type isEqualToString:@"赠品专区"]) {
        if (self.SOrderCenter_listView_oneBtn) {
            SgiftOderListModel * list = thisArr[btn.tag];
            self.SOrderCenter_listView_oneBtn(btn,list.order_id,nil);
        }
    }
    
}
- (void)twoBtnClick:(UIButton *)btn {
    if ([type isEqualToString:@"汽车购"]) {
        if (self.SOrderCenter_listView_twoBtn) {
            SCarOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_twoBtn(btn,list.order_id,@"",@"",@"",@"");
        }
    } else if ([type isEqualToString:@"房产购"]) {
        if (self.SOrderCenter_listView_twoBtn) {
            SHouseOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_twoBtn(btn,list.order_id,@"",@"",@"",@"");
        }
    } else if ([type isEqualToString:@"普通商品"]) {
        if (self.SOrderCenter_listView_twoBtn) {
            SOrderOrderList * list = thisArr[btn.tag];
        self.SOrderCenter_listView_twoBtn(btn,list.order_id,@"",list.order_type,@"",@"");
        }
    } else if ([type isEqualToString:@"拼单购"]) {
        if (self.SOrderCenter_listView_twoBtn) {
            SGroupBuyOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_twoBtn(btn,list.group_buy_order_id,list.group_buy_id,list.order_type,list.freight,@"");
        }
    } else if ([type isEqualToString:@"无界预购"]) {
        if (self.SOrderCenter_listView_twoBtn) {
            SPreOrderPreOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_twoBtn(btn,list.order_id,@"",@"",@"",@"");
        }
    } else if ([type isEqualToString:@"积分抽奖"]) {
        if (self.SOrderCenter_listView_twoBtn) {
            SIntegralOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_twoBtn(btn,list.order_id,list.goods_id,list.product_id,list.order_goods.shop_price,list.order_goods.pic);
        }
    } else if ([type isEqualToString:@"比价购"]||[type isEqualToString:@"比价购纪录"]) {
        if (self.SOrderCenter_listView_twoBtn) {
            SAuctionOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_twoBtn(btn,list.order_id,@"",list.buy_type,@"",@"");
        }
    } else if ([type isEqualToString:@"无界商店"]) {
        if (self.SOrderCenter_listView_twoBtn) {
            SIntegralBuyOrderOrderList * list = thisArr[btn.tag];
            self.SOrderCenter_listView_twoBtn(btn,list.order_id,@"",@"",list.freight,@"");
        }
    }
    else if ([type isEqualToString:@"赠品专区"]) {
        if (self.SOrderCenter_listView_twoBtn) {
            SgiftOderListModel * list = thisArr[btn.tag];
            self.SOrderCenter_listView_twoBtn(btn,list.order_id,@"",@"",list.freight,@"");
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SOrderCenter_listViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SOrderCenter_listViewCell" forIndexPath:indexPath];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([type isEqualToString:@"汽车购"]) {
        SCarOrderOrderList * list = thisArr[indexPath.section];
        [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list.car_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = list.car_name;
        cell.pre_money.text = [NSString stringWithFormat:@"￥%@",list.pre_money];
        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list.num];
        cell.thisType.text = [NSString stringWithFormat:@"可抵:￥%@车款",list.true_pre_money];
    } else if ([type isEqualToString:@"房产购"]) {
        SHouseOrderOrderList * list = thisArr[indexPath.section];
        [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list.house_style_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = [NSString stringWithFormat:@"%@ %@",list.style_name,list.tags];
        cell.pre_money.text = [NSString stringWithFormat:@"￥%@",list.pre_money];
        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list.num];
        cell.thisType.text = [NSString stringWithFormat:@"可抵:￥%@房款",list.true_pre_money];
    } else if ([type isEqualToString:@"普通商品"]) {
        SOrderOrderList * list = thisArr[indexPath.section];
        SOrderOrderList * list_sub = list.order_goods[indexPath.row];
       [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list_sub.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = list_sub.goods_name;
        
        cell.pre_money.text = [NSString stringWithFormat:@"￥%@",list_sub.shop_price];
        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list_sub.goods_num];
        NSLog(@"%@",list_sub.is_active);
        if ([list_sub.is_active isEqualToString:@"5"]) {
            cell.onTrialImageView.hidden = NO;
            cell.onTrialImageView.image=[UIImage imageNamed:@"爆款-flag"];
            CGAffineTransform transform= CGAffineTransformMakeRotation(-M_PI*0.2);
            cell.onTrialImageView.transform = transform;//旋转
        }else{
            cell.onTrialImageView.hidden = YES;
        }
        if ([list.order_type isEqualToString:@"13"]) {
            cell.view_2980.hidden=NO;
            cell.lab_flag.text=@"2980";
            cell.thisType.text = list_sub.goods_attr;
        }
        
        else if ([list_sub.is_active isEqualToString:@"2"])
        {
             cell.view_2980.hidden=NO;
             cell.lab_flag.text=@"399";
            //规格 + 赠送积分
            if (list_sub.return_integral == nil || [list_sub.return_integral isEqualToString:@""]||[list_sub.return_integral doubleValue]==0) {
                cell.thisType.text = list_sub.goods_attr;
            } else {
                
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",list_sub.goods_attr,list_sub.return_integral]];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(list_sub.goods_attr.length , 7 + list_sub.return_integral.length)];
                cell.thisType.attributedText = AttributedStr;
            }
        }
        else
        {
            cell.view_2980.hidden=YES;
                    //规格 + 赠送积分
                    if (list_sub.return_integral == nil || [list_sub.return_integral isEqualToString:@""]||[list_sub.return_integral doubleValue]==0) {
                        cell.thisType.text = list_sub.goods_attr;
                    } else {
                        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",list_sub.goods_attr,list_sub.return_integral]];
                        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(list_sub.goods_attr.length , 7 + list_sub.return_integral.length)];
                        cell.thisType.attributedText = AttributedStr;}
        }
        
    } else if ([type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderOrderList * list = thisArr[indexPath.section];
        SGroupBuyOrderOrderList * list_sub = list.order_goods[indexPath.row];
        /*
         *添加体验拼单商品提示
         */
        if ([list.group_type isEqualToString:@"1"]) {
            cell.onTrialImageView.hidden = NO;
        }else{
            cell.onTrialImageView.hidden = YES;
        }
        
        [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list_sub.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = list_sub.goods_name;
        cell.pre_money.text = [NSString stringWithFormat:@"￥%@",list_sub.shop_price];
        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list_sub.goods_num];

        //规格 + 赠送积分
        if (list_sub.return_integral == nil || [list_sub.return_integral isEqualToString:@""]||[list_sub.return_integral doubleValue]==0) {
            cell.thisType.text = list_sub.goods_attr;
        } else {
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",list_sub.goods_attr,list_sub.return_integral]];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(list_sub.goods_attr.length , 7 + list_sub.return_integral.length)];
            cell.thisType.attributedText = AttributedStr;
        }
    } else if ([type isEqualToString:@"无界预购"]) {
        SPreOrderPreOrderList * list = thisArr[indexPath.section];
        SPreOrderPreOrderList * list_sub = list.order_goods[indexPath.row];
        [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list_sub.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = list_sub.goods_name;
        cell.pre_money.text = [NSString stringWithFormat:@"￥%@",list_sub.shop_price];
        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list_sub.goods_num];
        cell.thisType.text = list_sub.goods_attr;
    } else if ([type isEqualToString:@"积分抽奖"]) {
        SIntegralOrderOrderList * list = thisArr[indexPath.section];
//        SIntegralOrderOrderList * list_sub = list.order_goods[indexPath.row];
        [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list.order_goods.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = list.order_goods.goods_name;
        cell.pre_money.text = [NSString stringWithFormat:@"￥%@",list.order_goods.shop_price];
//        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list_sub.goods_num];
//        cell.thisType.text = list_sub.goods_attr;

        cell.thisNum.hidden = YES;
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"期号:%@\n我已参加:%@人次  查看详情",list.time_num,list.goods_num]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3 + list.time_num.length + 5 + list.goods_num.length + 5, 4)];
        cell.thisType.attributedText = AttributedStr;
    } else if ([type isEqualToString:@"比价购"]) {
        SAuctionOrderOrderList * list = thisArr[indexPath.section];
        SAuctionOrderOrderList * list_sub = list.order_goods[indexPath.row];
        [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list_sub.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = list_sub.goods_name;
//        cell.pre_money.text = [NSString stringWithFormat:@"￥%@",list_sub.shop_price];
        cell.pre_money.hidden = YES;
//        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list_sub.goods_num];
        cell.thisNum.hidden = YES;
        cell.thisType.text = list_sub.goods_attr;
    } else if ([type isEqualToString:@"比价购纪录"]) {
        SAuctionOrderOrderList * list = thisArr[indexPath.section];
        SAuctionOrderOrderList * list_sub = list.order_goods[indexPath.row];
        cell.thisNum.hidden = YES;
        cell.thisType.text = [NSString stringWithFormat:@"起拍价 ￥%@",list.start_price];
        cell.thisType.textColor = [UIColor redColor];
        [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list_sub.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = list_sub.goods_name;
        cell.pre_money.hidden = YES;
    } else if ([type isEqualToString:@"无界商店"]) {
        SIntegralBuyOrderOrderList * list = thisArr[indexPath.section];
        SIntegralBuyOrderOrderList * list_sub = list.order_goods[indexPath.row];
        [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list_sub.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = list_sub.goods_name;
        cell.pre_money.text = [NSString stringWithFormat:@"%@积分",list.shop_price];
        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list.goods_num];
////        cell.thisType.text = list_sub.goods_attr;
//        cell.thisType.hidden = YES;
        
        //规格 + 赠送积分
        if (list_sub.return_integral == nil || [list_sub.return_integral isEqualToString:@""]||[list_sub.return_integral doubleValue]==0) {
            cell.thisType.text = list_sub.goods_attr;
        } else {
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",list_sub.goods_attr,list_sub.return_integral]];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(list_sub.goods_attr.length , 7 + list_sub.return_integral.length)];
            cell.thisType.attributedText = AttributedStr;
        }
    }
    else if ([type isEqualToString:@"赠品专区"])
    {
        SgiftOderListModel * list = thisArr[indexPath.section];
        SgiftOderListModel * list_sub = list.order_goods[indexPath.row];
       // NSLog(@"AAAA %@",list_sub.goods_name);
        [cell.car_img sd_setImageWithURL:[NSURL URLWithString:list_sub.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.car_name.text = list_sub.goods_name;
        cell.pre_money.text = [NSString stringWithFormat:@"赠品券%@",list_sub.use_voucher];
        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list_sub.goods_num];
        cell.thisType.text = list_sub.goods_attr;
        
//        cell.thisNum.hidden = YES;
//        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"期号:%@\n我已参加:%@人次  查看详情",list.time_num,list.goods_num]];
//        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3 + list.time_num.length + 5 + list.goods_num.length + 5, 4)];
//        cell.thisType.attributedText = AttributedStr;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.SOrderCenter_listView_infor) {
        if ([type isEqualToString:@"汽车购"]) {
            SCarOrderOrderList * list = thisArr[indexPath.section];
            self.SOrderCenter_listView_infor(list.order_id,nil );
        } else if ([type isEqualToString:@"房产购"]) {
            SHouseOrderOrderList * list = thisArr[indexPath.section];
            self.SOrderCenter_listView_infor(list.order_id,nil);
        } else if ([type isEqualToString:@"普通商品"]) {
            SOrderOrderList * list = thisArr[indexPath.section];
          self.SOrderCenter_listView_infor(list.order_id,list.order_type);
          
        } else if ([type isEqualToString:@"拼单购"]) {
            SGroupBuyOrderOrderList * list = thisArr[indexPath.section];
            [list.order_type isEqualToString:@"2"] ? (_p_id = list.group_buy_order_id) : (_p_id = list.p_id);
            _group_buy_type_status = list.group_type;
            _list_group_orders_status = list.order_status;
            SOrderOrderList *list_sub = list.order_goods[0];
            _GivenIntegral = list_sub.return_integral;
            self.SOrderCenter_listView_infor(list.group_buy_order_id,nil);
        } else if ([type isEqualToString:@"无界预购"]) {
            SPreOrderPreOrderList * list = thisArr[indexPath.section];
            self.SOrderCenter_listView_infor(list.order_id,nil);
        } else if ([type isEqualToString:@"积分抽奖"]) {
            SIntegralOrderOrderList * list = thisArr[indexPath.section];
            self.SOrderCenter_listView_infor(list.order_id,nil);
        } else if ([type isEqualToString:@"比价购"] || [type isEqualToString:@"比价购纪录"]) {
            SAuctionOrderOrderList * list = thisArr[indexPath.section];
            self.SOrderCenter_listView_infor(list.order_id,nil);
        } else if ([type isEqualToString:@"无界商店"]) {
            SIntegralBuyOrderOrderList * list = thisArr[indexPath.section];
            self.SOrderCenter_listView_infor(list.order_id,nil);
        }
        else if ([type isEqualToString:@"赠品专区"]) {
            SgiftOderListModel * list = thisArr[indexPath.section];
            self.SOrderCenter_listView_infor(list.order_id,nil);
        }
        else {
            self.SOrderCenter_listView_infor(@"",nil);
        }
    }
}
@end
