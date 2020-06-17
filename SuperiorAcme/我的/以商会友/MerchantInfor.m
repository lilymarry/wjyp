//
//  AddBFrient.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "MerchantInfor.h"
#import "MerchantInforCell.h"
#import "SlineDetailWebController.h"
#import "MerchantInforDetail.h"
@interface MerchantInfor ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr;
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation MerchantInfor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    [_mTable registerNib:[UINib nibWithNibName:@"MerchantInforCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MerchantInforCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   
    arr=[NSArray arrayWithObjects:@"头像",@"性别",@"昵称",@"ID",@"地区",@"旗下店铺", nil];
    self.title=@"商友资料";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==5)
        
    {
        return 40;
    }
    else
    {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section==5) {
  
            UIView * timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
            timeView.backgroundColor = [UIColor clearColor];
            
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, ScreenW - 30, 40)];
            [timeView addSubview:name];
            
       
            name.text = @"旗下店铺";
            
            name.textColor = [UIColor blackColor];
            name.font = [UIFont systemFontOfSize:14];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ScreenW, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
          [timeView addSubview:line];
            
            return timeView;
        }
    else
    {
        return nil;
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    return 6;
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==5) {
        return _m_name.count;
    }
    
    else
    {
        return 1;
    }
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return 44;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantInforCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantInforCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text=arr[indexPath.section];
    if (indexPath.section==0) {
        [cell.headIconIma sd_setImageWithURL:[NSURL URLWithString:_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    }
    
    else if (indexPath.section==1)
    {
        cell.nameLab.text=_sex;
    }
    else if (indexPath.section==2)
    {
        cell.nameLab.text=_nickname;
    }
    else if (indexPath.section==3)
    {
        cell.nameLab.text=_id;
    }
    else if (indexPath.section==4)
    {
        cell.nameLab.text=_area;
    }
    else
    {
            cell.nameLab.text=_m_name[indexPath.row];
            cell.titleLab.text=nil;
  
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==5) {
         NSString *idStr=_m_id[indexPath.row];
        NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/offlineShop/referer/1/merchant_id/%@.html", [Url_header isEqualToString:@"api"] ? @"www" : Url_header,idStr];
       
        SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
        conter.urlStr=detail_Base_url;
        conter.fag=@"8";
        conter.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:conter animated:YES];
        
        
    }
   
    
}
- (IBAction)addFriend:(id)sender {
    MerchantInforDetail *detail=[[MerchantInforDetail alloc]init];
    detail.sta_mid=_sta_mid;
    detail.nickname=_nickname;
    detail.bid=_id;
    detail.mid=_merchant_id;
    detail.headIcon=_head_pic;
    [self.navigationController pushViewController:detail animated:YES];
    
}
@end
