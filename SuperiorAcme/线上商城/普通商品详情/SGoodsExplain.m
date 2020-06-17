//
//  SGoodsExplain.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/15.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsExplain.h"
#import "SGoodsExplainCell.h"
#import "SGoodsGoodsInfo.h"//普通商品详情、票券区
#import "SLimitBuyLimitBuyInfo.h"//限量购
#import "SGroupBuyGroupBuyInfo.h"//拼单购
#import "SPreBuyPreBuyInfo.h"//无界预购
#import "SIntegralBuyIntegralBuyInfo.h"//无界商店
#import "SAuctionAuctionInfo.h"//竞拍汇
#import "SgiftDetailModel.h"

@interface SGoodsExplain () <UITableViewDataSource,UITableViewDelegate>
{
    NSString * modelType;
    NSString * modelArrType;
    NSArray * modelArr;
}
@property (strong, nonatomic) IBOutlet UILabel *mTitle;
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SGoodsExplain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_mTable registerNib:[UINib nibWithNibName:@"SGoodsExplainCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SGoodsExplainCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)showModel:(NSArray *)arr andType:(NSString *)overType andType:(NSString *)arrType {
    modelArr = arr;
    modelType = overType;
    modelArrType = arrType;
    /*
     *标题显示富文本属性
     */
    if ([arrType containsString:@"span"]) {
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[arrType dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        _mTitle.attributedText = attrStr;
    }else{
        _mTitle.text = arrType;
    }
    [_mTable reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return modelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isTips) {
//        return 40;
        //动态计算高度
        SGroupBuyGroupBuyInfo * list = modelArr[indexPath.row];
        return list.CellHeight;
    }else{
        return 70;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SGoodsExplainCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SGoodsExplainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isTips) {
        cell.separatorLine.hidden = NO;
        cell.imageVIewWidthCons.constant = 0;
    }else{
        cell.separatorLine.hidden = YES;
        cell.imageVIewWidthCons.constant = 20;
    }
    //价钱说明👉价格说明  by_fxg
    if ([modelArrType isEqualToString:@"价格说明"]) {
        
        if (modelType == nil) {
            SGoodsGoodsInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.price_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.price_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        } else if ([modelType isEqualToString:@"限量购"]) {
            SLimitBuyLimitBuyInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.price_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.price_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        } else if ([modelType isEqualToString:@"拼单购"]) {
            SGroupBuyGroupBuyInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.price_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.price_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        } else if ([modelType isEqualToString:@"无界预购"]) {
            SPreBuyPreBuyInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.price_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.price_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        } else if ([modelType isEqualToString:@"无界商店"]) {
            SIntegralBuyIntegralBuyInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.price_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.price_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        }
        else if ([modelType isEqualToString:@"赠品专区"]) {
            SgiftDetailModel * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.price_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.price_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        }
        
    } else {
        if (modelType == nil) {
            SGoodsGoodsInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.server_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.server_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        } else if ([modelType isEqualToString:@"限量购"]) {
            SLimitBuyLimitBuyInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.server_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.server_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        } else if ([modelType isEqualToString:@"拼单购"]) {
            SGroupBuyGroupBuyInfo * list = modelArr[indexPath.row];
            /*
             *设置拼单购中的更多内容的显示,如果是tips的话,只设置cell.thisContent.text,不显示图片
             */
            if (_isTips) {
//                cell.thisContent.text = list.desc;
                cell.thisContent.attributedText = list.attrDesc;
                CGRect textRect = [cell.thisContent.text boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : cell.thisContent.font} context:nil];
                if (textRect.size.height < 40) {
                    list.CellHeight = 40;
                }else{
                    list.CellHeight = textRect.size.height + 15;
                }
            }else{
                [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.server_name,list.desc]];
                [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.server_name.length + 1)];
                cell.thisContent.attributedText = attributedStr_dec;
            }
        } else if ([modelType isEqualToString:@"无界预购"]) {
            SPreBuyPreBuyInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.server_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.server_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        } else if ([modelType isEqualToString:@"无界商店"]) {
            SIntegralBuyIntegralBuyInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.server_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.server_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        } else if ([modelType isEqualToString:@"竞拍汇"]) {
            SAuctionAuctionInfo * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.server_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.server_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        }
        else if ([modelType isEqualToString:@"赠品专区"]) {
            SgiftDetailModel * list = modelArr[indexPath.row];
            
            [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            NSMutableAttributedString * attributedStr_dec = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：%@",list.server_name,list.desc]];
            [attributedStr_dec addAttribute:NSForegroundColorAttributeName value:WordColor range:NSMakeRange(0, list.server_name.length + 1)];
            cell.thisContent.attributedText = attributedStr_dec;
        }
    }
    
    return cell;
}
- (IBAction)backBtn:(UIButton *)sender {
    if (self.SGoodsExplainBack) {
        self.SGoodsExplainBack();
    }
}
@end
