//
//  SgiftListTopReusableView1.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/11/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftListTopReusableView1.h"
#import "SgiftListTopView.h"
@implementation SgiftListTopReusableView1

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr =dataArr;
    [self refresPictureView];
}
- (void)refresPictureView
{
    
    for (SgiftListTopView *TopView in _scrollView.subviews) {
        [TopView removeFromSuperview];
    }

    CGFloat  viewWidth =200;
    CGFloat  viewHeight =263;
    _scrollView.contentSize = CGSizeMake((viewWidth+5) *(_dataArr.count+1), 0);
    for (int i = 0 ; i < _dataArr.count; i ++) {
        
     SgiftListTopView *TopView = [[SgiftListTopView alloc] initWithFrame:CGRectMake(5+(5+viewWidth)*i, 0, viewWidth, viewHeight)];
        SgiftListModel *model=_dataArr[i];
        TopView.nameLab.text=model.goods_name;
        [TopView.picImaView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]
                                     placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        if ([model.active_type isEqualToString:@"0"]) {
           TopView.levImagView.image=[UIImage imageNamed:@"fx_icon_chuji"];
            
        }
        else if ([model.active_type isEqualToString:@"1"]) {
            TopView.levImagView.image=[UIImage imageNamed:@"fx_icon_zhongji"];
            
        }
        else {
             TopView.levImagView.image=[UIImage imageNamed:@"fx_icon_gaoji"];
            
        }
        
         TopView.moneyLab.text=[NSString stringWithFormat:@"¥%@",model.shop_price];
         [TopView.giftBtn setTitle:[NSString stringWithFormat:@"送赠品券%@",model.goods_gift] forState:UIControlStateNormal];
       
         UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
         [bt setFrame:TopView.bounds];
         bt.tag = i;
        [bt addTarget:self action:@selector(whenClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [TopView addSubview:bt];

        [_scrollView addSubview:TopView];
    }
   
    
    
}
-(void)whenClick:(id)sender
{
    UIButton *button=(UIButton *)sender;
    
   SgiftListModel *model=_dataArr[button.tag];;

    if(_delegate && [_delegate respondsToSelector:@selector(selectBtnClick:)]){
      
            [_delegate selectBtnClick:model];
        }
}


@end
