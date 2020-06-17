//
//  AddShopFriendList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddShopFriendList.h"
#import "AddShopFriendListTopView.h"
#import "AddShopFriendListModel.h"
#import "OsManagerBflistCell.h"
#import "MerchantInfor.h"
#import "GetBfriendModel.h"
#import "SelectArea.h"
@interface AddShopFriendList ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray * arr;//列表
    NSString *search;
    NSArray * cate_dataArr;
   
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation AddShopFriendList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_mTable registerNib:[UINib nibWithNibName:@"OsManagerBflistCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OsManagerBflistCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self showModel];
    self.title=@"添加商友";
    adjustsScrollViewInsets_NO(_mTable, self);
}

- (void)showModel {
    AddShopFriendListModel * index = [[AddShopFriendListModel alloc] init];
   
    index.sta_mid=_sta_mid;
    [MBProgressHUD showMessage:nil toView:self.view];
    [index AddShopFriendListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
   
            arr = [NSArray arrayWithArray:data[@"list"]];
          cate_dataArr=[NSArray arrayWithArray:data[@"cate_data"]];
          
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
          [_mTable reloadData];
    } andFailure:^(NSError *error) {
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0)
        
    {
        return 160;
    }
    else
    {
        return 40;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        AddShopFriendListTopView *topView=[[AddShopFriendListTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 160)];
        topView.searchTf.delegate=self;
        topView.searchTf.text=search;
        [topView.selectBut addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
         return topView;
        
        }

else
{
    
    return nil;
    
}
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
  
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        NSDictionary * list_sub = arr[indexPath.row];
     //   if ([list_sub[@"status"] intValue]!=1) {
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
    //    }
   
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    search=textField.text;
   
    if (search.length==0) {
        [self showModel];
    }
    else
    {
    GetBfriendModel *model=[[GetBfriendModel alloc]init];
    model.phone=search;
    model.sta_mid=_sta_mid;
    model.type=@"0";
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
    
    return YES;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    return YES;
    
}

-(void)selectArea
{
    SelectArea *sl=[[SelectArea alloc]init];
    sl.sta_mid=_sta_mid;
    sl.cate_dataArr=cate_dataArr;
    sl.type=@"1";
    
    [self.navigationController pushViewController:sl animated:YES];
    
}
@end
