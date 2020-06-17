//
//  GoodsManagerItemList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/23.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "GoodsManagerItemList.h"
#import "OsManageListModel.h"
#import "GoodsManagerItemListCell.h"
#import "OsManageCateMoveModel.h"
#import "AddGoodManagerItem.h"
#import "AddGoodManagerEdit_cateModel.h"
@interface GoodsManagerItemList ()<UITableViewDelegate,UITableViewDataSource,AddGoodManagerItemDelegate>
{
    NSArray * arr;
    NSString *name;
    NSString *nameId;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property(nonatomic,strong)NSIndexPath *lastPath1;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bianjiBtnHHH;



@end

@implementation GoodsManagerItemList
-(id)initWithBlock:(finishBlock)ablock
{
    if (self=[super init]) {
        
        _block=[ablock copy];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mTable registerNib:[UINib nibWithNibName:@"GoodsManagerItemListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GoodsManagerItemListCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    
    
   if([_type isEqualToString:@"2"])
   {
      self.title=@"分类管理";
   }
    else
    {
      self.title=@"选择分类";
    }
   
    if ([_type isEqualToString:@"2"]) {
        UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lefthBtn.frame = CGRectMake(0, 0, 44, 30);
        UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
        self.navigationItem.rightBarButtonItem = leftBtnItem;
        [lefthBtn setImage:[UIImage imageNamed:@"删除黑"] forState:UIControlStateNormal];
        lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,15,0,0);
        [lefthBtn addTarget:self action:@selector(delectPress) forControlEvents:UIControlEventTouchUpInside];
        [_bianjiBtn setTitle:@"添加分类" forState:UIControlStateNormal];
    }
    if ([_type isEqualToString:@"3"]) {
      //  _bianjiBtn.hidden=YES ;
     //   _bianjiBtnHHH.constant=0;
        [_bianjiBtn setTitle:@"添加分类" forState:UIControlStateNormal];
    }
    [self getData];
}
-(void)getData
{
    OsManageListModel *model=[[OsManageListModel alloc]init];
    model.type=@"2";
    model.sta_mid=_sta_mid;
    [MBProgressHUD showMessage:nil toView:self.view];
    [model OsManageListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, NSString * _Nonnull nums) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==1) {
            OsManageListModel *model=(OsManageListModel *)data;
            arr = model.data;
            [_mTable reloadData];
        }
        else{
            [MBProgressHUD showError:message toView:self.view];

        }
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];

    }];
}
-(void)delectPress
{
    [self selectGoods];
    if (nameId.length==0) {
        [MBProgressHUD showError:@"请选择一个分类" toView:self.view];
        return;
    }
    AddGoodManagerEdit_cateModel *model=[[AddGoodManagerEdit_cateModel  alloc]init];
    model.id=nameId;
    model.name=name;
    model.is_del=@"1";
    model.sta_mid=_sta_mid;
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [model AddGoodManagerEdit_cateModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==1) {
            [MBProgressHUD showSuccess:@"操作成功" toView:self.view];
            
            [self getData];
          
        }
        
        else
        {
            [MBProgressHUD showSuccess:message toView:self.view];
        }
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
    
    
    OsManageListModel * list = arr[indexPath.row];
    cell.nameLab.text = list.name;
    if (list.isSelect) {
          [cell.contentView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
    else
    {
       [cell.contentView setBackgroundColor:[UIColor clearColor]];
    }
    
    if ([_type isEqualToString:@"2"]) {
        cell.bianjibtn.hidden=NO;
    }
    else
    {
       cell.bianjibtn.hidden=YES;
    }
    cell.model=list;
    __weak typeof(self) weakSelf = self;
    cell.topBtnBlock = ^(OsManageListModel * type) {
        [weakSelf topBtnEvent:type];
    };
    
    
    return cell;
}
- (void)topBtnEvent:(OsManageListModel *)num
{
    AddGoodManagerItem *add=[[AddGoodManagerItem alloc]init];
    add.type=@"2";
    add.model=num;
    add.delgate=self;
    add.sta_mid=_sta_mid;
    [self.navigationController pushViewController:add animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsManagerItemListCell * cell =(GoodsManagerItemListCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    OsManageListModel * list = arr[indexPath.row];
    list.isSelect=YES;
   [cell.contentView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    if ([_type isEqualToString:@"3"]) {
        if (_block)
        {
            _block(list.name,list.id);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
   

}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GoodsManagerItemListCell * cell =(GoodsManagerItemListCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    OsManageListModel * list = arr[indexPath.row];
    list.isSelect=NO;
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    
}
-(void)selectGoods
{
    for (int i=0; i<arr.count; i++) {
            OsManageListModel * model=arr[i];
            if (model.isSelect) {
                name= model.name;
                nameId= model.id;
                
            }
        }    
}
- (IBAction)movePress:(id)sender
{
    if ([_type isEqualToString:@"2"]||[_type isEqualToString:@"3"]) {
        AddGoodManagerItem *add=[[AddGoodManagerItem alloc]init];
        add.type=@"1";
         add.delgate=self;
        add.sta_mid=_sta_mid;
        [self.navigationController pushViewController:add animated:YES];
        
    }
    else
    {
    [self selectGoods];
    
    if (nameId.length==0) {
        [MBProgressHUD showError:@"请选择一个分类" toView:self.view];
        return;
    }
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定移动?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        OsManageCateMoveModel *model=[[OsManageCateMoveModel alloc]init];
        model.cate_id=nameId;
        model.goods_id=_goods_idArr;
        model.type=@"1";
         [MBProgressHUD showMessage:nil toView:self.view];
        [model OsManageCateMoveModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([code intValue]==1) {
                [MBProgressHUD showSuccess:@"移动成功" toView:self.view];
                if (_delgate!=nil &&[_delgate respondsToSelector:@selector(refrechtView:name:)]) {
                    [self.delgate refrechtView:nameId name:name];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                
            }
            else
            {
                [MBProgressHUD showSuccess:@"移动错误，稍后再试" toView:self.view];
            }
            
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];

        }];
        
     
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    }
}
-(void)refrechtView
{
    [self getData];
}

@end
