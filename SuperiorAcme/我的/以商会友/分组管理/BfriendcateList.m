//
//  Bfriend_cateList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "BfriendcateList.h"
#import "GoodsManagerItemListCell.h"
#import "BfriendcateModel.h"
#import "BfriendcateDetailList.h"
@interface BfriendcateList ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray * arr;//列表
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation BfriendcateList

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mTable registerNib:[UINib nibWithNibName:@"GoodsManagerItemListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GoodsManagerItemListCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self showModel];
    self.title=@"分组管理";
        adjustsScrollViewInsets_NO(_mTable, self);
}
- (void)showModel {
    BfriendcateModel * index = [[BfriendcateModel alloc] init];
    index.t = @"1";
    index.sta_mid=_sta_mid;
    [MBProgressHUD showMessage:nil toView:self.view];
    [index BfriendcateListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            BfriendcateModel * index =(BfriendcateModel *)data;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsManagerItemListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsManagerItemListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    BfriendcateModel * list = arr[indexPath.row];
    cell.nameLab.text = list.name;
    cell.bianjibtn.hidden=YES;
   
    return cell;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        BfriendcateModel * list = arr[indexPath.row];
        BfriendcateModel * index = [[BfriendcateModel alloc] init];
        index.id=list.id;
        index.is_del=@"1";
        index.sta_mid=_sta_mid;
        [MBProgressHUD showMessage:nil toView:self.view];
        [index BfriendcateListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code intValue]==1) {
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
    }];
    //编辑
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        BfriendcateModel * list = arr[indexPath.row];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        
        //在AlertView中添加一个输入框
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.placeholder = @"请输入分组名";
            textField.text=list.name;
            textField.delegate=self;
        }];
        //添加一个取消按钮
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = alertController.textFields.firstObject;
            
            if ( textField.text.length==0) {
                [MBProgressHUD showError:@"请输入分组名称" toView:self.view];
                return ;
            }
            BfriendcateModel * index = [[BfriendcateModel alloc] init];
            index.name =textField.text;
            index.id=list.id;
            index.is_del=@"0";
            index.sta_mid=_sta_mid;
            [MBProgressHUD showMessage:nil toView:self.view];
            [index BfriendcateListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code intValue]==1) {
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
            
        }]];
        //present出AlertView
        [self presentViewController:alertController animated:true completion:nil];
        
        
    }];
    editRowAction.backgroundColor = [UIColor colorWithRed:172/255.0 green:121/255.0 blue:177/255.0 alpha:1];

    return @[deleteRowAction,editRowAction];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BfriendcateModel * list = arr[indexPath.row];
    if ([_type isEqualToString:@"1"]) {
        self.getCateIdBlock(list.id,list.name);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
  
    BfriendcateDetailList *detail=[[BfriendcateDetailList alloc]init];
    detail.idstr=list.id;
    detail.sta_mid=_sta_mid;
    [self.navigationController pushViewController:detail animated:YES];
    }
}
- (IBAction)addBFriendCate:(id)sender {
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"" preferredStyle:UIAlertControllerStyleAlert];
  
    
    //在AlertView中添加一个输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
      
        textField.placeholder = @"请输入分组名";
         textField.delegate=self;
    }];
    //添加一个取消按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields.firstObject;
        
        if ( textField.text.length==0) {
             [MBProgressHUD showError:@"请输入分组名称" toView:self.view];
            return ;
        }
        BfriendcateModel * index = [[BfriendcateModel alloc] init];
        index.name = textField.text;
        index.sta_mid=_sta_mid;
        [MBProgressHUD showMessage:nil toView:self.view];
        [index BfriendcateListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code intValue]==1) {
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
        
    }]];
    //present出AlertView
    [self presentViewController:alertController animated:true completion:nil];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    return YES;
    
}

@end
