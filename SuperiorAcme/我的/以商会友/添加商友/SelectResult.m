//
//  SelectResult.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "SelectResult.h"
#import "OsManagerBflistCell.h"
#import "GetBfriendModel.h"
#import "MerchantInfor.h"
#import "ExchangeItemModel.h"
@interface SelectResult ()<UITableViewDelegate,UITableViewDataSource>
{

        NSArray * arr;//列表
    

}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SelectResult

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_mTable registerNib:[UINib nibWithNibName:@"OsManagerBflistCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OsManagerBflistCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([_type isEqualToString:@"1"]) {
        [self showModel];
        self.title=@"筛选结果";
    }
    else
    {
        [self getData];
         self.title=@"选择商友";
    }
    adjustsScrollViewInsets_NO(_mTable, self);
}
- (void)showModel {
    GetBfriendModel *model=[[GetBfriendModel alloc]init];
    model.cate_id=_cate_id;
    model.city_id=_city_id;
    model.sta_mid=_sta_mid;
    model.type=@"4";
    [MBProgressHUD showMessage:nil toView:self.view];
    [model GetBfriendModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            
            arr = [NSArray arrayWithArray:data];
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        [_mTable reloadData];
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)getData {
    
    ExchangeItemModel *model=[[ExchangeItemModel alloc]init];
    model.sta_mid=_sta_mid;
    model.type=@"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    [model ExchangeItemModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            
            arr = [NSArray arrayWithArray:data];
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        [_mTable reloadData];
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OsManagerBflistCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OsManagerBflistCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * list_sub = arr[indexPath.row];
    
    [cell.headIma sd_setImageWithURL:[NSURL URLWithString:list_sub[@"head_pic"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.nameLab.text=list_sub[@"nickname"];
    cell.friendLab.hidden=NO;
    if ([list_sub[@"status"] intValue]==1) {
        cell.friendLab.text=@"已为好友";
    }
    else{
        cell.friendLab.text=@"加好友";
    }
    if ([_type isEqualToString:@"1"]) {
        cell.friendLab.hidden=NO;
    }
    else
    {
         cell.friendLab.hidden=YES;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * list_sub = arr[indexPath.row];
    if ([_type isEqualToString:@"1"]) {
    MerchantInfor *add=[[MerchantInfor alloc]init];
    add.head_pic=list_sub[@"head_pic"];
    add.sex=list_sub[@"sex"];
    add.nickname=list_sub[@"nickname"];
    add.id=list_sub[@"id"];
    add.area=list_sub[@"area"];
    add.m_id=list_sub[@"m_id"];
    add.m_name=list_sub[@"m_name"];
    add.merchant_id=list_sub[@"merchant_id"];
    add.sta_mid=_sta_mid;
    [self.navigationController pushViewController:add animated:YES];
        }
    else
    {
        self.uidBlock(list_sub[@"nickname"], list_sub[@"user_id"]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


@end
