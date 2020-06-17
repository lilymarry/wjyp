//
//  BfriendcateDetailList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "BfriendcateDetailList.h"
#import "BfriendcateBfListModel.h"
#import "BfriendcateDetailAddCell.h"
#import "OsManagerBflistCell.h"
#import "GoodsManagerItemListCell.h"
#import "AddBfriendcateList.h"
#import "BfriendcateModel.h"
@interface BfriendcateDetailList ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;//列表
    NSString *nameStr;
    NSString *num;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation BfriendcateDetailList

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mTable registerNib:[UINib nibWithNibName:@"OsManagerBflistCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OsManagerBflistCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"GoodsManagerItemListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GoodsManagerItemListCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"BfriendcateDetailAddCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BfriendcateDetailAddCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    [self showModel];
    self.title=@"分组商友管理";
    adjustsScrollViewInsets_NO(_mTable, self);
}
- (void)showModel {
    BfriendcateBfListModel * index = [[BfriendcateBfListModel alloc] init];
    index.t = @"1";
    index.sta_mid=_sta_mid;
    index.id=_idstr;
    index.type=@"2";
    [MBProgressHUD showMessage:nil toView:self.view];
    [index BfriendcateBfListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            BfriendcateBfListModel * index =(BfriendcateBfListModel *)data;
            arr = [NSArray arrayWithArray:index.data.list];
            nameStr=index.data.data.name;
            num=index.data.data.count;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return arr.count+2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0||section==1) {
     
        
        return 1;
    }
    else
    {
        BfriendcateBfListModel * list = arr[section-2];
        
        return list.list.count;
    }
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    timeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 40)];
    [timeView addSubview:name];
    
    if (section==0) {
          name.text = @"分组名字";
    }else if(section==1) {
       name.text = [NSString stringWithFormat:@"商友数量(%@)",num];
    }
    else
    {
       BfriendcateBfListModel * list = arr[section-2];
       name.text = list.name;
    }
    name.textColor = WordColor;
    name.font = [UIFont systemFontOfSize:14];
    
    return timeView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0||indexPath.section==1) {
         return 44;
    }
    else
    {
        return 60;
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section==0) {
        GoodsManagerItemListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsManagerItemListCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLab.text = nameStr;
        cell.bianjibtn.hidden=YES;
        return cell;
    }
    else if (indexPath.section==1)
    {
        BfriendcateDetailAddCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BfriendcateDetailAddCell" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        OsManagerBflistCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OsManagerBflistCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        BfriendcateBfListModel * list = arr[indexPath.section-2];
        BfriendcateBfListModel * list_sub = list.list[indexPath.row];
        
        [cell.headIma sd_setImageWithURL:[NSURL URLWithString:list_sub.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.nameLab.text=list_sub.nickname;
        
        return cell;
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        
        AddBfriendcateList *list=[[AddBfriendcateList alloc]init];
        list.sta_mid=_sta_mid;
        list.idstr=_idstr;
        list.title=nameStr;
        __weak typeof(self) weakSelf = self;
        list.refrechBlock = ^{
             [weakSelf showModel];
        } ;
        [self.navigationController pushViewController:list animated:YES];
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1||indexPath.section==0) {
        
        return NO;
    }
    else
    {
        return YES;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>1) {
        BfriendcateBfListModel * list = arr[indexPath.section-2];
        BfriendcateBfListModel * list_sub = list.list[indexPath.row];
       
        BfriendcateModel * index = [[BfriendcateModel alloc] init];
        index.id=list_sub.id;
        index.is_del=@"2";
        index.uid=list_sub.uid;
        
        index.sta_mid=_sta_mid;
        [MBProgressHUD showMessage:nil toView:self.view];
        [index BfriendcateListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code intValue]==1) {
                 [MBProgressHUD showSuccess:message toView:self.view];
                [self showModel];
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
    
}


@end
