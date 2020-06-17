//
//  ShopCodeList.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "ShopCodeList.h"
#import "ShopCodeListCell.h"
@implementation ShopCodeList
{
    UILabel *lab;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        lab=[[UILabel alloc ] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        lab.backgroundColor = [UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentLeft;
      //  lab.textColor=[UIColor lightGrayColor];
        lab.font =  [UIFont fontWithName:@"Arial" size:14.0f];
        lab.text=@"   商户二维码：店铺选择";
        [self addSubview:lab];
  
        _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44)];
        _table.delegate=self;
       _table.dataSource=self;

        [self addSubview:_table];
        UIView *view = [UIView new];
        
        view.backgroundColor = [UIColor clearColor];
        
        [_table setTableFooterView:view];
        
    }
    return self;
}
-(void)reloadTable
{
    if ([_state isEqualToString:@"2"]) {
         lab.text=@"  商家二维码：店铺选择";;
    }
    else if ([_state isEqualToString:@"1"])
    {
         lab.text=@"  收款店铺绑定：店铺选择";
    }
    else
    {
        lab.text=@"  赠送蓝色代金券：店铺选择";
    }
    [_table reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shopArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identfier=@"cell";
    ShopCodeListCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShopCodeListCell" owner:nil options:nil][0];
    }
    cell.lab_tittle.text=_shopArr[indexPath.row][@"merchant_name"];
    [cell.imaView_shopList sd_setImageWithURL:[NSURL URLWithString:_shopArr[indexPath.row][@"logo"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dDelegate respondsToSelector:@selector(selectShopCodeListData:state:)])
    {
        [self.dDelegate selectShopCodeListData:_shopArr[indexPath.row ] state:_state];
        [self removeFromSuperview];
    }
    
    
}
-(void)cancel
{
    [self removeFromSuperview];
    
}
@end
