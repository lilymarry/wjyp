//
//  AddBFrientList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddBFrientList.h"
#import "AddBFrientListCell.h"
#import "BfmsglistModel.h"
#import "GetBfriendModel.h"
#import "MerchantInfor.h"
#import "OsManagerBflist.h"
@interface AddBFrientList ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr;
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation AddBFrientList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    adjustsScrollViewInsets_NO(_mTable, self);
    
    [_mTable registerNib:[UINib nibWithNibName:@"AddBFrientListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddBFrientListCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self showModel];
    self.title=@"新的好友";
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)showModel {
    BfmsglistModel * index = [[BfmsglistModel alloc] init];
   
    index.sta_mid=_sta_mid;
    [MBProgressHUD showMessage:nil toView:self.view];
    [index BfmsglistModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            BfmsglistModel * index =(BfmsglistModel *)data;
            arr = [NSArray arrayWithArray:index.data];
           
            [_mTable reloadData];
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(void)lefthBtnClick
{
        BOOL isExit=NO;
        for(UIViewController *temp in self.navigationController.viewControllers) {
            if([temp isKindOfClass:[OsManagerBflist class]]){
                isExit=YES;
                [self.navigationController popToViewController:temp animated:YES];
                break;
            }
            
        }
        if(isExit==NO)
        {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 86;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddBFrientListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddBFrientListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     BfmsglistModel * index =arr[indexPath.row];
    
    [cell.headIma sd_setImageWithURL:[NSURL URLWithString:index.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.titleLab.text=index.nickname;
    cell.subTitleLab.text=index.info;
    [cell.but1 addTarget:self action:@selector(but1Press:) forControlEvents:UIControlEventTouchUpInside];
    [cell.but2 addTarget:self action:@selector(but2Press:) forControlEvents:UIControlEventTouchUpInside];
    cell.but1.tag=indexPath.row;
    cell.but2.tag=indexPath.row;
    if ([index.s_name isEqualToString:@"接受"]) {
        [cell.but2 setTitle:@"接受" forState:UIControlStateNormal];
        cell.but2.layer.cornerRadius = 8;
        cell.but2.layer.masksToBounds = YES;
        cell.but2.layer.borderWidth = 1;
        cell.but2.layer.borderColor = [UIColor colorWithRed:240/255.0 green:41/255.0 blue:42/255.0 alpha:1].CGColor;
        [cell.but2 setTitleColor:[UIColor colorWithRed:240/255.0 green:41/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
        
        [cell.but1 setTitle:@"拒绝" forState:UIControlStateNormal];
        cell.but1.hidden=NO;
        [cell.but1 setEnabled:YES];
        
        cell.but1.layer.cornerRadius = 8;
        cell.but1.layer.masksToBounds = YES;
        cell.but1.layer.borderWidth = 1;
        cell.but1.layer.borderColor = [UIColor colorWithRed:255/255.0 green:132/255.0 blue:0/255.0 alpha:1].CGColor;
        [cell.but1 setTitleColor:[UIColor colorWithRed:255/255.0 green:132/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
        
        
    }
    
    else
    {
        [cell.but2 setTitle:index.s_name  forState:UIControlStateNormal];
        cell.but1.hidden=YES ;
        [cell.but2 setEnabled:NO];
        if ([index.s_name isEqualToString:@"等待通过"]) {
            cell.but2.layer.cornerRadius = 8;
            cell.but2.layer.masksToBounds = YES;
            cell.but2.layer.borderWidth = 1;
            cell.but2.layer.borderColor = [UIColor colorWithRed:240/255.0 green:41/255.0 blue:42/255.0 alpha:1].CGColor;
            [cell.but2 setTitleColor:[UIColor colorWithRed:240/255.0 green:41/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
        }
        else
        {
            [cell.but2 setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1]
                            forState:UIControlStateNormal];
            cell.but2.layer.borderColor = [UIColor clearColor].CGColor;
   
        }
    }
   
    
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BfmsglistModel * index =arr[indexPath.row];
    GetBfriendModel *model=[[GetBfriendModel alloc]init];
    model.phone=index.phone;
    model.sta_mid=_sta_mid;
    model.type=@"0";
    [MBProgressHUD showMessage:nil toView:self.view];
    [model GetBfriendModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
      
        if ([code intValue]==1) {
            NSDictionary * list_sub = data[0];
          //  if ([list_sub[@"status"] intValue]!=1) {
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
#pragma mark 同意
-(void)but1Press:(UIButton *)but
{
     BfmsglistModel * index =arr[but.tag];
    [self getBfriendModelWithStatus:@"2" model:index];
    
}
#pragma mark 拒绝
-(void)but2Press:(UIButton *)but
{
      BfmsglistModel * index =arr[but.tag];
      [self getBfriendModelWithStatus:@"1" model:index];
}
-(void)getBfriendModelWithStatus:(NSString *)status model:( BfmsglistModel * )index
{
    GetBfriendModel *model=[[GetBfriendModel alloc]init];
    model.id=index.id;
    model.vinfo=index.info;
    model.status=status;
    model.sta_mid=_sta_mid;
    model.type=@"3";
    [MBProgressHUD showMessage:nil toView:self.view];
    [model GetBfriendModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:message toView:self.view];
        if ([code intValue]==1) {
            [self showModel];
        }
       
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
@end
