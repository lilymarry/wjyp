//
//  AddBfriendcateList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddBfriendcateList.h"
#import "BfriendcateBfListModel.h"
#import "OsManagerBflistCell.h"

@interface AddBfriendcateList ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr;
    NSMutableArray *indexArr;
    NSMutableArray *uidArr;
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation AddBfriendcateList
- (void)viewDidLoad {
    [super viewDidLoad];
    [_mTable registerNib:[UINib nibWithNibName:@"OsManagerBflistCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OsManagerBflistCell"];
    UIBarButtonItem *com=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishSelected)];
    com.tintColor=[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem =com;
    [self showModel];
    _mTable.allowsMultipleSelection=YES;
    indexArr=[NSMutableArray array];
    uidArr=[NSMutableArray array];
    adjustsScrollViewInsets_NO(_mTable, self);
    
}
-(void)finishSelected
{
    if ([uidArr count]==0) {
         [MBProgressHUD showError:@"至少选择一个" toView:self.view];
        return;
    }
    BfriendcateBfListModel * index = [[BfriendcateBfListModel alloc] init];
    index.sta_mid=_sta_mid;
    index.id=_idstr;
    index.type=@"2";
    index.uid=[self getIdStr:uidArr];
    [MBProgressHUD showMessage:nil toView:self.view];
    [index BfriendcateBfListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            self.refrechBlock();
            [self.navigationController popViewControllerAnimated:YES];
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
- (void)showModel {
    BfriendcateBfListModel * index = [[BfriendcateBfListModel alloc] init];
    index.t = @"1";
    index.sta_mid=_sta_mid;
    index.id=_idstr;
    index.type=@"3";
    [MBProgressHUD showMessage:nil toView:self.view];
    [index BfriendcateBfListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            BfriendcateBfListModel * index =(BfriendcateBfListModel *)data;
            arr = [NSArray arrayWithArray:index.data.list];
         
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
    
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
        BfriendcateBfListModel * list = arr[section];
        
        return list.list.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    timeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 40)];
    [timeView addSubview:name];
    
  
        BfriendcateBfListModel * list = arr[section];
        name.text = list.name;
   
    name.textColor = WordColor;
    name.font = [UIFont systemFontOfSize:14];
    
    return timeView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    return 60;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        OsManagerBflistCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OsManagerBflistCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BfriendcateBfListModel * list = arr[indexPath.section];
        BfriendcateBfListModel * list_sub = list.list[indexPath.row];
        
        [cell.headIma sd_setImageWithURL:[NSURL URLWithString:list_sub.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.nameLab.text=list_sub.nickname;
        cell.selectImaView.hidden=NO;
        cell.headImaWWW.constant=30;
    if ([indexArr containsObject:indexPath]) {
         cell.selectImaView.image=[UIImage imageNamed:@"选中"];
    }else{
        cell.selectImaView.image=[UIImage imageNamed:@"未选中"];
    }
    
        return cell;
   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OsManagerBflistCell *cell = (OsManagerBflistCell*)[tableView cellForRowAtIndexPath:indexPath];
    BfriendcateBfListModel * list = arr[indexPath.section];
    BfriendcateBfListModel * list_sub = list.list[indexPath.row];
    cell.selectImaView.image=[UIImage imageNamed:@"选中"];
    [indexArr addObject:indexPath];
    [uidArr addObject:list_sub.uid];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OsManagerBflistCell *cell = (OsManagerBflistCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    BfriendcateBfListModel * list = arr[indexPath.section];
    BfriendcateBfListModel * list_sub = list.list[indexPath.row];
    cell.selectImaView.image=[UIImage imageNamed:@"未选中"];
    
    [indexArr removeObject:indexPath];
    [uidArr removeObject:list_sub.uid];
}
-(NSString *)getIdStr:(NSArray *)idArr
{
    NSMutableString *str =[NSMutableString string];
    for (int i=0; i<idArr.count; i++) {
        [str appendString:idArr[i]];
        if (i<idArr.count-1) {
            [str appendString:@","];
        }
    }
    return str;
}
@end
